import 'package:dart_exe/src/common/console_colors.dart';

abstract class Flags {
  final int flag;
  final String title;

  const Flags(this.flag, this.title);

  @override
  String toString() {
    final name = runtimeType.toString();
    final address = blueText('0x${flag.toRadixString(16)}');
    return '$name: $address ($title)';
  }

  static T fromFlag<T extends Flags>(int flag, List<T> all) {
    for(final item in all) {
      if (item.flag == flag) {
        return item;
      }
    }
    throw '${T.runtimeType} flag(0x${flag.toRadixString(16)}) not found.'
        '\nSupported flags: $all';
  }

  static T fromString<T extends Flags> (String text, List<T> all) {
    final lowText = text.toLowerCase();
    return all.firstWhere(
            (i) => i.title.toLowerCase() == lowText
    );
  }
}
