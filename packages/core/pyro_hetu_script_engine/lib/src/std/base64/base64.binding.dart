import 'dart:convert';
import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'base64.dart';

class Base64ClassBinding extends HTExternalClass {
  Base64ClassBinding() : super('Base64');

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'Base64.encode':
        return ({positionalArgs, namedArgs}) {
          final arg = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
          final List<int> bytes = arg is List
              ? arg.cast<int>()
              : (arg is String ? utf8.encode(arg) : const <int>[]);
          return Base64.encode(bytes);
        };
      case 'Base64.decode':
        return ({positionalArgs, namedArgs}) {
          final arg = positionalArgs.isNotEmpty ? positionalArgs[0]?.toString() ?? '' : '';
          return Base64.decode(arg);
        };
      default:
        throw HTError.undefined(id);
    }
  }
}
