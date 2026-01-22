import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_js/flutter_js.dart';

class JsExecutionService {
  late JavascriptRuntime _runtime;

  // Callback for UI logging
  Function(String)? onLog;

  // Callback for when JS calls RequestChannel
  Function(dynamic message)? onRequestChannel;

  JsExecutionService({this.onLog});

  Future<void> init() async {
    _runtime = getJavascriptRuntime();

    // 2. Initialize JS Runtime & Console Bridge
    // We need 'console' to see logs in the UI.
    // CRITICAL FIX: The plugin relies on 'window' to Attach itself.
    // QuickJS does not have 'window' by default. We must polyfill it.
    const consoleBridge = """
      var window = this; 
      if (typeof console === 'undefined' || !console.log) {
          var console = {
              log: function(msg) { sendMessage('Log', msg); },
              error: function(msg) { sendMessage('Log', '[ERROR] ' + msg); },
              warn: function(msg) { sendMessage('Log', '[WARN] ' + msg); }
          };
      }
    """;
    await _runtime.evaluate(consoleBridge);

    // We only need to listen to channels.
    _runtime.onMessage('httpFetch', (dynamic args) async {
      if (onRequestChannel != null) {
        return await onRequestChannel!(args);
      }
      return null;
    });

    _runtime.onMessage('PluginResultChannel', (dynamic args) {
      final msg = "⚡ JS PluginResult: $args";
      debugPrint(msg);
      onLog?.call(msg);
    });

    _runtime.onMessage('TestPageChannel', (dynamic args) {
      final msg = "⚡ JS TestPage: $args";
      debugPrint(msg);
      onLog?.call(msg);
    });

    _runtime.onMessage('Log', (dynamic args) {
      debugPrint("JS Log: $args");
      onLog?.call("JS: $args");
    });
  }

  /// Executes a JS script
  Future<JsEvalResult> evaluate(String script) async {
    return _runtime.evaluate(script);
  }

  /// Sends data back to JS by evaluating a script
  /// Example: window.plugin['tellows'].handleResponse(...)
  Future<void> sendNativeResponse(String script) async {
    debugPrint("Sending Native Response to JS: $script");
    await _runtime.evaluate(script);
  }

  /// Injects configuration into the plugin (e.g. User-Agent)
  Future<void> injectConfig(
    String pluginId,
    Map<String, dynamic> config,
  ) async {
    final configJson = jsonEncode(config);
    final script =
        """
      if (window.plugin && window.plugin['$pluginId']) {
          window.plugin['$pluginId'].config = $configJson;
          console.log('[Native] Injected config for $pluginId');
      } else {
          console.warn('[Native] Plugin $pluginId not found during config injection');
      }
    """;
    await _runtime.evaluate(script);
  }

  void dispose() {
    _runtime.dispose();
  }
}
