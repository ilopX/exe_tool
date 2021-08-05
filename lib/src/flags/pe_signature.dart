class PESignature {
  static const PE = PESignature._internal(0x10b, 'PE');
  static const PEPlus = PESignature._internal(0x20b, 'PE+');

  final int flag;
  final String name;

  const PESignature._internal(this.flag, this.name);

  static final all = List<PESignature>.unmodifiable([
    PE,
    PEPlus,
  ]);

  static PESignature fromFlag(int flag) {
    for(final item in PESignature.all) {
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
