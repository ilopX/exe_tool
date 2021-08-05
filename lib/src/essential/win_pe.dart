import '../common/address_table.dart';
import '../common/io_image.dart';
import '../flags/machine_type.dart';
import '../flags/pe_signature.dart';
import '../flags/subsystem.dart';

class WinPE {
  final AddressTable address;
  final IOImage _io;

  WinPE.open({
    required AddressTable addressTable,
    required IOImage read_write,
  })  : address = addressTable,
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
