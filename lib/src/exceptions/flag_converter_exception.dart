import '../flags/flags_abstract.dart';

import 'error_abstract.dart';

class FlagConverterException<T, F extends Flags> extends AbstractError {
  final T requestValue;
  final List<F> availableFlags;

  FlagConverterException(
      this.requestValue,
      this.availableFlags,
      );

  @override
  String get message {
    return '$F flag converter(${requestValue.runtimeType}) error.\n'
        '\tRequested value: $requestValueStr\n'
        '\tSupported values: $supportedValues';
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

  String get requestValueStr {
    if (requestValue is int) {
      return '0x' + (requestValue as int).toRadixString(16);
    }
    return requestValue.toString();
  }
}
