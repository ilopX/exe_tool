import 'package:dart_exe/src/common/console_colors.dart';
import 'package:dart_exe/src/exceptions/error_abstract.dart';

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
    throw AppException('${T.runtimeType} '
        'flag(0x${flag.toRadixString(16)}) not found.'
        '\nSupported flags: $all');
  }

  static T fromString<T extends Flags> (String title, List<T> all) {
    final titleLowCase = title.toLowerCase();
    for(final item in all) {
      if (item.title.toLowerCase() == titleLowCase) {
        return item;
      }
    }
    throw AppException('${T.runtimeType} '
            'flagTitle("$title") not found.'
            '\nSupported flags: $all');
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
