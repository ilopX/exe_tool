import 'dart:io';
import 'dart:typed_data';

import 'package:dart_exe/bin_dart_exe.dart';
import 'package:dart_exe/src/common/address_book.dart';
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

  'integrated: openPE()'.group(() {
    late String fakeExeFileName;

    'open real fake exe file -> ok'.test(() {
      final exe = ExeFile(fakeExeFileName);
      exe.openPE();
      exe.close();
    });

    late Directory tmpDir;

    setUp(() {
      tmpDir = Directory.systemTemp.createTempSync();
      fakeExeFileName = tmpDir.path + 'fake._exe';
      final bytes = makeFakeExeBytes();
      File(fakeExeFileName).writeAsBytesSync(bytes);
    });

    tearDown(() {
      tmpDir.deleteSync();
    });
  });
}

Uint8List makeFakeExeBytes({
  String mz = 'MZ',
  String pe = 'PE',
  int address0x3c = 10,
  MachineType machineType = MachineType.i368,
  PEType peType = PEType.PE,
  Subsystem subsystem = Subsystem.GUI,
}) {
  if (pe == 'PE') {
    final _0 = String.fromCharCode(0);
    pe = 'PE$_0$_0';
  }

  final addressBook = AddressBook.calculateFromPEAddress(10);
  final fileSize = addressBook.subsystem + 2;

  final byteList = Uint8List(fileSize);
  final byteData = ByteData.sublistView(byteList);

  byteList.setAll(0, mz.codeUnits);

  // write where find pe header
  byteData.setInt16(0x3c, addressBook.pe, Endian.little);

  byteList.setAll(addressBook.pe, pe.codeUnits);
  byteData.setInt16(addressBook.machine, machineType.flag, Endian.little);
  byteData.setInt16(addressBook.peType, peType.flag, Endian.little);
  byteData.setInt16(addressBook.subsystem, subsystem.flag, Endian.little);

  return byteList;
}
