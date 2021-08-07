import 'dart:typed_data';

extension Uint8ListTools on Uint8List {
  String toStringChar() {
    return map((i) => String.fromCharCode(i)).join();
  }

  int toIn16Reversed() {
    return buffer.asByteData().getUint16(0, Endian.little);
  }
}
