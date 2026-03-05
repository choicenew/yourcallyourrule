import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/features/plugin/services/core/js_execution_service.dart';
import 'package:yourcallyourrule/features/plugin/services/core/native_request_channel.dart';
import 'package:http/http.dart' as http; // For loading script via URL

/// 插件测试服务
/// [Refactored] 使用 JsExecutionService + NativeRequestChannel (Core)
class PluginTestService {
  JsExecutionService? _jsService;
  NativeRequestChannel? _requestChannel;

  final StreamController<String> _logController =
      StreamController<String>.broadcast();
  Stream<String> get logStream => _logController.stream;

  bool _isPluginJsLoaded = false;
  String? _loadedPluginId;
  final Map<String, Completer<Map<String, dynamic>?>> _requestCompleters = {};

  void _addLog(String log) {
    debugPrint(log);
    _logController.add(log);
  }

  Future<void> initialize() async {
    _addLog("Initializing PluginTestService (JS Engine)...");

    _jsService = JsExecutionService(onLog: (msg) => _addLog(msg));
    await _jsService!.init();

    // Use Core Native Channel
    const defaultUA =
        'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36';

    _requestChannel = NativeRequestChannel(
      _jsService!,
      defaultUserAgent: defaultUA,
      onLog: (msg) => _addLog('[NET] $msg'),
    );
    _requestChannel!.register();

    _setupHandlers();

    _addLog("Test Service Ready.");
  }

  void _setupHandlers() {
    // Plugin Loaded Monitor
    _jsService!.registerHandler('TestPageChannel', (args) {
      // ... (Logic to detect 'pluginLoaded' message similar to PluginExecutionService)
      // For testing, we just log and check simple string logic or JSON
      dynamic message = args;
      if (args is List && args.isNotEmpty) message = args[0];

      _addLog("TestPageChannel: $message");

      if (message.toString().contains('pluginLoaded')) {
        // Try parsing
        try {
          if (message is String) message = jsonDecode(message);
          if (message['type'] == 'pluginLoaded') {
            _loadedPluginId = message['pluginId'];
            _isPluginJsLoaded = true;
            _addLog("Plugin Loaded ID: $_loadedPluginId");
          }
        } catch (e) {
          _addLog("Error parsing pluginLoaded: $e");
        }
      }
    });

    // Result Monitor
    _jsService!.registerHandler('PluginResultChannel', (args) {
      dynamic message = args;
      if (args is List && args.isNotEmpty) message = args[0];
      _addLog("PluginResult: $message");

      try {
        Map<String, dynamic> result;
        if (message is String)
          result = jsonDecode(message);
        else
          result = Map<String, dynamic>.from(message);

        final requestId = result['requestId'];
        if (requestId != null && _requestCompleters.containsKey(requestId)) {
          _requestCompleters.remove(requestId)!.complete(result);
        }
      } catch (e) {
        _addLog("Error parsing result: $e");
      }
    });
  }

  Future<void> _loadPluginJs(PluginEntry plugin) async {
    final url = plugin.url;
    if (url.isEmpty) {
      _addLog("Error: Plugin URL is empty");
      return;
    }

    _addLog("Fetching script from $url...");
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        await _jsService!.evaluate(response.body);
        _addLog("Script injected.");
      } else {
        _addLog("Failed to fetch script: ${response.statusCode}");
      }
    } catch (e) {
      _addLog("Error fetching script: $e");
    }
  }

  Future<Map<String, dynamic>?> testPlugin(
    PluginEntry plugin, {
    String? phoneNumber,
    String? nationalNumber,
    String? e164Number,
  }) async {
    if (_jsService == null) {
      await initialize();
    }

    _isPluginJsLoaded = false;
    _loadedPluginId = null;

    await _loadPluginJs(plugin);

    // Wait for load
    int attempts = 0;
    while (!_isPluginJsLoaded && attempts < 50) {
      await Future.delayed(const Duration(milliseconds: 100));
      attempts++;
    }

    if (!_isPluginJsLoaded || _loadedPluginId == null) {
      _addLog(
        "Warning: pluginLoaded message not received. Attempting to run anyway (assuming explicit ID ${plugin.id})...",
      );
      _loadedPluginId = plugin.id; // Fallback
    }

    final requestId = 'test_${DateTime.now().millisecondsSinceEpoch}';
    final completer = Completer<Map<String, dynamic>?>();
    _requestCompleters[requestId] = completer;

    _addLog("Running generateOutput...");
    try {
      await _jsService!.injectConfig(plugin.id, plugin.config);

      await _jsService!.evaluate('''
         (function() {
            if (globalThis.plugin && globalThis.plugin['${plugin.id}']) {
               globalThis.plugin['${plugin.id}'].generateOutput(
                  '$phoneNumber', '$nationalNumber', '$e164Number', '$requestId'
               );
            } else {
               console.error('Plugin ${plugin.id} not found!');
            }
         })();
       ''');

      return await completer.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          _requestCompleters.remove(requestId);
          _addLog("Timeout waiting for result.");
          return {'error': 'Timeout'};
        },
      );
    } catch (e) {
      _requestCompleters.remove(requestId);
      _addLog("Error: $e");
      rethrow;
    } finally {
      // [FIX] Ensure Headless WebView is stopped and cleaned up after test
      _addLog("Cleaning up channel resources...");
      await _requestChannel?.cleanup();
    }
  }

  void dispose() {
    _jsService?.dispose();
    _logController.close();
  }
}
