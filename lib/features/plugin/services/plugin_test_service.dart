// lib/features/plugin/services/plugin_test_service.dart (或者你的文件名)

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

// [新] 导入我们拆分出去的拦截器
import 'webview_request_interceptor.dart';

// 常量保持不变
const String PROXY_SCHEME = "https";
const String PROXY_HOST = "flutter-webview-proxy.internal";
const String PROXY_PATH_FETCH = "/fetch";

class PluginTestService {
  HeadlessInAppWebView? _headlessWebView;
  final StreamController<String> _logController =
      StreamController<String>.broadcast();
  Stream<String> get logStream => _logController.stream;

  bool _isPluginJsLoaded = false;
  String? _loadedPluginId;
  final Map<String, Completer<Map<String, dynamic>?>> _requestCompleters = {};

  // [新] 创建一个拦截器实例来处理所有网络请求
  final _requestInterceptor = WebViewRequestInterceptor();

  void _addLog(String log) {
    print(log); // Also print to console for debugging
    _logController.add(log);
  }

  Future<void> initialize() async {
    _addLog("Initializing HeadlessInAppWebView for test service...");
    _headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri('about:blank')),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        domStorageEnabled: true,
        databaseEnabled: true,
        useShouldInterceptRequest: true,
        userAgent:
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36',
      ),
      onWebViewCreated: (controller) async {
        _addLog('Headless WebView created.');
        await _setupJavaScriptHandlers(controller);
      },
      // [关键修改] 将 shouldInterceptRequest 的职责完全委托给拦截器实例
      shouldInterceptRequest: (controller, request) {
        return _requestInterceptor.handleInterceptedRequest(
          controller,
          request,
        );
      },
      onLoadStop: (controller, url) {
        _addLog('Headless WebView loaded: $url');
      },
      onConsoleMessage: (controller, consoleMessage) {
        _addLog(
          'Console [${consoleMessage.messageLevel}]: ${consoleMessage.message}',
        );
      },
    );

    await _headlessWebView?.run();
    _addLog("HeadlessInAppWebView is running.");
  }

  // [已删除] 所有网络拦截相关的方法都已移至 WebViewRequestInterceptor
  // - _shouldInterceptRequest
  // - _handleOriginalProxyRequest
  // - _handleLeakedRequest
  // - _preprocessHtml
  // - _purgeHarmfulContent
  // - _getReceiverScript
  // - getDomainBlockerScript
  // - getUniversalNetworkInterceptorScript

  Future<void> _setupJavaScriptHandlers(
    InAppWebViewController controller,
  ) async {
    controller.addJavaScriptHandler(
      handlerName: 'TestPageChannel',
      callback: (args) {
        if (args.isNotEmpty) {
          final message = args[0] as String;
          _addLog('JS->Flutter (TestPageChannel): $message');
          if (message.contains('pluginLoaded')) {
            try {
              final data = jsonDecode(message);
              if (data['type'] == 'pluginLoaded') {
                _isPluginJsLoaded = true;
                _loadedPluginId = data['pluginId'];
                _addLog('Plugin JS loaded with ID: $_loadedPluginId');
              }
            } catch (e) {
              _addLog('Error parsing pluginLoaded message: $e');
            }
          }
        }
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'PluginResultChannel',
      callback: (args) {
        if (args.isNotEmpty) {
          final result = args[0];
          _addLog('JS->Flutter (PluginResultChannel): $result');
          try {
            Map<String, dynamic> resultData;
            if (result is String) {
              resultData = jsonDecode(result);
            } else {
              resultData = Map<String, dynamic>.from(result);
            }
            final requestId = resultData['requestId'] as String?;

            // ▼▼▼ [修改] 在这里委托会话清理 ▼▼▼
            if (requestId != null) {
              _requestInterceptor.cleanupSession(requestId);
              _addLog('Session cleaned for completed requestId: $requestId.');
            }
            // ▲▲▲ 会话清理逻辑结束 ▲▲▲

            if (requestId != null &&
                _requestCompleters.containsKey(requestId)) {
              _requestCompleters[requestId]!.complete(resultData);
              _requestCompleters.remove(requestId);
            }
          } catch (e) {
            _addLog('Error parsing plugin result: $e');
          }
        }
      },
    );
  }

  Future<void> _loadPluginJs(PluginEntry plugin) async {
    if (_headlessWebView?.webViewController == null) {
      _addLog('Error: WebView controller is null. Cannot load plugin JS.');
      return;
    }
    String pluginUrl = plugin.url;
    if (pluginUrl.isEmpty) {
      _addLog('Error: Plugin JS URL is empty.');
      return;
    }
    _addLog('Attempting to load JS plugin code from: $pluginUrl');
    try {
      final response = await http.get(Uri.parse(pluginUrl));
      if (response.statusCode == 200) {
        await _headlessWebView!.webViewController!.evaluateJavascript(
          source: response.body,
        );
        _addLog(
          'JS plugin code injected. Waiting for "pluginLoaded" message from JS...',
        );
      } else {
        _addLog(
          'Failed to load JS plugin code. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      _addLog('Error loading JS plugin code: $e');
    }
  }

  Future<Map<String, dynamic>?> testPlugin(
    PluginEntry plugin, {
    String? phoneNumber,
    String? nationalNumber,
    String? e164Number,
  }) async {
    if (_headlessWebView == null) {
      await initialize();
    }

    // Reset state for a new test
    _isPluginJsLoaded = false;
    _loadedPluginId = null;

    await _loadPluginJs(plugin);

    // Wait for the plugin to confirm it's loaded
    int attempts = 0;
    while (!_isPluginJsLoaded && attempts < 100) {
      // Wait for max 10 seconds
      await Future.delayed(const Duration(milliseconds: 100));
      attempts++;
    }

    if (!_isPluginJsLoaded || _loadedPluginId == null) {
      _addLog('Plugin JS did not load correctly or timed out.');
      throw Exception('Plugin JS did not load correctly or timed out.');
    }

    _addLog('Starting query with provided numbers...');

    try {
      final requestId = 'req_${DateTime.now().millisecondsSinceEpoch}';
      final completer = Completer<Map<String, dynamic>?>();
      _requestCompleters[requestId] = completer;

      final phoneParam =
          (phoneNumber != null && phoneNumber.isNotEmpty)
              ? "'$phoneNumber'"
              : 'null';
      final nationalParam =
          (nationalNumber != null && nationalNumber.isNotEmpty)
              ? "'$nationalNumber'"
              : 'null';
      final e164Param =
          (e164Number != null && e164Number.isNotEmpty)
              ? "'$e164Number'"
              : 'null';

      await _headlessWebView!.webViewController!.evaluateJavascript(
        source: '''
        (function(pluginId, requestId) {
          if (window.plugin && window.plugin[pluginId] && window.plugin[pluginId].generateOutput) {
            console.log(`Calling plugin[pluginId].generateOutput with numbers...`);
            window.plugin[pluginId].generateOutput($phoneParam, $nationalParam, $e164Param, '$requestId');
          } else {
            console.error('Plugin or generateOutput function not found for pluginId:', pluginId);
            window.flutter_inappwebview.callHandler('PluginResultChannel', JSON.stringify({
              requestId: "$requestId",
              success: false,
              error: "generateOutput function not found"
            }));
          }
        })('$_loadedPluginId', '$requestId');
      ''',
      );

      final result = await completer.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          _requestCompleters.remove(requestId);
          // [修改] 委托会话清理
          _requestInterceptor.cleanupSession(requestId);
          _addLog('Query timeout for requestId: $requestId');
          return {'error': 'Query timeout', 'requestId': requestId};
        },
      );

      _addLog('Query completed for requestId: $requestId');
      return result;
    } catch (e) {
      _addLog('Query error: $e');
      rethrow;
    }
  }

  void dispose() {
    _addLog("Disposing PluginTestService and HeadlessInAppWebView.");
    _headlessWebView?.dispose();
    _logController.close();
  }
}
