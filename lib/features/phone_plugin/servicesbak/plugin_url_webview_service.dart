import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:yourcallyourrule/features/phone_plugin/services/plugin_script_service.dart';

class PluginUrlWebViewService {
  final PluginScriptService _scriptService = PluginScriptService();

  static const String defaultUserAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36';

  Future<String> getDeviceDefaultUserAgent() async {
    return await InAppWebViewController.getDefaultUserAgent();
  }

  Future<Map<String, dynamic>?> extractUrlFromScript(PluginEntry plugin) async {
    final scriptContent = await _scriptService.getScript(plugin);
    if (scriptContent.isEmpty) {
      debugPrint(
        '[PluginUrlWebViewService] Script is empty for plugin ${plugin.id}',
      );
      return null;
    }
    final baseUrlRegex = RegExp(
      r"""const\s+baseUrl\s*=\s*[`'"](https?:\/\/[^/]+\/)[^'"`]*[`'"];""",
    );
    final targetUrlRegex = RegExp(
      r"""const\s+targetSearchUrl\s*=\s*[`'"](https?:\/\/[^/]+\/)""",
    );
    final headersRegex = RegExp(r"""const\s+headers\s*=\s*(\{[\s\S]*?\});""");

    String? finalUrl;

    final baseUrlMatch = baseUrlRegex.firstMatch(scriptContent);
    if (baseUrlMatch != null) {
      finalUrl = baseUrlMatch.group(1);
      debugPrint('[PluginService] Extract strategy: found [baseUrl]: $finalUrl');
    } else {
      final targetUrlMatch = targetUrlRegex.firstMatch(scriptContent);
      if (targetUrlMatch != null) {
        finalUrl = targetUrlMatch.group(1);
        debugPrint(
          '[PluginService] Extract strategy: found [targetSearchUrl]: $finalUrl',
        );
      }
    }

    if (finalUrl == null) {
      debugPrint('[PluginService] Extract strategy: failed to find root url');
      return null;
    }

    Map<String, String> headers = {};
    final headersMatch = headersRegex.firstMatch(scriptContent);
    if (headersMatch != null) {
      try {
        String headersString = headersMatch.group(1)!;
        headersString = headersString.replaceAll("'", '"');
        headersString = headersString.replaceAll(RegExp(r',\s*}'), '}');
        headersString = headersString.replaceAllMapped(
          RegExp(r'([{,])\s*([a-zA-Z0-9_-]+)\s*:'),
          (match) => '${match.group(1)!}"${match.group(2)!}":',
        );
        final decodedHeaders =
            jsonDecode(headersString) as Map<String, dynamic>;
        headers = decodedHeaders.map(
          (key, value) => MapEntry(key, value.toString()),
        );
      } catch (e) {
        debugPrint('[PluginService] Error parsing headers from script: $e');
      }
    }

    return {'targetSearchUrl': finalUrl, 'headers': headers};
  }

  HeadlessInAppWebView? _headlessWebView;
  Completer<String>? _urlCompleter;

  static const String PROXY_SCHEME = "https";
  static const String PROXY_HOST = "flutter-webview-proxy.internal";
  static const String PROXY_PATH_FETCH = "/fetch";

  Future<String> generateUrlFromPhoneNumber(
    PluginEntry plugin,
    String phoneNumber,
  ) async {
    debugPrint(
      '[PluginUrlWebViewService] Starting dynamic URL generation for plugin ${plugin.id}',
    );
    _urlCompleter = Completer<String>();

    _headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri("about:blank")),

      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        useShouldInterceptRequest: true,
        userAgent:
            plugin.config['userAgent']?.toString().isNotEmpty == true
                ? plugin.config['userAgent']
                : defaultUserAgent,
      ),
      onWebViewCreated: (controller) async {
        debugPrint('[PluginUrlWebViewService] Headless WebView created.');

        controller.addJavaScriptHandler(
          handlerName: 'urlHandler',
          callback: (args) {
            if (args.isNotEmpty && args[0] is String) {
              final result = args[0] as String;
              if (result.startsWith('error:') &&
                  !(_urlCompleter?.isCompleted ?? true)) {
                debugPrint(
                  '[PluginUrlWebViewService] JS Error: ${result.substring(6)}',
                );
                _urlCompleter?.completeError(Exception(result.substring(6)));
              }
            }
          },
        );

        final scriptContent = await _scriptService.getScript(plugin);
        if (scriptContent.isNotEmpty) {
          await controller.evaluateJavascript(source: scriptContent);
          debugPrint('[PluginUrlWebViewService] Plugin script injected.');

          final pluginId = plugin.id;

          await controller.evaluateJavascript(
            source: """
            (function() {
              try {
                if (window.plugin && window.plugin['$pluginId'] && window.plugin['$pluginId'].generateOutput) {
                  console.log('Calling generateOutput for plugin $pluginId');
                  window.plugin['$pluginId'].generateOutput('$phoneNumber', null, null, 'dyn_gen_req_1');
                } else {
                   window.flutter_inappwebview.callHandler('urlHandler', 'error: generateOutput function not found for plugin $pluginId');
                }
              } catch(e) {
                 window.flutter_inappwebview.callHandler('urlHandler', 'error:' + e.toString());
              }
            })();
          """,
          );
        } else {
          _urlCompleter?.completeError(
            Exception("Script not found for plugin ${plugin.id}"),
          );
        }
      },
      shouldInterceptRequest: _shouldInterceptRequest,
      onConsoleMessage: (controller, consoleMessage) {
        debugPrint(
          "Headless Console [${consoleMessage.messageLevel}]: ${consoleMessage.message}",
        );
      },
    );

    await _headlessWebView?.run();
    debugPrint('[PluginUrlWebViewService] Headless WebView is running.');

    try {
      final url = await _urlCompleter!.future.timeout(
        const Duration(seconds: 20),
      );
      debugPrint(
        '[PluginUrlWebViewService] Dynamic URL generation successful: $url',
      );
      return url;
    } catch (e) {
      debugPrint(
        "[PluginUrlWebViewService] Error generating URL dynamically: $e",
      );
      rethrow;
    } finally {
      dispose();
    }
  }

  Future<WebResourceResponse?> _shouldInterceptRequest(
    InAppWebViewController controller,
    WebResourceRequest request,
  ) async {
    final uri = request.url;
    debugPrint(
      '[PluginUrlWebViewService] Intercepted request: ${uri.toString()}',
    );

    if (uri.scheme == PROXY_SCHEME &&
        uri.host == PROXY_HOST &&
        uri.path.startsWith(PROXY_PATH_FETCH)) {
      debugPrint(
        '[PluginUrlWebViewService] Proxy request matched: ${uri.toString()}',
      );

      if (!(_urlCompleter?.isCompleted ?? true)) {
        _urlCompleter?.complete(uri.toString());
        return WebResourceResponse(
          contentType: "text/plain",
          data: Uint8List.fromList([]),
          statusCode: 200,
        );
      }
    }
    return null;
  }

  void dispose() {
    debugPrint('[PluginUrlWebViewService] Disposing service...');
    _headlessWebView?.dispose();
    _headlessWebView = null;
    if (!(_urlCompleter?.isCompleted ?? true)) {
      _urlCompleter?.completeError(Exception("Service disposed prematurely"));
    }
  }
}
