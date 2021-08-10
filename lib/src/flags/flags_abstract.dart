import '../common/console_colors.dart';
import '../exceptions/flag_converter_exception.dart';

abstract class Flags {
  final int flag;
  final String title;

  const Flags(this.flag, this.title);

  static F fromFlag<F extends Flags>(int flag, List<F> all) {
    for(final item in all) {
      if (item.flag == flag) {
        return item;
      }
    }
    throw FlagConverterException(flag, all);
  }

  static F fromString<F extends Flags> (String title, List<F> all) {
    final titleLowCase = title.toLowerCase();
    for(final item in all) {
      if (item.title.toLowerCase() == titleLowCase) {
        return item;
      }
    }
    throw FlagConverterException(title, all);
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
