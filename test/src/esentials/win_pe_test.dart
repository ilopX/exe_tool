import 'package:dart_exe/bin_dart_exe.dart';
import 'package:mockito/mockito.dart';
import 'package:test/expect.dart';
import 'package:test/test.dart';

import '../../mocks/all.mocks.dart';
import '../../sugar_testo.dart';

void main() {
  'open()'.group(() {
    late WinPE winPE;
    late MockAddressBook addressBook;
    late MockIO io;

    'get machine -> i386'.test(() {
      expect(winPE.machine, MachineType.i368);
    });

    'get peType -> PE'.test(() {
      expect(winPE.peType, PEType.PE);
    });

    'get subsystem -> Console'.test(() {
      expect(winPE.subsystem, Subsystem.Console);
    });

    'set subsystem -> ok'.test(() {
      winPE.subsystem = Subsystem.Console;

      verify(
        io.write(
          address: 2,
          int16Value: Subsystem.Console.flag,
        ),
      ).called(1);
    });

    setUp(() {
      addressBook = MockAddressBook();
      io = MockIO();

      when(addressBook.machine).thenReturn(0);
      when(addressBook.peType).thenReturn(1);
      when(addressBook.subsystem).thenReturn(2);

      when(io.read(address: 0)).thenReturn(MachineType.i368.flag);
      when(io.read(address: 1)).thenReturn(PEType.PE.flag);
      when(io.read(address: 2)).thenReturn(Subsystem.Console.flag);

      winPE = WinPE.open(
        addressBook: addressBook,
        read_write: io,
      );
    });
  });
}
