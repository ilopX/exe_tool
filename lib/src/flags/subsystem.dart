import 'abstract_flags.dart';

class Subsystem extends Flags{
  static const GUI = Subsystem._internal(0x2, 'GUI');
  static const Console = Subsystem._internal(0x3, 'Console');

  const Subsystem._internal(int flag, String name) : super(flag, name);

  static final all = List<Subsystem>.unmodifiable([
    GUI,
    Console,
  ]);

  static Subsystem fromFlag(int flag)  => Flags.fromFlag(flag, all);
}
