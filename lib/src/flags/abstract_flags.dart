abstract class Flags {
  final int flag;
  final String title;

  const Flags(this.flag, this.title);

  @override
  String toString() {
    final name = runtimeType.toString();
    return '$name: 0x${flag.toRadixString(16)} ($title)';
  }

  static T fromFlag<T extends Flags>(int flag, List<T> all) {
    for(final item in all) {
      if (item.flag == flag) {
        return item;
      }
    }
    throw 'flag not found';
  }

  static T fromString<T extends Flags> (String text, List<T> all) {
    return all.firstWhere(
            (i) => i.title.toLowerCase() == text.toLowerCase()
    );
  }
}
