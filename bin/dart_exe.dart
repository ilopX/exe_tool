import 'dart:io';

import 'package:dart_exe/bin_dart_exe.dart';

void main(List<String> arguments) async {
  final args = parseArgs(arguments);
  final exe = ExeFile(args.fileName);
  try {
    final pe = exe.openPE();
    final isSubsystemChanged = changeSubsystem(args, pe);
    printExeInfo(exe.fileName, pe, isSubsystemChanged);
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

void printExeInfo(String fileName, WinPE pe, bool isSubsystemChanged) {
  print('Open: $fileName');
  print('0x3c: PE address: ${blueText('${toHex(pe.address.pe)}')}');
  print('${toHex(pe.address.machine)}: ${pe.machine}');
  print('${toHex(pe.address.magic)}: ${pe.magicPE}');
  print('${toHex(pe.address.subsystem)}: ${pe.subsystem}${isSubsystemChanged ? greenText(' + changed') : ''}');
}

String toHex(int address) => '0x${address.toRadixString(16)}';
