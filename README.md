# Hide console dart native
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
pub run subsystem=gui showInfo d:\app.exe
```

## Example
```dart
import 'dart:io';

import 'package:dart_exe/dart_exe.dart';

void main(List<String> arguments) async {
  final exe = ExeFile(r'd:\app.exe');
  try {
    final pe = exe.openPE();

    print('Open: ${exe.fileName}');
    print('PE address: 0x${pe.address.pe.toRadixString(16)}');
    print('${pe.machine}');
    print('${pe.peType}');
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
ExeFile: d:\downloads\function.exe + changed(GUI)
0x3c: PE address: 0x118
0x11c: MachineType: 0x8664 (x64)
0x130: PEType: 0x20b (PE+)
0x174: Subsystem: 0x2 (GUI)
```
