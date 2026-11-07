import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';

List<int> _asBytes(dynamic arg) {
  if (arg is String) return utf8.encode(arg);
  if (arg is List) return arg.cast<int>();
  return [];
}

class CryptoBinding extends HTExternalClass {
  CryptoBinding() : super('Crypto');

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'Crypto.sha1':
        return ({
          List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {},
        }) =>
            crypto.sha1.convert(_asBytes(positionalArgs[0])).bytes;
      case 'Crypto.sha256':
        return ({
          List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {},
        }) => crypto.sha256
            .convert(_asBytes(positionalArgs[0]))
            .bytes;
      case 'Crypto.sha512':
        return ({
          List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {},
        }) => crypto.sha512
            .convert(_asBytes(positionalArgs[0]))
            .bytes;
      case 'Crypto.md5':
        return ({
          List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {},
        }) => crypto.md5.convert(_asBytes(positionalArgs[0])).bytes;
      case 'Crypto.hmacSha1':
        return ({
          List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {},
        }) => crypto.Hmac(
          crypto.sha1,
          _asBytes(positionalArgs[0]),
        ).convert(_asBytes(positionalArgs[1])).bytes;
      case 'Crypto.hmacSha256':
        return ({
          List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {},
        }) => crypto.Hmac(
          crypto.sha256,
          _asBytes(positionalArgs[0]),
        ).convert(_asBytes(positionalArgs[1])).bytes;
      case 'Crypto.hmacSha512':
        return ({
          List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {},
        }) => crypto.Hmac(
          crypto.sha512,
          _asBytes(positionalArgs[0]),
        ).convert(_asBytes(positionalArgs[1])).bytes;
      case 'Crypto.hmacMd5':
        return ({
          List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {},
        }) => crypto.Hmac(
          crypto.md5,
          _asBytes(positionalArgs[0]),
        ).convert(_asBytes(positionalArgs[1])).bytes;
      case 'Crypto.hexEncode':
        return ({
          List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {},
        }) {
          final bytes = _asBytes(positionalArgs[0]);
          return bytes
              .map((b) => b.toRadixString(16).padLeft(2, '0'))
              .join('');
        };
      case 'Crypto.base64Encode':
        return ({
          List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {},
        }) {
          if (positionalArgs.isEmpty) return "";
          final bytes = _asBytes(positionalArgs[0]);
          return base64Encode(bytes);
        };
      default:
        throw HTError.undefined(id);
    }
  }
}
