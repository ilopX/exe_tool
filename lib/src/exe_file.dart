import 'dart:io';

import 'common/address_book.dart';
import 'common/io.dart';
import 'essential/win_pe.dart';

class ExeFile {
  final String fileName;

  ExeFile(this.fileName);

  late AddressBook _address;
  late IO _io;
  bool _isFileOpen = false;

  WinPE openPE() {
    _io = _openFile();
    _address = _calculateAddress();
    _verifyExeFile();

    return WinPE.open(addressBook: _address, read_write: _io);
  }

  IO _openFile() {
    final f = File(fileName);
    if (!f.existsSync()) {
      throw 'File not found: $f';
    }

    RandomAccessFile file;
    try {
      file = f.openSync(mode: FileMode.append);
    } catch (e) {
      final fileException = (e as FileSystemException);
      final osError = fileException.osError?.message ?? '';
      throw 'Open file error. ' + osError;
    }

    _isFileOpen = true;
    return IO(file);
  }

  AddressBook _calculateAddress() {
    final peAddress = _io.read(address: 0x3c);
    return AddressBook.calculateFromPEAddress(peAddress);
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
      _isFileOpen = false;
      _io.close();
    }
  }
}
