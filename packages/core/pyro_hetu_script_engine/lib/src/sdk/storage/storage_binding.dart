import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';
import '../../../delegates/delegates.dart';

class StorageBinding extends HTExternalClass {
  final StorageDelegate _delegate;
  StorageBinding(this._delegate) : super('Storage');
  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'Storage.getValue':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) async {
          if (positionalArgs.isEmpty) return null;
          return await _delegate.getValue(positionalArgs[0] as String);
        };
      case 'Storage.setValue':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) async {
          if (positionalArgs.length < 2) return false;
          return await _delegate.setValue(
              positionalArgs[0] as String, positionalArgs[1] as String);
        };
      default:
        throw HTError.undefined(id);
    }
  }
}
