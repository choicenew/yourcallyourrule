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
  CloudflareLegacyInterceptor? _interceptor;

  Completer<Map<String, dynamic>?>? _currentBypassCompleter;
  String? _activeRequestId;

  CloudflareLegacyService._internal();

  /// 初始化并启动过盾引擎
  Future<void> _ensureInitialized({String? userAgent}) async {
    if (_headlessWebView != null && _headlessWebView!.isRunning()) {
      // 如果 UA 发生变化，可能需要更新（虽然 Headless 不支持运行时更变 UA，但可以至少打印警告）
      return;
    }

    print('🛡️ [Legacy-Service] Initializing Tiny Legacy Engine...');

    _headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri('https://www.listaspam.com')),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        domStorageEnabled: true,
        databaseEnabled: true,
        useHybridComposition: true,
        useShouldInterceptRequest: true,
        userAgent: userAgent,
      ),
      onWebViewCreated: (controller) async {
        print('🛡️ [Legacy-Service] WebView Created.');

        // 1. 设置 TestPageChannel (日志记录)
        controller.addJavaScriptHandler(
          handlerName: 'TestPageChannel',
          callback: (args) {
            if (args.isNotEmpty) {
              print('🛡️ [JS-Bridge-Log] ${args[0]}');
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
        print(
          '🛡️ [Legacy-Service] Bridge Template injected into: ' +
              (await controller.getUrl()).toString(),
        );
      },
      onReceivedError: (controller, request, error) {
        print('❌ [WebView-Error] ${error.description} (URL: ${request.url})');
      },
      onReceivedHttpError: (controller, request, errorResponse) {
        print(
          '❌ [HTTP-Error] ${errorResponse.statusCode} (URL: ${request.url})',
        );
      },
      shouldInterceptRequest: (controller, request) async {
        return await _interceptor?.handleRequest(controller, request);
      },
      onConsoleMessage: (controller, consoleMessage) {
        print(
          '🛡️ [JS-Console] ${consoleMessage.messageLevel}: ${consoleMessage.message}',
        );
      },
    );

    await _headlessWebView?.run();
    print('🛡️ [Legacy-Service] Engine is running.');
  }

  /// 执行绕过任务
  Future<Map<String, dynamic>?> executeBypass(
    String targetUrl, {
    String? userAgent,
    String? requestId,
    String? successMarker,
  }) async {
    // ⭐ 核心修复：强制重启引擎，确保所有改动的 JS 脚本都能重新注入。
    // 否则 Hot Restart 之后，Singleton 里的 WebView 还在运行旧脚本。
    if (_headlessWebView != null) {
      print(
        '🛡️ [Legacy-Service] Webview exists, disposing for fresh start...',
      );
      await _headlessWebView?.dispose();
      _headlessWebView = null;
    }

    _interceptor = CloudflareLegacyInterceptor(); // ⭐ 强制使用全新拦截器实例
    await _ensureInitialized(userAgent: userAgent);
    _interceptor?.setUserAgent(userAgent);

    final id = requestId ?? 'bypass_${DateTime.now().millisecondsSinceEpoch}';
    _activeRequestId = id; // ⭐ 设置为当前活跃 ID

    // 如果已有未完成的任务，先取消它
    if (_currentBypassCompleter != null &&
        !_currentBypassCompleter!.isCompleted) {
      print(
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

    print('🛡️ [Legacy-Service] Executing: $targetUrl (ID: $id)');

    // 调用 Bridge 开启 Iframe 代理
    await _headlessWebView?.webViewController?.evaluateJavascript(
      source: 'window.startLegacyBypass("$proxiedUrl", "$id");',
    );

    try {
      return await _currentBypassCompleter!.future.timeout(
        const Duration(seconds: 45),
        onTimeout: () {
          print('🛡️ [Legacy-Service] Timeout for ID: $id');
          if (_activeRequestId == id) _activeRequestId = null;
          _interceptor?.cleanupSession(id);
          return null;
        },
      );
    } catch (e) {
      print('🛡️ [Legacy-Service] Error in $id: $e');
      if (_activeRequestId == id) _activeRequestId = null;
      _interceptor?.cleanupSession(id);
      return null;
    }
  }

  void _onResultReceived(dynamic result) {
    if (_currentBypassCompleter != null &&
        !_currentBypassCompleter!.isCompleted) {
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

        // ⭐ 核心校验：检查 requestId 是否匹配当前活跃请求
        final incomingId = finalResult['requestId'];
        if (incomingId != null &&
            _activeRequestId != null &&
            incomingId != _activeRequestId) {
          print(
            '🛡️ [Legacy-Service] ⏩ Ignoring delayed/zombie result from ID: $incomingId (Current: $_activeRequestId)',
          );
          return; // 忽略不匹配的结果
        }

        print(
          '🛡️ [Legacy-Service] Result Received! (Matched ID: $incomingId). Propagating to caller...',
        );

        // 如果内部数据包还包含 data 字段（Bridge 转发），拆出来
        if (finalResult.containsKey('data') && finalResult['data'] is Map) {
          finalResult = Map<String, dynamic>.from(finalResult['data']);
        }

        _activeRequestId = null; // 成功匹配后清理
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
