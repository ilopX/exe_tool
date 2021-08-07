import 'dart:typed_data';

typedef Bytes = Uint8List;

extension Uint8ListTools on Bytes {
  String toStringChar() {
    return map((i) => String.fromCharCode(i)).join();
  }

  int toIn16Reversed() {
    return buffer.asByteData().getUint16(0, Endian.little);
  }
}

extension IOInt on int {
  Bytes toBytes() {
    final bData = ByteData(2)
      ..setInt16(0, this, Endian.little);
    return bData.buffer.asUint8List();
  }
}
