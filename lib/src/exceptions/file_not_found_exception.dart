import 'error_abstract.dart';

class FileNotFoundException extends AbstractError{
  final String fileName;

  FileNotFoundException(this.fileName);

  @override
  String get message => 'File "$fileName" not found.';
}
