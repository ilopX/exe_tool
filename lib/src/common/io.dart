import 'dart:typed_data';

import 'package:meta/meta.dart';

import '../exceptions/file_not_executable_exception.dart';
import 'io_file.dart';

class IO {
  final IOFile _file;
  final int _fileSize;

  IO(this._file) : _fileSize = _file.lengthSync();

  int read({required int address}) {
    checkFileSize(address + 2);

    _file.setPositionSync(address);
    return _file.readSync(2).toIn16Reversed();
  }

  void write({required int address, required int int16Value}) {
    checkFileSize(address + 2);

    _file.setPositionSync(address);
    _file.writeFromSync(int16Value.toBytes());
  }

  String readString({required int address, required int len}) {
    checkFileSize(address + len);

    _file.setPositionSync(address);
    return _file.readSync(len).toStringChar();
  }

  void close() {
    _file.closeSync();
  }

  @protected
  void checkFileSize(int requestSize) {
    if (_fileSize < requestSize) {
      throw FileNotExecutableException.unavailableSize(
          _file.path,
          _fileSize,
          requestSize,
      );
    }
  }
}

typedef Bytes = Uint8List;

extension Uint8ListTools on Bytes {
  String toStringChar() {
    return map((i) => String.fromCharCode(i)).join();
  }

  int toIn16Reversed() {
    return buffer.asByteData().getUint16(0, Endian.little);
  }
}

extension IOInt on int {
  Bytes toBytes() {
    final bData = ByteData(2)
      ..setInt16(0, this, Endian.little);
    return bData.buffer.asUint8List();
  }
}
