import 'package:test/test.dart' as native_test;

class Exception {

}

void main() {
  'Group name one'.group(() {
    'test one -> all good'.test(() {
      print('all good');
    });
    'test -> throw'.testThrow(() {
      throw Exception();
    }, native_test.isA<Exception>());
  });
}

extension StringTestTools on String {
  void group(Function() func) {
    native_test.group(toPrintable(), func);
  }

  void test(Function() func) {
    native_test.test(toPrintable(), func);
  }

  void testThrow<T>(Function() func, native_test.TypeMatcher<T> throwClass) {
    native_test.test(toPrintable(), () {
      native_test.expect(
          () => func(),
          native_test.throwsA(throwClass)
      );
    });
  }

  String toPrintable() {
    return replaceAll('->', '➡️');
  }
}
