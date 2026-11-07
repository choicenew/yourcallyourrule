import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';
import '../../../delegates/delegates.dart';

class UserBinding extends HTExternalClass {
  final UserDelegate _delegate;

  UserBinding(this._delegate) : super('User');

  String? _extractType(List<dynamic> positionalArgs, Map<String, dynamic> namedArgs) {
    if (namedArgs.containsKey('type') && namedArgs['type'] != null) {
      return namedArgs['type'].toString();
    }
    if (positionalArgs.isNotEmpty && positionalArgs[0] != null) {
      return positionalArgs[0].toString();
    }
    return null;
  }

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'User.getWeights':
        return ({List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {}}) async =>
            await _delegate.getWeights(type: _extractType(positionalArgs, namedArgs));
      case 'User.getLastTags':
        return ({List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {}}) async =>
            await _delegate.getLastTags(type: _extractType(positionalArgs, namedArgs));
      case 'User.getHistory':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) async {
          return await _delegate.getHistory(type: _extractType(positionalArgs, namedArgs));
        };
      case 'User.getCollections':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) async {
          return await _delegate.getCollections(type: _extractType(positionalArgs, namedArgs));
        };
      default:
        throw HTError.undefined(id);
    }
  }
}