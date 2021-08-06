class AddressBook {
  final int pe;
  final int machine;
  final int magic;
  final int subsystem;

  AddressBook(this.pe, this.machine, this.magic, this.subsystem);

  factory AddressBook.calculateFromPEAddress(int peAddress) {
    final machineAddress = peAddress + 4;
    final magicAddress = machineAddress + 20;
    final subsystemAddress = magicAddress + 68;

    return AddressBook(
      peAddress,
      machineAddress,
      magicAddress,
      subsystemAddress,
    );
  }
}
