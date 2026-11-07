import 'dart:convert';
import 'package:base32/encodings.dart';
import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'base32.dart';

class Base32ClassBinding extends HTExternalClass {
  Base32ClassBinding() : super('Base32');

  Encoding _parseEncoding(String encoding) {
    return Encoding.values.firstWhere((value) => value.name == encoding);
  }

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'Base32.encode':
        return ({positionalArgs, namedArgs}) {
          final arg = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
          final List<int> bytes = arg is List
              ? arg.cast<int>()
              : (arg is String ? utf8.encode(arg) : const <int>[]);
          return Base32.encode(
            bytes,
            encoding: namedArgs['encoding'] != null
                ? _parseEncoding(namedArgs['encoding'])
                : Encoding.standardRFC4648,
          );
        };
      case 'Base32.decode':
        return ({positionalArgs, namedArgs}) =>
            Base32.decode(
              positionalArgs[0],
              encoding: namedArgs['encoding'] != null
                  ? _parseEncoding(namedArgs['encoding'])
                  : Encoding.standardRFC4648,
            );
      case 'Base32.encodeString':
        return ({positionalArgs, namedArgs}) {
          return Base32.encodeString(
            positionalArgs[0],
            encoding: namedArgs['encoding'] != null
                ? _parseEncoding(namedArgs['encoding'])
                : Encoding.standardRFC4648,
          );
        };
      case 'Base32.decodeAsString':
        return ({positionalArgs, namedArgs}) =>
            Base32.decodeAsString(
              positionalArgs[0],
              encoding: namedArgs['encoding'] != null
                  ? _parseEncoding(namedArgs['encoding'])
                  : Encoding.standardRFC4648,
            );
      case 'Base32.encodeHexString':
        return ({positionalArgs, namedArgs}) =>
            Base32.encodeHexString(
              positionalArgs[0],
              encoding: namedArgs['encoding'] != null
                  ? _parseEncoding(namedArgs['encoding'])
                  : Encoding.standardRFC4648,
            );
      case 'Base32.decodeAsHexString':
        return ({positionalArgs, namedArgs}) =>
            Base32.decodeAsHexString(
              positionalArgs[0],
              encoding: namedArgs['encoding'] != null
                  ? _parseEncoding(namedArgs['encoding'])
                  : Encoding.standardRFC4648,
            );
      default:
        throw HTError.undefined(id);
    }
  }
}
