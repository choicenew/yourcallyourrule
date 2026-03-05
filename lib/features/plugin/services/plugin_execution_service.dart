import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:yourcallyourrule/features/plugin/services/core/js_execution_service.dart';
import 'package:yourcallyourrule/features/plugin/services/core/native_request_channel.dart';

/// 插件执行服务 - 负责插件 JS 的加载与执行
/// [Refactored] 移除 WebView，改用 JsExecutionService + NativeRequestChannel
class PluginExecutionService {
  static final PluginExecutionService _instance =
      PluginExecutionService._internal();
  factory PluginExecutionService() => _instance;
  PluginExecutionService._internal();

  JsExecutionService? _jsService;
  NativeRequestChannel? _requestChannel;
  String? _systemUserAgent; // Store System UA

  final Completer<void> _initCompleter = Completer<void>();
  bool _isInitializing = false;

  // 跟踪每个插件的就绪状态
  final Map<String, bool> _pluginReadyStatus = {};

  // 用于通知插件就绪状态的StreamController
  final StreamController<String> _pluginReadyController =
      StreamController<String>.broadcast();

  // 存储每个插件查询的Completer
  final Map<String, Completer<Map<String, dynamic>?>> _pluginQueryCompleters =
      {};

  Stream<String> get pluginReadyStream => _pluginReadyController.stream;

  Future<void> initialize() async {
    if (_initCompleter.isCompleted) return;
    if (_isInitializing) return _initCompleter.future;

    _isInitializing = true;

    try {
      debugPrint('[PluginExecutionService] Initializing Core Services...');

      // 1. Init JS Engine
      _jsService = JsExecutionService(
        onLog: (msg) => debugPrint('[JS-LOG] $msg'),
      );
      await _jsService!.init();

      // 2. Init Network Channel
      // Use Real Device User-Agent (System UA) to match ztest behavior.
      try {
        _systemUserAgent = await InAppWebViewController.getDefaultUserAgent();
      } catch (e) {
        debugPrint('⚠️ Failed to get system UA, using default: $e');
        _systemUserAgent =
            'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Mobile Safari/537.36';
      }

      _requestChannel = NativeRequestChannel(
        _jsService!,
        defaultUserAgent: _systemUserAgent!,
        onLog: (msg) {
          debugPrint('[NET-LOG] $msg');
        },
      );
      _requestChannel!.register();

      // 3. Register Callbacks
      _registerJsCallbacks();

      debugPrint(
        '[PluginExecutionService] Initialization Complete. UA: $_systemUserAgent',
      );
      _initCompleter.complete();
    } catch (e) {
      debugPrint('[PluginExecutionService] Init Failed: $e');
      _isInitializing = false;
      rethrow;
    }
  }

  void _registerJsCallbacks() {
    // Plugin Ready
    _jsService!.registerHandler('TestPageChannel', (args) {
      // Adapted from ztest/plugindemo logic
      // The old format was stringified JSON
      try {
        dynamic message = args;
        if (args is List && args.isNotEmpty) message = args[0];

        if (message is String && message.contains('pluginLoaded')) {
          // Sometimes it's mixed: "Plugin Loaded: {json}"
          // But if it's pure JSON, let's try decode.
          try {
            final data = jsonDecode(message);
            if (data['type'] == 'pluginLoaded') {
              final pid = data['pluginId'];
              _pluginReadyStatus[pid] = true;
              _pluginReadyController.add(pid);
            }
          } catch (_) {}
        } else if (message is Map) {
          if (message['type'] == 'pluginLoaded' ||
              message['type'] == 'pluginReady') {
            final pid = message['pluginId'];
            _pluginReadyStatus[pid] = true;
            _pluginReadyController.add(pid);
          }
        }
      } catch (e) {
        debugPrint('Error parsing TestPageChannel message: $e');
      }
    });

    // Plugin Result
    _jsService!.registerHandler('PluginResultChannel', (args) {
      try {
        dynamic message = args;
        if (args is List && args.isNotEmpty) message = args[0];

        Map<String, dynamic> result;
        if (message is String) {
          result = jsonDecode(message);
        } else {
          result = Map<String, dynamic>.from(message);
        }

        final requestId = result['requestId'];
        if (requestId != null &&
            _pluginQueryCompleters.containsKey(requestId)) {
          final completer = _pluginQueryCompleters.remove(requestId)!;

          final bool success = result['success'] ?? false;
          final String? error = result['error']?.toString();

          if (success) {
            completer.complete(result);
          } else {
            if (error == null || error.isEmpty) {
              completer.complete(null);
            } else {
              completer.completeError(error);
            }
          }
        }
      } catch (e) {
        debugPrint('Error processing PluginResultChannel: $e');
      }
    });
  }

