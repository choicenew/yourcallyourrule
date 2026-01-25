// ztest/lib/core/cloudflare_legacy_service.dart

import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'cloudflare_scripts.dart';

class CloudflareLegacyService {
  static final CloudflareLegacyService _instance =
      CloudflareLegacyService._internal();
  factory CloudflareLegacyService() => _instance;

  InAppWebViewController? _controller;
  Completer<Map<String, dynamic>?>? _currentBypassCompleter;
  bool _isInitialized = false;

  CloudflareLegacyService._internal();

  /// 获取可视化 WebView Widget
  Widget getWebViewWidget() {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri('about:blank')),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        domStorageEnabled: true,
        databaseEnabled: true,
        useHybridComposition: true,
        // 关键：允许跨域访问
        allowFileAccessFromFileURLs: true,
        allowUniversalAccessFromFileURLs: true,
      ),
      // ⭐ 核心：在文档开始前注入影子劫持脚本
      initialUserScripts: UnmodifiableListView<UserScript>([
        UserScript(
          source: CloudflareScripts.bypassUniversal,
          injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
        ),
      ]),
      onWebViewCreated: (controller) async {
        _controller = controller;
        print('🛡️ [Legacy-Service] WebView Created with Shadow Hijacker');

        // 设置成功回调
        controller.addJavaScriptHandler(
          handlerName: 'BypassSuccess',
          callback: (args) {
            if (args.isNotEmpty) {
              _onBypassSuccess(args[0]);
            }
          },
        );

        // 设置日志回调
        controller.addJavaScriptHandler(
          handlerName: 'TestPageChannel',
          callback: (args) {
            if (args.isNotEmpty) {
              print('🛡️ [JS-Log] ${args[0]}');
            }
          },
        );

        _isInitialized = true;
      },
      onLoadStop: (controller, url) async {
        print('🛡️ [Legacy-Service] Page Loaded: $url');
      },
      onConsoleMessage: (controller, consoleMessage) {
        print(
          '🛡️ [JS-Console] ${consoleMessage.messageLevel}: ${consoleMessage.message}',
        );
      },
    );
  }

  /// 执行绕过任务
  Future<Map<String, dynamic>?> executeBypass(
    String targetUrl, {
    String? userAgent,
    String? successMarker,
  }) async {
    // 等待 WebView 初始化
    int waitCount = 0;
    while (!_isInitialized && waitCount < 20) {
      await Future.delayed(const Duration(milliseconds: 500));
      waitCount++;
    }

    if (!_isInitialized || _controller == null) {
      print('❌ [Legacy-Service] WebView not initialized!');
      return {'success': false, 'error': 'WebView not ready'};
    }

    if (userAgent != null) {
      await _controller?.setSettings(
        settings: InAppWebViewSettings(userAgent: userAgent),
      );
    }

    // 如果已有未完成的任务，先取消它
    if (_currentBypassCompleter != null &&
        !_currentBypassCompleter!.isCompleted) {
      print('⚠️ [Legacy-Service] Cancelling previous bypass task.');
      _currentBypassCompleter!.complete(null);
    }

    _currentBypassCompleter = Completer<Map<String, dynamic>?>();

    // 构建带 successMarker 的 URL
    final marker = successMarker ?? 'number_data_box';
    final finalUrl =
        targetUrl +
        (targetUrl.contains('?') ? '&' : '?') +
        'successMarker=$marker';

    print('🛡️ [Legacy-Service] Direct Loading: $finalUrl');

    // ⭐ 核心：直接导航到目标 URL
    await _controller?.loadUrl(urlRequest: URLRequest(url: WebUri(finalUrl)));

    try {
      return await _currentBypassCompleter!.future.timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          print('🛡️ [Legacy-Service] Timeout');
          return {'success': false, 'error': 'Timeout'};
        },
      );
    } catch (e) {
      print('🛡️ [Legacy-Service] Error: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  void _onBypassSuccess(dynamic result) {
    if (_currentBypassCompleter != null &&
        !_currentBypassCompleter!.isCompleted) {
      try {
        Map<String, dynamic> finalResult;
        if (result is String) {
          finalResult = Map<String, dynamic>.from(jsonDecode(result));
        } else if (result is Map) {
          finalResult = Map<String, dynamic>.from(result);
        } else {
          finalResult = {'data': result};
        }

        print('🛡️ [Legacy-Service] ✅ Bypass Success!');
        _currentBypassCompleter!.complete(finalResult);
      } catch (e) {
        print('🛡️ [Legacy-Service] Result parsing error: $e');
        _currentBypassCompleter!.complete({
          'success': false,
          'error': e.toString(),
        });
      }
    }
  }

  void dispose() {
    _controller = null;
    _isInitialized = false;
  }
}
