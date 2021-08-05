abstract class Flags {
  final int flag;
  final String name;

  const Flags(this.flag, this.name);

  @override
  String toString() {
    return '0x${flag.toRadixString(16)} ($name)';
  }

  static late final List all;

  static T fromFlag<T extends Flags>(int flag, List<T> all) {
    for(final item in all) {
      if (item.flag == flag) {
        return item;
      }
    }
    throw 'flag not found';
  }
}
