import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart'; // ⭐ 必须导入这个
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

  Widget getWebViewWidget() {
    return InAppWebView(
      // ⭐ 修复：加上这个，底部窗口也能滑动了
      gestureRecognizers: {
        Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
      },
      initialUrlRequest: URLRequest(url: WebUri('about:blank')),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        domStorageEnabled: true,
        databaseEnabled: true,
        useHybridComposition: true,
        mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
        allowFileAccessFromFileURLs: true,
        allowUniversalAccessFromFileURLs: true,
      ),
      initialUserScripts: UnmodifiableListView<UserScript>([
        UserScript(
          source: CloudflareScripts.bypassUniversal,
          injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
          forMainFrameOnly: false,
        ),
      ]),
      onWebViewCreated: (controller) async {
        _controller = controller;
        print('🛡️ [Legacy-Service] WebView Created');

        controller.addJavaScriptHandler(
          handlerName: 'BypassSuccess',
          callback: (args) {
            if (args.isNotEmpty) _onBypassSuccess(args[0]);
          },
        );

        controller.addJavaScriptHandler(
          handlerName: 'TestPageChannel',
          callback: (args) {
            if (args.isNotEmpty) print('🛡️ [JS-Log] ${args[0]}');
          },
        );

        _isInitialized = true;
      },
      onLoadStop: (controller, url) async {
        print('🛡️ [Legacy-Service] Page Loaded: $url');
      },
    );
  }

  Future<void> enableManualMode() async {
    await _controller?.evaluateJavascript(
      source: "window._cf_manual_mode = true;",
    );
  }

  Future<void> disableManualMode() async {
    // 强制把手动模式关掉，并重置点击锁
    await _controller?.evaluateJavascript(
      source:
          "window._cf_manual_mode = false; window._hasClickedGlobal = false;",
    );
  }

  Future<Map<String, dynamic>?> executeBypass(
    String targetUrl, {
    String? userAgent,
    String? successMarker,
  }) async {
    int waitCount = 0;
    while (!_isInitialized && waitCount < 20) {
      await Future.delayed(const Duration(milliseconds: 500));
      waitCount++;
    }

    if (!_isInitialized || _controller == null) {
      return {'success': false, 'error': 'WebView not ready'};
    }

    if (userAgent != null) {
      await _controller?.setSettings(
        settings: InAppWebViewSettings(userAgent: userAgent),
      );
    }

    if (_currentBypassCompleter != null &&
        !_currentBypassCompleter!.isCompleted) {
      _currentBypassCompleter!.complete(null);
    }
    _currentBypassCompleter = Completer<Map<String, dynamic>?>();

    final marker = successMarker ?? 'number_data_box';
    // 简单判断一下如果是 about:blank 就不拼接参数
    String finalUrl = targetUrl;
    if (!targetUrl.startsWith("about:")) {
      finalUrl =
          targetUrl +
          (targetUrl.contains('?') ? '&' : '?') +
          'successMarker=$marker';
    }

    print('🛡️ [Legacy-Service] Navigating to: $finalUrl');
    await _controller?.loadUrl(urlRequest: URLRequest(url: WebUri(finalUrl)));

    try {
      return await _currentBypassCompleter!.future.timeout(
        const Duration(seconds: 60),
        onTimeout: () => {'success': false, 'error': 'Timeout'},
      );
    } catch (e) {
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
