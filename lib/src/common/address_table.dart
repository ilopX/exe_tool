class AddressTable {
  final int pe;
  final int machine;
  final int magic;
  final int subsystem;

  AddressTable(this.pe, this.machine, this.magic, this.subsystem);

  factory AddressTable.fromPEAddress(int peAddress) {
    final machineAddress = peAddress + 4;
    final magicAddress = machineAddress + 20;
    final subsystemAddress = magicAddress + 68;

    return AddressTable(
      peAddress,
      machineAddress,
      magicAddress,
      subsystemAddress,
    );
  }
}
