import 'abstract_flags.dart';

class Subsystem extends Flags{
  static const GUI = Subsystem._internal(0x2, 'GUI');
  static const Console = Subsystem._internal(0x3, 'Console');

  const Subsystem._internal(int flag, String name) : super(flag, name);

  static final all = List<Subsystem>.unmodifiable([
    GUI,
    Console,
  ]);

  static Subsystem fromFlag(int flag) {
    for(final item in Subsystem.all) {
      if (item.flag == flag) {
        return item;
      }
    }
    throw 'flag not found';
  }
}
