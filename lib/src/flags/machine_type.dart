import 'flags_abstract.dart';

class MachineType extends Flags {
  static const amd64 = MachineType._internal(0x8664, 'x64');
  static const i368 = MachineType._internal(0x14c, 'x86');

  static final all = List<MachineType>.unmodifiable([
    amd64,
    i368,
  ]);

  static MachineType fromFlag(int flag) => Flags.fromFlag(flag, all);

  const MachineType._internal(int flag, String title): super(flag, title);
}
