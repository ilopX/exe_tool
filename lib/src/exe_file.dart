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

  WinPE openPE() {
    _1_openFile();
    _2_calculateAddress();
    _3_verifyExeFile();

    return WinPE.open(addressBook: _address, read_write: _io);
  }

  void _1_openFile() {
    final f = File(fileName);
    if (!f.existsSync()) {
      throw 'File not found: $f';
    }
    try {
      _file = f.openSync(mode: FileMode.append);
    } catch (e) {
      throw 'Open file error';
    }

    _io = IOImage(_file);
  }

  void _2_calculateAddress() {
    final peAddress = _io.read(address: 0x3c);
    _address = AddressBook.calculateFromPEAddress(peAddress);
  }

  void _3_verifyExeFile() {
    final mzSignature = _io.readString(address: 0, len: 2);
    final peSignature = _io.readString(address: _address.pe, len: 4);

    final _0 = String.fromCharCode(0);
    if (mzSignature != 'MZ' && peSignature != 'PE$_0$_0') {
      throw 'File $fileName iis not an executable file';
    }
  }

  void close() {
    _file.closeSync();
  }
}
