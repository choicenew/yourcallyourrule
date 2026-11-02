import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ua_client_hints/ua_client_hints.dart';
import 'package:plugindemo/core/entities/plugin/plugin_entry.dart';
import 'package:plugindemo/features/plugin/services/core/js_execution_service.dart';
import 'package:plugindemo/features/plugin/services/core/native_request_channel.dart';
import 'package:plugindemo/features/plugin/services/plugin_script_service.dart';

class TransientPluginSession {
  final PluginScriptService _scriptService = PluginScriptService();
  static String? _cachedSystemUserAgent;

  static Future<String> _getSystemUserAgent() async {
    if (_cachedSystemUserAgent != null) return _cachedSystemUserAgent!;
    try {
      _cachedSystemUserAgent = await userAgent();
    } catch (e) {
      debugPrint('⚠️ TransientPluginSession: UA fetch fallback: $e');
      _cachedSystemUserAgent =
          'Mozilla/5.0 (Linux; Android 14; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Mobile Safari/537.36';
    }
    return _cachedSystemUserAgent!;
  }

  static bool _isValidResult(Map<String, dynamic> result) {
    if (result['success'] != true) return false;
    final sourceLabel = result['sourceLabel']?.toString().trim() ?? '';
    final predefinedLabel = result['predefinedLabel']?.toString().trim() ?? '';
    final name = result['name']?.toString().trim() ?? '';
    final count = result['count'] ?? 0;
    return (sourceLabel.isNotEmpty && sourceLabel != 'No Match') ||
        (predefinedLabel.isNotEmpty && predefinedLabel != 'Unknown') ||
        (name.isNotEmpty && name != 'unknown') ||
        (count is int && count > 0);
  }

  Future<List<Map<String, dynamic>>> executeSession({
    required List<PluginEntry> enabledPlugins,
    required String phoneNumber,
    required String nationalNumber,
    required String e164Number,
    required void Function(Map<String, dynamic> firstValidResult) onFirstResult,
    required void Function(Map<String, dynamic> singleResult) onResultCompleted,
  }) async {
    if (enabledPlugins.isEmpty) return [];

    final jsService = JsExecutionService(
      onLog: (msg) => debugPrint('[TRANSIENT-JS] $msg'),
    );

    final results = <Map<String, dynamic>>[];
    bool firstResultTriggered = false;

    try {
      debugPrint(
        '🚀 [TransientPluginSession] Spin up QuickJS session for ${enabledPlugins.length} plugins...',
      );

      await jsService.init();

      final sysUserAgent = await _getSystemUserAgent();
      final requestChannel = NativeRequestChannel(
        jsService,
        defaultUserAgent: sysUserAgent,
        onLog: (msg) => debugPrint('[TRANSIENT-NET] $msg'),
      );
      requestChannel.register();

      final Map<String, Completer<Map<String, dynamic>?>> queryCompleters = {};

      jsService.registerHandler('TestPageChannel', (args) {});
      jsService.registerHandler('PluginResultChannel', (args) {
        try {
          dynamic message = args;
          if (args is List && args.isNotEmpty) message = args[0];
          Map<String, dynamic> res;
          if (message is String) {
            res = jsonDecode(message);
          } else {
            res = Map<String, dynamic>.from(message);
          }

          final reqId = res['requestId']?.toString();
          if (reqId != null && queryCompleters.containsKey(reqId)) {
            final completer = queryCompleters.remove(reqId)!;
            if (!completer.isCompleted) {
              completer.complete(res);
            }
          }
        } catch (e) {
          debugPrint('⚠️ TransientPluginSession: Result decode error: $e');
        }
      });

      for (final plugin in enabledPlugins) {
        try {
          final scriptContent = await _scriptService.getScript(plugin);
          if (scriptContent.isNotEmpty) {
            await jsService.evaluate(scriptContent);
            await jsService.injectConfig(plugin.id, {
              'userAgent': sysUserAgent,
              ...plugin.config,
            });
          } else {
            debugPrint(
              '⚠️ TransientPluginSession: Empty script for plugin ${plugin.id}',
            );
          }
        } catch (e) {
          debugPrint(
            '⚠️ TransientPluginSession: Load script error (${plugin.id}): $e',
          );
        }
      }

      final List<Future<void>> taskFutures = [];

      for (final plugin in enabledPlugins) {
        final requestId =
            'transient_${plugin.id}_${DateTime.now().millisecondsSinceEpoch}';
        final completer = Completer<Map<String, dynamic>?>();
        queryCompleters[requestId] = completer;

        final task = Future(() async {
          try {
            await jsService.evaluate('''
              (function() {
                if (globalThis.plugin && globalThis.plugin['${plugin.id}']) {
                  globalThis.plugin['${plugin.id}'].generateOutput(
                    "$phoneNumber",
                    "$nationalNumber",
                    "$e164Number",
                    "$requestId"
                  );
                }
              })();
            ''');

            final res = await completer.future.timeout(
              const Duration(seconds: 10),
              onTimeout: () {
                queryCompleters.remove(requestId);
                return null;
              },
            );

            if (res != null) {
              results.add(res);
              onResultCompleted(res);

              if (!firstResultTriggered && _isValidResult(res)) {
                firstResultTriggered = true;
                onFirstResult(res);
              }
            }
          } catch (e) {
            queryCompleters.remove(requestId);
            debugPrint(
              '⚠️ TransientPluginSession: Exec error (${plugin.id}): $e',
            );
          }
        });

        taskFutures.add(task);
      }

      await Future.wait(
        taskFutures,
      ).timeout(const Duration(seconds: 12), onTimeout: () => []);

      return results;
    } catch (e) {
      debugPrint('⚠️ TransientPluginSession: Session Exception: $e');
      return results;
    } finally {
      jsService.dispose();
      debugPrint(
        '🧹 [TransientPluginSession] Session completed. QuickJS engine DISPOSED & RAM cleared.',
      );
    }
  }
}
