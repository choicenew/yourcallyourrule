import 'package:flutter/foundation.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';
import '../../../delegates/delegates.dart';

class WebviewBinding extends HTExternalClass {
  final WebViewDelegate _delegate;

  WebviewBinding(this._delegate) : super('Webview');

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'Webview.fetch':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) async {
          try {
            if (positionalArgs.isEmpty) {
              return "";
            }
            final url = positionalArgs[0]?.toString() ?? '';

            List<String>? purgeRules;
            final rawRules = namedArgs['purgeRules'];
            if (rawRules is List) {
              purgeRules = rawRules.map((e) => e.toString()).toList();
            }
            final waitFor = namedArgs['waitFor']?.toString();

            // Extract headers
            Map<String, String>? headers;
            final rawHeaders = namedArgs['headers'];
            if (rawHeaders is Map) {
              headers = rawHeaders.map(
                  (key, value) => MapEntry(key.toString(), value.toString()));
            }

            final allowNavigation = namedArgs['allowNavigation'] == true;

            return await _delegate.fetch(url,
                purgeRules: purgeRules,
                waitFor: waitFor,
                headers: headers,
                allowNavigation: allowNavigation);
          } catch (e) {
            debugPrint("🔥 [WebviewBinding] fetch error: $e");
            return "";
          }
        };
      case 'Webview.openAndGetCookies':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) async {
          try {
            if (positionalArgs.isEmpty) return "";
            final url = positionalArgs[0]?.toString() ?? '';
            final userAgent = namedArgs['userAgent']?.toString();
            return await _delegate.openAndGetCookies(url, userAgent: userAgent);
          } catch (e) {
            debugPrint("🔥 [WebviewBinding] cookie error: $e");
            return "";
          }
        };
      case 'Webview.solve': // 触发人工验证
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) async {
          try {
            if (positionalArgs.isEmpty) return false;
            final url = positionalArgs[0]?.toString() ?? '';
            if (_delegate is CookieDelegate) {
              return await (_delegate as CookieDelegate).solveChallenge(url);
            }
            return false;
          } catch (e) {
            debugPrint("🔥 [WebviewBinding] solve error: $e");
            return false;
          }
        };
      case 'Webview.getUserAgent':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) {
          try {
            return _delegate.getUserAgent() ?? '';
          } catch (e) {
            debugPrint('🔥 [WebviewBinding] Error getting UA: $e');
            return '';
          }
        };
      default:
        throw HTError.undefined(id);
    }
  }
}
