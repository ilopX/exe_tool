import 'dart:io';

import 'dart:typed_data';

class IOFile {
  late RandomAccessFile _file;

  void openSync(File file) {
    _file = file.openSync(mode: FileMode.append);
  }

  void setPositionSync(int pos) {
    _file.setPositionSync(pos);
  }

  Uint8List readSync(int count) {
    return _file.readSync(count);
  }

  void writeFromSync(Uint8List bytes) {
    _file.writeFromSync(bytes);
  }

  void closeSync() {
    _file.closeSync();
  }

  int lengthSync() {
    return _file.lengthSync();
  }

  String get path => _file.path;
}
