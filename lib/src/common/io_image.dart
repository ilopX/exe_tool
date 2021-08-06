import 'dart:io';
import 'uint8_list_tools.dart';

class IOImage {
  final RandomAccessFile _file;
  final int _fileSize;

  IOImage(this._file) : _fileSize = _file.lengthSync();

  int read({required int address}) {
    _checkFileSize(address + 2);

    _file.setPositionSync(address);
    return _file.readSync(2).toIn16Reversed();
  }

  void write({required int address, required int int16Value}) {
    _checkFileSize(address + 2);

    _file.setPositionSync(address);
    // reverse write
    _file.writeByteSync(int16Value);
    _file.writeByteSync(0);
  }

  String readString({required int address, required int len}) {
    _checkFileSize(address + len);

    _file.setPositionSync(address);
    return _file.readSync(len).toStringChar();
  }

  void _checkFileSize(int fileSize) {
    if (_fileSize < fileSize) {
      throw 'File ${_file.path} is not an executable file. '
          '\nCheck file size($_fileSize byte). ';
    }
  }
}
