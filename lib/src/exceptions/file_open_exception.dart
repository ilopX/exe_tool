import 'dart:io';

import 'package:dart_exe/src/exceptions/error_abstract.dart';

class FileOpenException extends AbstractError {
  final FileSystemException _exception;
  final File _file;

  FileOpenException(this._file, this._exception,);

  @override
  String get message {
    final osError = _exception.osError?.message ?? 'unknown error';
    throw 'Open file error.\n'
        '${_file.path}\n'
        + osError;
  }
}
