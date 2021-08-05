import 'dart:io';
import 'uint8_list_tools.dart';

class IOImage {
  final RandomAccessFile _file;

  IOImage(this._file);

  int read({required int address}) {
    _file.setPositionSync(address);
    return _file.readSync(2).toIn16Reversed();
  }

  void write({required int address, required int int16Value}) {
    _file.setPositionSync(address);
    // reverse write
    _file.writeByteSync(int16Value);
    _file.writeByteSync(0);
  }

  String readString({required int address, required int len}) {
    _file.setPositionSync(address);
    return _file.readSync(len).toStringChar();
  }
}
