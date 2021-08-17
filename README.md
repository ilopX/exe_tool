# Hide console dart native
Makes a non-console Windows application out of an executable file. By patching method

The reason for creating this repository is described here: https://github.com/timsneath/win32/issues/127
## Install
```yaml
dev_dependencies:
  dart_exe:
    git:
      url: https://github.com/ilopX/exe_tool
```

## Run
```batch
dart compile exe app.dart
pub run dart_exe subsystem=gui showInfo d:\app.exe
```

### Output:
```
ExeFile: d:\app.exe + changed(GUI)
0x3c: PE address: 0x118
0x11c: MachineType: 0x8664 (x64)
0x130: PEType: 0x20b (PE+)
0x174: Subsystem: 0x2 (GUI)
```

## Example
```dart
import 'dart:io';

import 'package:dart_exe/dart_exe.dart';

void main(List<String> arguments) async {
  final exe = ExeFile(r'd:\app.exe');
  try {
    final pe = exe.openPE();

    pe.subsystem = Subsystem.GUI;

    print('Open: ${exe.fileName}');
    print('PE address: 0x${pe.address.pe.toRadixString(16)}');
    print('${pe.machine}');
    print('${pe.peType}');

    print('${pe.subsystem}');
  } catch (e) {
    stderr.writeln(e);
  }
  finally {
    exe.close();
  }
}
```
[![DartFlutter runner](https://img.youtube.com/vi/cbjDu0KLzeA/0.jpg)](https://youtu.be/cbjDu0KLzeA?t=39)


