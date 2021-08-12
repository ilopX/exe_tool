import 'dart:io';

import 'package:path/path.dart';
import 'package:test/test.dart' as native_test;

extension StringTestTools on String {
  void group(Function() func) {
    native_test.group(toPrintable(), func);
  }

  void test(Function() func) {
    native_test.test(toPrintable(), func);
  }

  void testThrow<T>(Function() func, native_test.TypeMatcher<T> throwClass) {
    native_test.test(toPrintable() + ' 🔥', () {
      native_test.expect(
          () => func(),
          native_test.throwsA(throwClass)
      );
    });
  }

  String toPrintable() {
    return replaceAll('->', ' ↩️️ ');
  }
}

class TemporaryFile {
  late Directory dir;
  late File file;

  TemporaryFile() {
    dir = Directory.systemTemp.createTempSync();
    file = File(join(dir.path, 'fake_name'))..createSync();
  }

  void close() {
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
    }
  }

  @override
  String toString() {
    return file.path;
  }
}
