import 'dart:convert';
import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';

extension Utf8Binding on Utf8Codec {
  dynamic htFetch(String varName) {
    switch (varName) {
      case 'encode':
        return ({positionalArgs, namedArgs}) =>
            encode(positionalArgs[0]) as List<int>;
      case 'decode':
        return ({positionalArgs, namedArgs}) =>
            decode(
              (positionalArgs[0] as List).cast<int>(),
              allowMalformed: namedArgs['allowMalformed'],
            );
      default:
        throw HTError.undefined(varName);
    }
  }
}

class Utf8CodecBinding extends HTExternalClass {
  Utf8CodecBinding() : super('Utf8Codec');

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'Utf8Codec':
        return ({positionalArgs, namedArgs}) =>
            Utf8Codec(allowMalformed: namedArgs['allowMalformed'] ?? false);
      default:
        throw HTError.undefined(id);
    }
  }

  @override
  dynamic instanceMemberGet(dynamic instance, String id, {bool ignoreUndefined = false}) {
    return (instance as Utf8Codec).htFetch(id);
  }
}
