import 'package:dart_exe/src/flags/flags_abstract.dart';

class ImplFlags extends Flags {
  static const one = ImplFlags._internal(0x1, 'one');
  static const two = ImplFlags._internal(0x2, 'two');
  static const three = ImplFlags._internal(0x3, 'three');
  static const four = ImplFlags._internal(0x4, 'fOuR');

  static final all = List<ImplFlags>.unmodifiable([
    one,
    two,
    three,
    four,
  ]);

  static ImplFlags fromFlag(int flag) => Flags.fromFlag(flag, all);

  static ImplFlags fromString(String title) => Flags.fromString(title, all);

  const ImplFlags._internal(int flag, String title) : super(flag, title);
}
