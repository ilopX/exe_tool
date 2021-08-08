import 'flags_abstract.dart';

class PEType extends Flags {
  static const PE = PEType._internal(0x10b, 'PE');
  static const PEPlus = PEType._internal(0x20b, 'PE+');

  static final all = List<PEType>.unmodifiable([
    PE,
    PEPlus,
  ]);

  static PEType fromFlag(int flag)  => Flags.fromFlag(flag, all);

  const PEType._internal(int flag, String title) : super(flag, title);
}
