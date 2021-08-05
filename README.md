```dart
import 'dart:io';

import 'package:dart_exe/dart_exe.dart';

void main(List<String> arguments) async {
  final exe = ExeFile(r'd:\downloads\function.exe');
  try {
    final pe = exe.openPE();

    print('Open: ${exe.fileName}');
    print('PE address: 0x${pe.address.pe.toRadixString(16)}');
    print('machine: ${pe.machine}');
    print('peType: ${pe.magicPE}');
    print('subsystem: ${pe.subsystem}');
    
    // !!!! This code rewrite your exe file !!!!
    pe.subsystem = Subsystem.GUI;

  } catch (e) {
    stderr.writeln(e);
  }
  finally {
    exe.close();
  }
}
```
