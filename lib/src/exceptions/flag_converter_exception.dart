import '../flags/flags_abstract.dart';

import 'error_abstract.dart';

class FlagConverterException<T> extends AbstractError {
  final Type className;
  final T requestValue;
  final List<Flags> availableFlags;

  FlagConverterException(
      this.className,
      this.requestValue,
      this.availableFlags,
      );

  @override
  String get message {
    return  '$className flag converter(${requestValue.runtimeType}) error.\n'
        '\tRequested value: $requestValue\n'
        '\tSupported values: $supportedValues\n';
  }

  List get supportedValues {
    switch(requestValue.runtimeType) {
      case int:
        return availableFlags
            .map((e) => '0x${e.flag.toRadixString(16)}')
            .toList();
      case String:
        return availableFlags
            .map((e) => e.title)
            .toList();
      default:
        return availableFlags;
    }
  }
}
