import 'dart:io';

import 'package:dart_exe/bin_dart_exe.dart';

void main(List<String> arguments) async {
  final cmdArgs = parseArgs(arguments);
  final exe = ExeFile(cmdArgs.fileName);
  try {
    final pe = exe.openPE();
    final isSubsystemChanged = changeSubsystem(cmdArgs, pe);

    print('ExeFile: ${exe.fileName} '
        '${isSubsystemChanged ? greenText('+ changed') : ''}'
        '(${pe.subsystem.title})');

    if (cmdArgs.isShowInfo) {
      printExeInfo(exe.fileName, pe, isSubsystemChanged);
    }
  } catch (e) {
    stderr.writeln(e);
  }
  finally {
    exe.close();
  }
}

Args parseArgs(List<String> arguments) {
  try {
    return Args(arguments);
  } catch(e) {
    stderr.writeln(e);
    exit(-1);
  }
}

bool changeSubsystem(Args cmdArgs, WinPE pe) {
  if (cmdArgs.isSubsystem) {
    final newSubsystem = Subsystem.fromString(cmdArgs.subsystem);
    if (pe.subsystem != newSubsystem) {
      pe.subsystem = newSubsystem;
      return true;
    }
  }
  return false;
}

void printExeInfo(String fileName, WinPE pe, bool isSubsystemChanged) {
  print('0x3c: PE address: ${blueText('${toHex(pe.address.pe)}')}');
  print('${toHex(pe.address.machine)}: ${pe.machine}');
  print('${toHex(pe.address.peType)}: ${pe.peType}');
  print('${toHex(pe.address.subsystem)}: ${pe.subsystem}');
}

String toHex(int address) => '0x${address.toRadixString(16)}';
