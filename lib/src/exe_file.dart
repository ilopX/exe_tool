import 'dart:io';

import 'package:dart_exe/src/exceptions/file_not_found_exception.dart';
import 'package:dart_exe/src/exceptions/file_open_exception.dart';
import 'package:meta/meta.dart';

import 'common/io_file.dart';
import 'common/address_book.dart';
import 'common/io.dart';
import 'essential/win_pe.dart';
import 'exceptions/file_not_executable_exception.dart';

class ExeFile {
  late final String fileName;

  ExeFile(this.fileName);

  late AddressBook _address;
  late IO _io;

  WinPE openPE() {
    _io = IO(openFile());
    _address = calculateAddress();
    verifyExeFile();

    return WinPE.open(addressBook: _address, read_write: _io);
  }

  bool _isFileOpen = false;
  bool get isFileOpen => _isFileOpen;

  @protected
  IOFile openFile() {
    final f = File(fileName);
    if (!f.existsSync()) {
      throw FileNotFoundException(fileName);
    }

    final file = IOFile();
    try {
      file.openSync(f);
    } catch (e) {
      throw FileOpenException(f, e as FileSystemException);
    }

    _isFileOpen = true;
    return file;
  }

  @protected
  AddressBook calculateAddress() {
    final peAddress = _io.read(address: 0x3c);
    return AddressBook.calculateFromPEAddress(peAddress);
  }

  @protected
  void verifyExeFile() {
    final mzSignature = _io.readString(address: 0, len: 2);
    final peSignature = _io.readString(address: _address.pe, len: 4);

    final _0 = String.fromCharCode(0);
    if (mzSignature != 'MZ' || peSignature != 'PE$_0$_0') {
      throw FileNotExecutableException.notVerified(
          fileName,
          peSignature,
          mzSignature,
      );
    }
  }

  void close() {
    if (_isFileOpen) {
      _isFileOpen = false;
      _io.close();
    }
  }

  // For test purpose
  ExeFile.withoutFile(IO io, AddressBook address)
      : _io = io,
        _address = address,
        fileName = '';

  // For test purpose
  ExeFile.fromIO(IO io, [String fileName = ''])
      : _io = io,
        fileName = fileName;
}
