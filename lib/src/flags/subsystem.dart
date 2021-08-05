class Subsystem {
  static const GUI = Subsystem._internal(0x2, 'GUI');
  static const Console = Subsystem._internal(0x3, 'Console');

  final int flag;
  final String name;

  const Subsystem._internal(this.flag, this.name);

  static final all = List<Subsystem>.unmodifiable([
    GUI,
    Console,
  ]);

  static Subsystem fromFlag(int flag) {
    for(final item in Subsystem.all) {
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
