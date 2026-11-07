import 'dart:typed_data';

import 'package:base32/base32.dart';
import 'package:base32/encodings.dart';

class Base32 {
  static String encode(
    List<int> bytes, {
    Encoding encoding = Encoding.standardRFC4648,
  }) {
    return base32.encode(Uint8List.fromList(bytes), encoding: encoding);
  }

  static List<int> decode(
    String base32String, {
    Encoding encoding = Encoding.standardRFC4648,
  }) {
    return base32.decode(base32String, encoding: encoding) as List<int>;
  }

  static String encodeString(
    String utf8String, {
    Encoding encoding = Encoding.standardRFC4648,
  }) {
    return base32.encodeString(utf8String, encoding: encoding);
  }

  static String decodeAsString(
    String base32String, {
    Encoding encoding = Encoding.standardRFC4648,
  }) {
    return base32.decodeAsString(base32String, encoding: encoding);
  }

  static String encodeHexString(
    String b32Hex, {
    Encoding encoding = Encoding.standardRFC4648,
  }) {
    return base32.encodeHexString(b32Hex, encoding: encoding);
  }

  static String decodeAsHexString(
    String base32String, {
    Encoding encoding = Encoding.standardRFC4648,
  }) {
    return base32.decodeAsHexString(base32String, encoding: encoding);
  }
}
