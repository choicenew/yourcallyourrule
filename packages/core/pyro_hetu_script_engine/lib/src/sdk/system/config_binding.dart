import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';
import '../../../delegates/delegates.dart';

class ConfigBinding extends HTExternalClass {
  final ConfigDelegate _delegate;
  ConfigBinding(this._delegate) : super('Config');
  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'Config.getValue':
        return ({List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {}}) async =>
            await _delegate
                .getValue(positionalArgs.isNotEmpty ? positionalArgs[0] : '');
      case 'Config.setValue':
        return ({List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {}}) async =>
            await _delegate.setValue(
                positionalArgs.isNotEmpty ? positionalArgs[0] : '',
                positionalArgs.length > 1 ? positionalArgs[1] : null);
      case 'Config.update':
        return ({List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {}}) async {
          if (positionalArgs.isEmpty) return;
          final rawConfig = positionalArgs[0];
          Map<String, dynamic> config;
          if (rawConfig is HTStruct) {
            config = rawConfig.toJSON();
          } else if (rawConfig is Map) {
            config = Map<String, dynamic>.from(rawConfig);
          } else {
            try {
              config = jsonDecode(jsonEncode(rawConfig));
            } catch (e) {
              debugPrint('[ConfigBinding] Config conversion failed: $e');
              config = {};
            }
          }
          await _delegate.updateConfig(config);
        };
      default:
        throw HTError.undefined(id);
    }
  }
}