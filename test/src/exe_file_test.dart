import 'dart:io';

import 'package:dart_exe/bin_dart_exe.dart';
import 'package:dart_exe/src/exceptions/file_not_executable_exception.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks/all.mocks.dart';
import '../sugar_testo.dart';

void main() {
  'close()'.group(() {

    'constructor -> file is close'.test(() {
      final exe = ExeFile('');
      expect(exe.isFileOpen, false);
    });

    'open real file -> file is open'.test(() {
      final existingFileName = Directory.systemTemp.createTempSync();
      File(existingFileName.path + 'empty_file').createSync();

      final io = MockIO();
      final exe = ExeFile.fromIO(io, existingFileName.path + 'empty_file');

      // ignore: invalid_use_of_protected_member
      final ioFile = exe.openFile();

      expect(exe.isFileOpen, true);

      ioFile.closeSync();
      existingFileName.deleteSync();
    });

    'open real file + close -> file is close'.test(() {
      final existingFileName = Directory.systemTemp.createTempSync();
      File(existingFileName.path + 'empty_file').createSync();

      final io = MockIO();
      final exe = ExeFile.fromIO(io, existingFileName.path + 'empty_file');

      // ignore: invalid_use_of_protected_member
      final ioFile = exe.openFile();
      exe.close();

      expect(exe.isFileOpen, false);
      verify(io.close()).called(1);

      ioFile.closeSync();
      existingFileName.deleteSync();
    });

  });

  'verifyExeFile()'.group(() {

    'normal exe -> ok'.test(() {
      final addressBook = MockAddressBook();
      final io = MockIO();
      final _0 = String.fromCharCode(0);

      when(addressBook.pe).thenReturn(2);
      when(io.readString(address: 0, len: 2)).thenReturn('MZ');
      when(io.readString(address: 2, len: 4)).thenReturn('PE$_0$_0');

      final exe = ExeFile.withoutFile(io, addressBook);
      // ignore: invalid_use_of_protected_member
      exe.verifyExeFile();
    });

    'pe signature false -> throw'.testThrow(() {
      final addressBook = MockAddressBook();
      final io = MockIO();

      when(addressBook.pe).thenReturn(2);
      when(io.readString(address: 0, len: 2)).thenReturn('MZ');
      when(io.readString(address: 2, len: 4)).thenReturn('_fake_');

      final exe = ExeFile.withoutFile(io, addressBook);
      // ignore: invalid_use_of_protected_member
      exe.verifyExeFile();
    }, isA<NotVerified>());

    'mz signature false -> throw'.testThrow(() {
      final _0 = String.fromCharCode(0);
      final addressBook = MockAddressBook();
      final io = MockIO();

      when(addressBook.pe).thenReturn(2);
      when(io.readString(address: 0, len: 2)).thenReturn('_fake_');
      when(io.readString(address: 2, len: 4)).thenReturn('PE$_0$_0');

      final exe = ExeFile.withoutFile(io, addressBook);
      // ignore: invalid_use_of_protected_member
      exe.verifyExeFile();
    }, isA<NotVerified>());

  });

  'calculateAddress()'.group(() {

    'read -> AddressBook'.test(() {
      final io = MockIO();
      when(io.read(address: 0x3c)).thenReturn(0xABC);

      final exe = ExeFile.fromIO(io);
      // ignore: invalid_use_of_protected_member
      final result = exe.calculateAddress();
      expect(result.pe, 0xABC);
    });

  });

  // '_openFile()'.group(() {
  //
  //   'not exist file -> AddressBook'.test(() {
  //     throw UnimplementedError();
  //   });
  //
  // });
}
