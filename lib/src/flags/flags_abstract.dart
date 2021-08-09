import '../common/console_colors.dart';
import '../exceptions/flag_converter_exception.dart';

abstract class Flags {
  final int flag;
  final String title;

  const Flags(this.flag, this.title);

  static T fromFlag<T extends Flags>(int flag, List<T> all) {
    for(final item in all) {
      if (item.flag == flag) {
        return item;
      }
    }
    throw FlagConverterException(T, flag, all);
  }

  static T fromString<T extends Flags> (String title, List<T> all) {
    final titleLowCase = title.toLowerCase();
    for(final item in all) {
      if (item.title.toLowerCase() == titleLowCase) {
        return item;
      }
    }
    throw FlagConverterException(T, title, all);
  }

  @override
  String toString({colorColor = true}) {
    final name = runtimeType.toString();
    final hex = '0x${flag.toRadixString(16)}';
    final flagFlag = colorColor
        ? blueText(hex)
        : hex;
    return '$name: $title($flagFlag)';
  }
}
