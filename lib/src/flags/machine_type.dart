class MachineType {
  static const amd64 = MachineType._internal(0x8664, 'x64');
  static const i368 = MachineType._internal(0x14c, 'x86');

  final int flag;
  final String name;

  const MachineType._internal(this.flag, this.name);

  static final all = List<MachineType>.unmodifiable([
    amd64,
    i368,
  ]);

  static MachineType fromFlag(int flag) {
    for(final item in MachineType.all) {
      if (item.flag == flag) {
        return item;
      }
    }
    throw 'flag not found';
  }

  @override
  String toString() {
    return '0x${flag.toRadixString(16)} ($name)';
  }
}
