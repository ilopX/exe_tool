import 'dart:io';

import 'package:dart_exe/bin_dart_exe.dart';
import 'package:dart_exe/src/exceptions/file_not_executable_exception.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks/all.mocks.dart';
import '../sugar_testo.dart';

// ignore_for_file: invalid_use_of_protected_member

void main() {
  'openFile() -> close()'.group(() {
    late String existingFileName;

    'constructor -> file is close'.test(() {
      final exe = ExeFile('');
      expect(exe.isFileOpen, false);
    });

    'open real file -> file is open'.test(() {

      final io = MockIO();
      final exe = ExeFile.fromIO(io, existingFileName);

      final ioFile = exe.openFile();

      expect(exe.isFileOpen, true);

      ioFile.closeSync();
    });

    'open real file + close -> file is close'.test(() {
      final io = MockIO();
      final exe = ExeFile.fromIO(io, existingFileName);

      final ioFile = exe.openFile();
      exe.close();

      expect(exe.isFileOpen, false);
      verify(io.close()).called(1);

      ioFile.closeSync();
    });


    late Directory tmpDir;

    setUp(() {
      tmpDir = Directory.systemTemp.createTempSync();
      existingFileName = tmpDir.path + 'empty_file';
      File(existingFileName).createSync();
    });

    tearDown(() {
      tmpDir.deleteSync();
    });
  });

  'verifyExeFile()'.group(() {
    final _0 = String.fromCharCode(0);
    late MockAddressBook addressBook;
    late MockIO io;
    late ExeFile exe;

    'normal exe -> ok'.test(() {
      when(io.readString(address: 0, len: 2)).thenReturn('MZ');
      when(io.readString(address: 2, len: 4)).thenReturn('PE$_0$_0');

      exe.verifyExeFile();
    });

    'pe signature false -> throw'.testThrow(() {
      when(io.readString(address: 0, len: 2)).thenReturn('MZ');
      when(io.readString(address: 2, len: 4)).thenReturn('_fake_');

      exe.verifyExeFile();
    }, isA<NotVerified>());

    'mz signature false -> throw'.testThrow(() {
      when(io.readString(address: 0, len: 2)).thenReturn('_fake_');
      when(io.readString(address: 2, len: 4)).thenReturn('PE$_0$_0');

      exe.verifyExeFile();
    }, isA<NotVerified>());

    setUp(() {
      addressBook = MockAddressBook();
      io = MockIO();
      exe = ExeFile.withoutFile(io, addressBook);
      when(addressBook.pe).thenReturn(2);
    });
  });

  'calculateAddress()'.group(() {
    late MockIO io;
    late ExeFile exe;

    'read -> AddressBook'.test(() {
      when(io.read(address: 0x3c)).thenReturn(0xABC);

      final result = exe.calculateAddress();

      expect(result.pe, 0xABC);
    });

    setUp(() {
      io = MockIO();
      exe = ExeFile.fromIO(io);
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
