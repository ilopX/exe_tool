import 'abstract_flags.dart';

class PESignature extends Flags {
  static const PE = PESignature._internal(0x10b, 'PE');
  static const PEPlus = PESignature._internal(0x20b, 'PE+');

  const PESignature._internal(int flag, String title) : super(flag, title);

  static final all = List<PESignature>.unmodifiable([
    PE,
    PEPlus,
  ]);

  static PESignature fromFlag(int flag)  => Flags.fromFlag(flag, all);
}
