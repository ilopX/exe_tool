import 'dart:io';

import 'package:dart_exe/dart_exe.dart';
import 'package:dart_exe/src/essential/win_pe.dart';

void main(List<String> arguments) async {
  final args = Args(arguments);
  final exe = ExeFile(args.fileName);
  try {
    final pe = exe.openPE();

    final changed = changeSubsystem(args, pe);

    print('Open: ${exe.fileName}');
    print('PE address: 0x${pe.address.pe.toRadixString(16)}');
    print('${pe.machine}');
    print('${pe.magicPE}');
    print('${pe.subsystem}${changed ? '\x1B[34m - changed\x1B[0m' : ''}');

  } catch (e) {
    stderr.writeln(e);
  }
  finally {
    exe.close();
  }
}

bool changeSubsystem(Args args, WinPE pe) {
  if (args.isSubsystem) {
    final newSubsystem = Subsystem.fromString(args.subsystem);
    if (pe.subsystem != newSubsystem) {
      pe.subsystem = newSubsystem;
      return true;
    }
  }
  return false;
}

class Args {
  Args(List<String> arguments) {
    final arg = arguments.join(' ');

    final match = RegExp(
      r'^ *(subsystem) *= *(GUI|Console) +(.+)$', caseSensitive: false,)
        .allMatches(arg).elementAt(0);

    if (match.groupCount != 3) {
      throw 'Arguments error. '
          'Example: subsystem = GUI d:\\file.exe';
    }

    final flagName = (match.group(1) ?? '').toLowerCase();
    if (flagName != 'subsystem') {
      throw 'Arguments error. First argument should be "subsystem"';
    }

    _subsystem = (match.group(2) ?? '').toLowerCase();
    if (_subsystem != 'gui' && _subsystem != 'console') {
      throw 'Arguments error("$_subsystem"). '
          'Second argument should be "gui" or "console"';
    }

    _fileName = (match.group(3) ?? '');
    if (_fileName == '') {
      throw 'Arguments error. '
          'Third argument should be a file name';
    }
  }

  String get fileName => _fileName;
  bool get isSubsystem => _subsystem != '';
  String get subsystem => _subsystem;

  String _fileName = '';
  String _subsystem = '';
}

