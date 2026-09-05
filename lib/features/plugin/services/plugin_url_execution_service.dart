import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_script_service.dart';

import 'core/js_execution_service.dart';

/// 动态 URL 生成服务
/// [Refactored] 使用 JsExecutionService + 模拟 RequestChannel 来捕获 URL
class PluginUrlExecutionService {
  final PluginScriptService _scriptService = PluginScriptService();

  // --- Scheme 1: Static Extraction (Regex) ---
  // 保持原有逻辑不变，这是纯 Dart 实现，无需 JS 引擎
  static const String defaultUserAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36';

  Future<String> getDeviceDefaultUserAgent() async {
    try {
      return await InAppWebViewController.getDefaultUserAgent();
    } catch (e) {
      debugPrint('Error getting device UA: $e');
      return defaultUserAgent;
    }
  }

  Future<Map<String, dynamic>?> extractUrlFromScript(PluginEntry plugin) async {
    final scriptContent = await _scriptService.getScript(plugin);
    if (scriptContent.isEmpty) return null;

    final baseUrlRegex = RegExp(
      r"""const\s+baseUrl\s*=\s*[`'"](https?:\/\/[^/]+\/)[^'"`]*[`'"];""",
    );
    final targetUrlRegex = RegExp(
      r"""const\s+(?:targetUrl|targetSearchUrl|target_url|url)\s*=\s*[`'"](https?:\/\/[^/]+\/)""",
    );
    final headersRegex = RegExp(r"""const\s+headers\s*=\s*(\{[\s\S]*?\});""");

    String? finalUrl;
    final baseUrlMatch = baseUrlRegex.firstMatch(scriptContent);
    if (baseUrlMatch != null) {
      finalUrl = baseUrlMatch.group(1);
    } else {
      final targetUrlMatch = targetUrlRegex.firstMatch(scriptContent);
      if (targetUrlMatch != null) {
        finalUrl = targetUrlMatch.group(1);
      }
    }

    if (finalUrl == null) return null;

    Map<String, String> headers = {};
    final headersMatch = headersRegex.firstMatch(scriptContent);
    if (headersMatch != null) {
      try {
        String headersString = headersMatch.group(1)!;
        // 简单修复 headers 字符串格式以符合 JSON 标准
        headersString = headersString.replaceAll("'", '"');
        headersString = headersString.replaceAll(RegExp(r',\s*}'), '}');
        // Handle 'userAgent' variable which breaks static JSON parsing
        // We replace it with the hardcoded default UA just for this static extraction
        headersString = headersString.replaceAll(
          RegExp(r':\s*userAgent\b'),
          ': "$defaultUserAgent"',
        );
        headersString = headersString.replaceAllMapped(
          RegExp(r'([{,])\s*([a-zA-Z0-9_-]+)\s*:'),
          (match) => '${match.group(1)!}"${match.group(2)!}":',
        );
        final decodedHeaders =
            jsonDecode(headersString) as Map<String, dynamic>;
        headers = decodedHeaders.map(
          (key, value) => MapEntry(key.toString(), value.toString()),
        );
      } catch (e) {
        debugPrint('[PluginUrlExecutionService] Error parsing headers: $e');
      }
    }

    return {'targetSearchUrl': finalUrl, 'headers': headers};
  }

  // --- Scheme 2: Dynamic Generation (via JS) ---

  Future<String> generateUrlFromPhoneNumber(
    PluginEntry plugin,
    String phoneNumber,
  ) async {
    debugPrint(
      '[PluginUrlExecutionService] Dynamic Generation via JS Engine for ${plugin.id}',
    );

    JsExecutionService? jsService;
    final completer = Completer<String>();

    try {
      // 1. Init Transient JS Engine
      jsService = JsExecutionService(
        // Silently ignore generic logs
      );
      await jsService.init();

      // 2. Register Capturing Channel
      // 我们不发网络请求，只是为了捕获 URL
      jsService.onRequestChannel = (dynamic message) async {
        if (completer.isCompleted) return null;

        try {
          Map<String, dynamic> req;
          if (message is String) {
            req = jsonDecode(message);
          } else {
            req = Map<String, dynamic>.from(message);
          }

          final url = req['url'];
          if (url != null && url.toString().isNotEmpty) {
            debugPrint('[PluginUrlExecutionService] Captured URL: $url');
            completer.complete(url.toString());
          }
        } catch (e) {
          debugPrint('Error parsing captured request: $e');
        }
        return null; // Don't care about response
      };

      // 3. Load Script
      final script = await _scriptService.getScript(plugin);
      if (script.isEmpty) throw Exception('Script empty');
      await jsService.evaluate(script);

      // 4. Inject Config & Call generateOutput
      // 使用 window.plugin 方式
      await jsService.injectConfig(plugin.id, plugin.config);

      final requestId = 'dyn_url_${DateTime.now().millisecondsSinceEpoch}';

      await jsService.evaluate('''
        (function() {
          if (globalThis.plugin && globalThis.plugin['${plugin.id}']) {
            globalThis.plugin['${plugin.id}'].generateOutput(
               '$phoneNumber', null, null, '$requestId'
            );
          }
        })();
      ''');

      // 5. Wait for Capture
      return await completer.future.timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw TimeoutException('URL generation timed out'),
      );
    } catch (e) {
      debugPrint('[PluginUrlExecutionService] Generation Failed: $e');
      rethrow;
    } finally {
      jsService?.dispose();
    }
  }
}
