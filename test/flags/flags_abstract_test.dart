import 'package:dart_exe/src/exceptions/error_abstract.dart';
import 'package:test/test.dart';

import '../mocks/impl_flags.dart';
import '../sugar_testo.dart';

void main() {
  'fromFlag(int flag)'.group(() {

    'flag: 1 -> Flag.one'.test(() {
      final result = Flags.fromFlag(1);
      expect(result, Flags.one);
    });

    'flag: 3 -> Flag.three'.test(() {
      final result = Flags.fromFlag(3);
      expect(result, Flags.three);
    });

    'flag not exist: 99 -> throw'.testThrow(() {
      Flags.fromFlag(99);
    }, isA<AppException>());

  });

  'fromString(String title)'.group(() {

    'title: "one" -> Flags.one'.test(() {
      final result = Flags.fromString('one');
      expect(result, Flags.one);
    });

    'title case insensitive: "ThReE" -> Flags.three'.test(() {
      final result = Flags.fromString('ThReE');
      expect(result, Flags.three);
    });

    'title: "four" -> Flags.four where title different case "fOuR"' .test(() {
      final result = Flags.fromString('four');
      expect(result, Flags.four);
    });

    'title not exist : "_fake_" -> throw'.testThrow(() {
      Flags.fromString('_fake_');
    }, isA<AppException>());

  });
}
