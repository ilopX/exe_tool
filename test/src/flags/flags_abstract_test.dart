import 'package:dart_exe/src/exceptions/flag_converter_exception.dart';
import 'package:test/test.dart';

import '../../mocks/impl_flags.dart';
import '../../sugar_testo.dart';

void main() {
  'fromFlag(int flag)'.group(() {

    'flag: 1 -> Flag.one'.test(() {
      final result = ImplFlags.fromFlag(1);
      expect(result, ImplFlags.one);
    });

    'flag: 3 -> Flag.three'.test(() {
      final result = ImplFlags.fromFlag(3);
      expect(result, ImplFlags.three);
    });

    'flag not exist: 99 -> throw'.testThrow(() {
      ImplFlags.fromFlag(99);
    }, isA<FlagConverterException>());

  });

  'fromString(String title)'.group(() {

    'title: "one" -> Flags.one'.test(() {
      final result = ImplFlags.fromString('one');
      expect(result, ImplFlags.one);
    });

    'title case insensitive: "ThReE" -> Flags.three'.test(() {
      final result = ImplFlags.fromString('ThReE');
      expect(result, ImplFlags.three);
    });

    'title: "four" -> Flags.four where title different case "fOuR"' .test(() {
      final result = ImplFlags.fromString('four');
      expect(result, ImplFlags.four);
    });

    'title not exist : "_fake_" -> throw'.testThrow(() {
      ImplFlags.fromString('_fake_');
    }, isA<FlagConverterException>());

  });
}
