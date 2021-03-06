import 'flags_abstract.dart';

class Subsystem extends Flags{
  static const GUI = Subsystem._internal(0x2, 'GUI');
  static const Console = Subsystem._internal(0x3, 'Console');

  static final all = List<Subsystem>.unmodifiable([
    GUI,
    Console,
  ]);

  static Subsystem fromFlag(int flag)  => Flags.fromFlag(flag, all);

  static Subsystem fromString(String text) => Flags.fromString(text, all);

  const Subsystem._internal(int flag, String title) : super(flag, title);
}
