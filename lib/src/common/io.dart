import 'dart:io';
import 'io_tools.dart';

class IO {
  final RandomAccessFile _file;
  final int _fileSize;

  IO(this._file) : _fileSize = _file.lengthSync();

  int read({required int address}) {
    _checkFileSize(address + 2);

    _file.setPositionSync(address);
    return _file.readSync(2).toIn16Reversed();
  }

  void write({required int address, required int int16Value}) {
    _checkFileSize(address + 2);

    _file.setPositionSync(address);
    _file.writeFromSync(int16Value.toBytes());
  }

  String readString({required int address, required int len}) {
    _checkFileSize(address + len);

    _file.setPositionSync(address);
    return _file.readSync(len).toStringChar();
  }

  void close() {
    _file.closeSync();
  }

  void _checkFileSize(int fileSize) {
    if (_fileSize < fileSize) {
      throw 'File ${_file.path} is not an executable file. '
          '\nCheck file size($_fileSize byte). ';
    }
  }
}
