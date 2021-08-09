import 'dart:io';

abstract class AbstractError extends Error {
  String get message;

  static final isDebug = Platform.environment['dart_debug'] == 'true';

  @override
  String toString() => normalizeMessage(message) + getStackTraceIfDebug;

  String get getStackTraceIfDebug => isDebug ? '\n$stackTrace' : '';

  static String normalizeMessage(String msg) => msg.replaceAll('        ', '');
}

class AppException {
  final String message;

  AppException(this.message);

  @override
  String toString() {
    return message;
  }
}
