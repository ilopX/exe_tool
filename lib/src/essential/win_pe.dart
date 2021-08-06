import '../common/address_book.dart';
import '../common/io_image.dart';
import '../flags/machine_type.dart';
import '../flags/pe_signature.dart';
import '../flags/subsystem.dart';

class WinPE {
  final AddressBook address;
  final IOImage _io;

  WinPE.open({
    required AddressBook addressBook,
    required IOImage read_write,
  })  : address = addressBook,
        _io = read_write;

  MachineType get machine {
    final machineFlag = _io.read(address: address.machine);
    return MachineType.fromFlag(machineFlag);
  }

  PESignature get magicPE {
    final peFlag = _io.read(address: address.magic);
    return PESignature.fromFlag(peFlag);
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
