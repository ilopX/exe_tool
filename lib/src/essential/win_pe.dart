import '../common/address_book.dart';
import '../common/io.dart';
import '../flags/machine_type.dart';
import '../flags/pe_type.dart';
import '../flags/subsystem.dart';

class WinPE {
  final AddressBook address;
  final IO _io;

  WinPE.open({
    required AddressBook addressBook,
    required IO read_write,
  })  : address = addressBook,
        _io = read_write;

  MachineType get machine {
    final machineFlag = _io.read(address: address.machine);
    return MachineType.fromFlag(machineFlag);
  }

  PEType get peType {
    final peFlag = _io.read(address: address.peType);
    return PEType.fromFlag(peFlag);
  }

  Subsystem get subsystem {
    final subSubsystem = _io.read(address: address.subsystem);
    return Subsystem.fromFlag(subSubsystem);
  }

  set subsystem(Subsystem newSubsystem) {
    _io.write(
      address: address.subsystem,
      int16Value: newSubsystem.flag,
    );
  }
}
