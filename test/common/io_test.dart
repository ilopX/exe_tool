import 'dart:typed_data';

import 'package:dart_exe/src/common/io.dart';
import 'package:dart_exe/src/exceptions/app_error.dart';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks/all.mocks.dart';
import '../sugar_testo.dart';

void main() {
  'checkFileSize(int size)'.group(() {
    late IO io;

    'size larger than available -> throw'.testThrow(() {
      // ignore: invalid_use_of_protected_member
      io.checkFileSize(15);
    }, isA<AppException>());

    'size range of available -> ок'.test(() {
      // ignore: invalid_use_of_protected_member
      io.checkFileSize(10);
    });

    setUp(() {
      final fakeFile = MockIOFile();
      when(fakeFile.lengthSync()).thenReturn(10);
      when(fakeFile.path).thenReturn('');

      io = IO(fakeFile);
    });

  });

  'write(int int16Value)'.group(() {
    late IO io;
    late MockIOFile fakeFile;

    'write int16[0xa, 0xb] -> byteList[0xb, 0xa] reverse'.test(() {
      final write = [0xa, 0xb].toInt16();
      final shouldWrite = [0xb, 0xa].toByteList();

      io.write(
        address: 0,
        int16Value: write,
      );

      verify(fakeFile.writeFromSync(shouldWrite)).called(1);
    });

    setUp(() {
      fakeFile = MockIOFile();
      when(fakeFile.lengthSync()).thenReturn(2);
      io = IO(fakeFile);
    });

  });

  'read(int address)'.group(() {
    late IO io;
    late MockIOFile fakeFile;

    'address any -> int16 reversed value'.test(() {
      final bytes = io.read(address: 0);
      expect(bytes, [0x2a, 0x1a].toInt16());
    });

    setUp(() {
      fakeFile = MockIOFile();
      when(fakeFile.lengthSync()).thenReturn(2);
      when(fakeFile.readSync(any)).thenReturn(Uint8List.fromList([0x1a, 0x2a]));

      io = IO(fakeFile);
    });

  });

  'readString'.group(() {
    late IO io;
    late MockIOFile fakeFile;
    final string = 'dart';

    'read buffer${string.toHexList()} -> "$string"'.test(() {
      final strRead = io.readString(
        address: 0,
        len: string.length,
      );
      expect(strRead, string);
    });

    'read invalid number of chars -> trows'.testThrow(() {
      io.readString(
        address: 0,
        len: string.length * 2,
      );
    }, isA<AppException>());

    'read 0 len string -> "" empty string'.test(() {
      final strRead = io.readString(
        address: 0,
        len: 0,
      );
      expect(strRead, '');
    });

    setUp(() {
      fakeFile = MockIOFile();
      when(fakeFile.lengthSync()).thenReturn(string.length);
      when(fakeFile.readSync(any)).thenReturn(string.codeUnits.toByteList());
      when(fakeFile.readSync(0)).thenReturn(<int>[].toByteList());
      when(fakeFile.path).thenReturn('');

      io = IO(fakeFile);
    });

  });
}

extension StringTools on String {
  List<String> toHexList() {
    return codeUnits
        .map((e) => '0x'+e.toRadixString(16).toUpperCase())
        .toList();
  }
}

extension ListTools on List<int> {
  int toInt16() {
    return Uint8List.fromList(this)
        .buffer
        .asByteData()
        .getInt16(0);
  }

  Uint8List toByteList() {
    return Uint8List.fromList(this);
  }
}
