class AddressBook {
  static const PESignatureSize = 4;
  static const PESectionSize = PESignatureSize + 20;
  static const SubsystemVirtualAddress = 68;

  final int pe;
  final int machine;
  final int peType;
  final int subsystem;

  AddressBook(this.pe, this.machine, this.peType, this.subsystem);

  factory AddressBook.calculateFromPEAddress(int peAddress) {
    final machineAddress = peAddress + PESignatureSize;
    final peTypeAddress = peAddress + PESectionSize;
    final subsystemAddress = peTypeAddress + SubsystemVirtualAddress;

    return AddressBook(
      peAddress,
      machineAddress,
      peTypeAddress,
      subsystemAddress,
    );
  }
}
