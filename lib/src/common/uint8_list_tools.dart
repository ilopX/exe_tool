import 'dart:typed_data';

extension Uint8ListTools on Uint8List {
  String toStringChar() {
    return map((i) => String.fromCharCode(i)).join();
  }

  int toIn16Reversed() {
    return Uint8List.fromList(reversed.toList()).toInt16();
  }

  int toInt16() {
    if (buffer.lengthInBytes < 2) {
      throw 'toInt16 error, minimum byte in buffer should be 2 and more ';
    }
    return buffer.asByteData().getUint16(0);
  }
}
