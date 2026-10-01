import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ua_client_hints/ua_client_hints.dart';
import 'package:plugindemo/core/entities/plugin/plugin_entry.dart';
import 'package:plugindemo/features/plugin/services/core/js_execution_service.dart';
import 'package:plugindemo/features/plugin/services/core/native_request_channel.dart';
import 'package:plugindemo/features/plugin/services/core/transient_plugin_session.dart';

/// 插件执行服务 - 负责插件 JS 的加载与执行
class PluginExecutionService {
  static final PluginExecutionService _instance =
      PluginExecutionService._internal();
  factory PluginExecutionService() => _instance;
  PluginExecutionService._internal();

  JsExecutionService? _jsService;
  NativeRequestChannel? _requestChannel;
  String? _systemUserAgent;

  final Completer<void> _initCompleter = Completer<void>();
  bool _isInitializing = false;

  final Map<String, bool> _pluginReadyStatus = {};

  final StreamController<String> _pluginReadyController =
      StreamController<String>.broadcast();

  final Map<String, Completer<Map<String, dynamic>?>> _pluginQueryCompleters =
      {};

  Stream<String> get pluginReadyStream => _pluginReadyController.stream;

  Future<void> initialize() async {
    if (_initCompleter.isCompleted) return;
    if (_isInitializing) return _initCompleter.future;

    _isInitializing = true;

    try {
      debugPrint('[PluginExecutionService] Initializing Core Services...');

      _jsService = JsExecutionService(
        onLog: (msg) => debugPrint('[JS-LOG] $msg'),
      );
      await _jsService!.init();

      try {
        _systemUserAgent = await userAgent();
      } catch (e) {
        debugPrint('⚠️ ua_client_hints failed, using fallback: $e');
        _systemUserAgent =
            'Mozilla/5.0 (Linux; Android 14; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Mobile Safari/537.36';
      }

      _requestChannel = NativeRequestChannel(
        _jsService!,
        defaultUserAgent: _systemUserAgent!,
        onLog: (msg) {
          debugPrint('[NET-LOG] $msg');
        },
      );
      _requestChannel!.register();

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
    _jsService!.registerHandler('TestPageChannel', (args) {
      try {
        dynamic message = args;
        if (args is List && args.isNotEmpty) message = args[0];

        if (message is String && message.contains('pluginLoaded')) {
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

    if (_systemUserAgent != null) {
      await _jsService!.injectConfig(pluginId, {'userAgent': _systemUserAgent});
    }
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
      await _jsService!.injectConfig(pluginId, config ?? {});

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

  Future<List<Map<String, dynamic>>> executeBatchSession({
    required List<PluginEntry> enabledPlugins,
    required String phoneNumber,
    required String nationalNumber,
    required String e164Number,
    required void Function(Map<String, dynamic> firstValidResult) onFirstResult,
    required void Function(Map<String, dynamic> singleResult) onResultCompleted,
  }) async {
    final session = TransientPluginSession();
    return await session.executeSession(
      enabledPlugins: enabledPlugins,
      phoneNumber: phoneNumber,
      nationalNumber: nationalNumber,
      e164Number: e164Number,
      onFirstResult: onFirstResult,
      onResultCompleted: onResultCompleted,
    );
  }

  void dispose() {
    _jsService?.dispose();
    _pluginReadyController.close();
  }

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
      return jsonDecode(res.stringResult);
    } catch (e) {
      return [];
    }
  }
}
