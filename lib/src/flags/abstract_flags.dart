abstract class Flags {
  final int flag;
  final String name;

  const Flags(this.flag, this.name);

  @override
  String toString() {
    return '0x${flag.toRadixString(16)} ($name)';
  }
}
