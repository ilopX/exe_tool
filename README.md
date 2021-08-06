```dart
import 'dart:io';

import 'package:dart_exe/dart_exe.dart';

void main(List<String> arguments) async {
  final exe = ExeFile(r'd:\downloads\function.exe');
  try {
    final pe = exe.openPE();

    print('Open: ${exe.fileName}');
    print('PE address: 0x${pe.address.pe.toRadixString(16)}');
    print('${pe.machine}');
    print('${pe.magicPE}');
    print('${pe.subsystem}');

    pe.subsystem = Subsystem.GUI;

  } catch (e) {
    stderr.writeln(e);
  }
  finally {
    exe.close();
  }
}
```
### Output:
```
Open: d:\downloads\function.exe
PE address: 0x118
MachineType: 0x8664 (x64)
PESignature: 0x20b (PE+)
Subsystem: 0x2 (GUI)
```
