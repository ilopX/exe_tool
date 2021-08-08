import 'package:dart_exe/src/flags/flags_abstract.dart' as src;

class Flags extends src.Flags {
  static const one = Flags._internal(0x1, 'one');
  static const two = Flags._internal(0x2, 'two');
  static const three = Flags._internal(0x3, 'three');

  static final all = List<Flags>.unmodifiable([
    one,
    two,
    three,
  ]);

  static Flags fromFlag(int flag) => src.Flags.fromFlag(flag, all);

  static Flags fromString(String title) => src.Flags.fromString(title, all);

  const Flags._internal(int flag, String title) : super(flag, title);
}
