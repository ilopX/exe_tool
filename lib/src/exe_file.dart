import 'dart:io';

import 'common/address_book.dart';
import 'common/io_image.dart';
import 'essential/win_pe.dart';

class ExeFile {
  final String fileName;

  ExeFile(this.fileName);

  late RandomAccessFile _file;
  late AddressBook _address;
  late IOImage _io;
  bool _isFileOpen = false;

  WinPE openPE() {
    _openFile();
    _calculateAddress();
    _verifyExeFile();

    return WinPE.open(addressBook: _address, read_write: _io);
  }

  void _openFile() {
    final f = File(fileName);
    if (!f.existsSync()) {
      throw 'File not found: $f';
    }
    try {
      _file = f.openSync(mode: FileMode.append);
    } catch (e) {
      final fileException = (e as FileSystemException);
      final osError = fileException.osError?.message ?? '';
      throw 'Open file error. ' + osError;
    }
    _isFileOpen = true;
    _io = IOImage(_file);
  }

  void _calculateAddress() {
    final peAddress = _io.read(address: 0x3c);
    _address = AddressBook.calculateFromPEAddress(peAddress);
  }

  void _verifyExeFile() {
    final mzSignature = _io.readString(address: 0, len: 2);
    final peSignature = _io.readString(address: _address.pe, len: 4);

    final _0 = String.fromCharCode(0);
    if (mzSignature != 'MZ' && peSignature != 'PE$_0$_0') {
      throw 'File $fileName is not an executable file';
    }
  }

  void close() {
    if (_isFileOpen) {
      _file.closeSync();
    }
  }
}
