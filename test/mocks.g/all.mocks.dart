// Mocks generated by Mockito 5.0.14 from annotations
// in dart_exe/test/mocks.g/all.dart.
// Do not manually edit this file.

import 'dart:io' as _i3;
import 'dart:typed_data' as _i4;

import 'package:dart_exe/src/common/io_file.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [IOFile].
///
/// See the documentation for Mockito's code generation for more information.
class MockIOFile extends _i1.Mock implements _i2.IOFile {
  MockIOFile() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get path =>
      (super.noSuchMethod(Invocation.getter(#path), returnValue: '') as String);
  @override
  void openSync(_i3.File? file) =>
      super.noSuchMethod(Invocation.method(#openSync, [file]),
          returnValueForMissingStub: null);
  @override
  void setPositionSync(int? pos) =>
      super.noSuchMethod(Invocation.method(#setPositionSync, [pos]),
          returnValueForMissingStub: null);
  @override
  _i4.Uint8List readSync(int? count) =>
      (super.noSuchMethod(Invocation.method(#readSync, [count]),
          returnValue: _i4.Uint8List(0)) as _i4.Uint8List);
  @override
  void writeFromSync(_i4.Uint8List? bytes) =>
      super.noSuchMethod(Invocation.method(#writeFromSync, [bytes]),
          returnValueForMissingStub: null);
  @override
  void closeSync() => super.noSuchMethod(Invocation.method(#closeSync, []),
      returnValueForMissingStub: null);
  @override
  int lengthSync() =>
      (super.noSuchMethod(Invocation.method(#lengthSync, []), returnValue: 0)
          as int);
  @override
  String toString() => super.toString();
}
