import 'dart:io';

abstract class AbstractError extends Error {
  String get message;

  @override
  String toString() =>
      message + '\n' +
      (isDebug ? '\n$stackTrace' : '');

  static final isDebug = Platform.environment['dart_debug'] == 'true';
}
