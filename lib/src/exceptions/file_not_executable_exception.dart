import 'error_abstract.dart';

abstract class FileNotExecutableException extends AbstractError {
  final String fileName;

  FileNotExecutableException(this.fileName);

  factory FileNotExecutableException.unavailableSize(
    String fileName,
    int fileSize,
    int requestSize,
  ) {
    return UnavailableSize._internal(fileName, fileSize, requestSize);
  }

  factory FileNotExecutableException.notVerified(
    String fileName,
    String peSignature,
    String mzSignature,
  ) {
    return NotVerified._internal(fileName, mzSignature, peSignature);
  }

  @override
  String get message {
    return 'File $fileName is not executable.\n'
        '$reasonMessage';
  }

  String get reasonMessage;
}

class UnavailableSize extends FileNotExecutableException {
  final int fileSize;
  final int requestSize;

  UnavailableSize._internal(
    String fileName,
    this.fileSize,
    this.requestSize,
  ) : super(fileName);

  @override
  String get reasonMessage {
    return 'Check file size: \n'
        '\tavailable size($fileSize bytes)\n'
        '\trequest size($requestSize bytes).';
  }
}

class NotVerified extends FileNotExecutableException {
  final String mz;
  final String pe;

  NotVerified._internal(
    String fileName,
    this.mz,
    this.pe,
  ) : super(fileName);

  @override
  String get reasonMessage {
    return 'Verify exe file: \n'
        '\tmzSignature: ($mz) - available(MZ)\n'
        '\tpeSignature: ($pe) - available(PE\\0\\0)';
  }
}
