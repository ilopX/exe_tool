import 'package:dart_exe/src/exceptions/app_error.dart';
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

    'title: "one" -> 1'.test(() {
      final result = Flags.fromString('one');
      expect(result, Flags.one);
    });

    'title case insensitive: "ThReE" -> 3'.test(() {
      final result = Flags.fromString('ThReE');
      expect(result, Flags.three);
    });

    'title not exist :"_fake_" -> throw'.testThrow(() {
      Flags.fromString('_fake_');
    }, isA<AppException>());

  });
}
