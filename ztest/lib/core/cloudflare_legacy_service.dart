// ztest/lib/core/cloudflare_legacy_service.dart

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'cloudflare_legacy_interceptor.dart';
import 'cloudflare_scripts.dart';

/// CloudflareLegacyService - 移植自 Legacy PluginTestService
/// 职责：管理 HeadlessWebView 的生命周期，初始化 about:blank 环境，并驱动代理 Iframe。
class CloudflareLegacyService {
  static final CloudflareLegacyService _instance =
      CloudflareLegacyService._internal();
  factory CloudflareLegacyService() => _instance;

  HeadlessInAppWebView? _headlessWebView;
  final _interceptor = CloudflareLegacyInterceptor();

  Completer<Map<String, dynamic>?>? _currentBypassCompleter;

  CloudflareLegacyService._internal();

  /// 初始化并启动过盾引擎
  Future<void> _ensureInitialized() async {
    if (_headlessWebView != null && _headlessWebView!.isRunning()) return;

    debugPrint('🛡️ [Legacy-Service] Initializing Tiny Legacy Engine...');

    _headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri('about:blank')),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        domStorageEnabled: true,
        databaseEnabled: true,
        useHybridComposition: true, // Legacy 必备
        useShouldInterceptRequest: true,
        userAgent:
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36',
      ),
      onWebViewCreated: (controller) async {
        debugPrint('🛡️ [Legacy-Service] WebView Created.');

        // 1. 设置 TestPageChannel (日志记录)
        controller.addJavaScriptHandler(
          handlerName: 'TestPageChannel',
          callback: (args) {
            if (args.isNotEmpty) {
              debugPrint('🛡️ [JS-Bridge-Log] ${args[0]}');
            }
          },
        );

        // 2. 设置结果监听
        controller.addJavaScriptHandler(
          handlerName: 'PluginResultChannel',
          callback: (args) {
            if (args.isNotEmpty) {
              _onResultReceived(args[0]);
            }
          },
        );

        // 3. 注入桥接脚本
        await controller.evaluateJavascript(
          source: CloudflareScripts.bridgeTemplateJs,
        );
        debugPrint(
          '🛡️ [Legacy-Service] Bridge Template injected into about:blank.',
        );
      },
      shouldInterceptRequest: (controller, request) {
        return _interceptor.handleRequest(controller, request);
      },
      onConsoleMessage: (controller, consoleMessage) {
        debugPrint(
          '🛡️ [JS-Console] ${consoleMessage.messageLevel}: ${consoleMessage.message}',
        );
      },
    );

    await _headlessWebView?.run();
    debugPrint('🛡️ [Legacy-Service] Engine is running.');
  }

  /// 执行绕过任务
  Future<Map<String, dynamic>?> executeBypass(
    String targetUrl, {
    String? requestId,
    String? successMarker,
  }) async {
    await _ensureInitialized();

    final id = requestId ?? 'bypass_${DateTime.now().millisecondsSinceEpoch}';

    // 如果已有未完成的任务，先取消它 (或者抛错，取决于策略)
    if (_currentBypassCompleter != null &&
        !_currentBypassCompleter!.isCompleted) {
      debugPrint(
        '⚠️ [Legacy-Service] Cancelling previous bypass task for new request.',
      );
      _currentBypassCompleter!.complete(null);
    }

    _currentBypassCompleter = Completer<Map<String, dynamic>?>();

    // 将 successMarker 编码进 URL 供 ResultMonitor 读取
    final marker = successMarker ?? 'number_data_box';
    final proxiedUrl =
        targetUrl +
        (targetUrl.contains('?') ? '&' : '?') +
        'successMarker=' +
        Uri.encodeComponent(marker) +
        '&requestId=' +
        id;

    debugPrint('🛡️ [Legacy-Service] Executing: $targetUrl (ID: $id)');

    // 调用 Bridge 开启 Iframe 代理
    await _headlessWebView?.webViewController?.evaluateJavascript(
      source: 'window.startLegacyBypass("$proxiedUrl", "$id");',
    );

    try {
      // 这里的超时时间可以设长一点，因为过盾可能需要点时间
      return await _currentBypassCompleter!.future.timeout(
        const Duration(seconds: 45),
        onTimeout: () {
          debugPrint('🛡️ [Legacy-Service] Timeout for ID: $id');
          _interceptor.cleanupSession(id);
          return null;
        },
      );
    } catch (e) {
      debugPrint('🛡️ [Legacy-Service] Error in $id: $e');
      _interceptor.cleanupSession(id);
      return null;
    }
  }

  void _onResultReceived(dynamic result) {
    if (_currentBypassCompleter != null &&
        !_currentBypassCompleter!.isCompleted) {
      debugPrint(
        '🛡️ [Legacy-Service] Result Received! Propagating to caller...',
      );
      try {
        Map<String, dynamic> finalResult;
        if (result is String) {
          try {
            finalResult = Map<String, dynamic>.from(jsonDecode(result));
          } catch (_) {
            finalResult = {'raw': result};
          }
        } else if (result is Map) {
          finalResult = Map<String, dynamic>.from(result);
        } else {
          finalResult = {'data': result};
        }

        // 如果内部数据包还包含 data 字段（Bridge 转发），拆出来
        if (finalResult.containsKey('data') && finalResult['data'] is Map) {
          finalResult = Map<String, dynamic>.from(finalResult['data']);
        }

        _currentBypassCompleter!.complete(finalResult);
      } catch (e) {
        debugPrint('🛡️ [Legacy-Service] Result parsing error: $e');
        _currentBypassCompleter!.complete(null);
      }
    }
  }

  void dispose() {
    _headlessWebView?.dispose();
    _headlessWebView = null;
  }
}