  Future<void> loadScript(String pluginId, String script) async {
    await initialize();

    debugPrint('Loading script for plugin: $pluginId');
    _pluginReadyStatus[pluginId] = false;

    await _jsService!.evaluate(script);

    // CRITICAL FIX: Inject System UA immediately, matching ztest logic.
    // This prevents the plugin from using its fallback hardcoded UA.
    if (_systemUserAgent != null) {
      await _jsService!.injectConfig(pluginId, {'userAgent': _systemUserAgent});
    }

    // Auto-notify that script execution is done (though we usually wait for explicit 'pluginReady')
    // ztest doesn't use 'waitForPluginReady' the same way, but plugindemo does.
    // We rely on the script calling `sendPluginLoaded()` or similar.
  }

  Future<void> waitForPluginReady(String pluginId) async {
    await initialize();
    if (_pluginReadyStatus[pluginId] == true) return;

    final completer = Completer<void>();
    final subscription = _pluginReadyController.stream.listen((id) {
      if (id == pluginId && !completer.isCompleted) {
        completer.complete();
      }
    });

    try {
      await completer.future.timeout(const Duration(seconds: 5));
    } on TimeoutException {
      debugPrint('Timeout waiting for plugin $pluginId');
    } finally {
      subscription.cancel();
    }
  }

  // 生成插件输出 (核心业务)
  Future<Map<String, dynamic>?> generatePluginOutput(
    String pluginId,
    String phoneNumber,
    String nationalNumber,
    String e164Number, {
    Map<String, dynamic>? config,
  }) async {
    await initialize();

    final requestId =
        'query_${pluginId}_${DateTime.now().millisecondsSinceEpoch}';
    final completer = Completer<Map<String, dynamic>?>();
    _pluginQueryCompleters[requestId] = completer;

    try {
      // 1. Inject Config
      await _jsService!.injectConfig(pluginId, config ?? {});

      // 2. Call generateOutput
      // Note: We use window.plugin... as per our JS environment
      await _jsService!.evaluate('''
        (function() {
          if (globalThis.plugin && globalThis.plugin['$pluginId']) {
            globalThis.plugin['$pluginId'].generateOutput(
              "$phoneNumber",
              "$nationalNumber",
              "$e164Number",
              "$requestId"
            );
          } else {
             console.error('Plugin $pluginId not found for generateOutput');
          }
        })();
      ''');

      return await completer.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          _pluginQueryCompleters.remove(requestId);
          throw TimeoutException('Plugin query timed out');
        },
      );
    } catch (e) {
      _pluginQueryCompleters.remove(requestId);
      rethrow;
    }
  }

  void dispose() {
    _jsService?.dispose();
    _pluginReadyController.close();
  }

  // 辅助方法：获取 Settings
  Future<List<dynamic>?> getPluginSettings(String pluginId) async {
    await initialize();
    try {
      final res = await _jsService!.evaluate('''
        (function() {
           if (globalThis.plugin && globalThis.plugin['$pluginId'] && globalThis.plugin['$pluginId'].info) {
              return JSON.stringify(globalThis.plugin['$pluginId'].info.settings || []);
           }
           return "[]";
        })();
      ''');
      // res is JsEvalResult, stringResult
      return jsonDecode(res.stringResult);
    } catch (e) {
      return [];
    }
  }
}
