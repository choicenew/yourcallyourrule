import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';

// Constants from test.dart
const String PROXY_SCHEME = "https";
const String PROXY_HOST = "flutter-webview-proxy.internal";
const String PROXY_PATH_FETCH = "/fetch";

class PluginTestService {
  HeadlessInAppWebView? _headlessWebView;
  final StreamController<String> _logController = StreamController<String>.broadcast();
  Stream<String> get logStream => _logController.stream;

  bool _isPluginJsLoaded = false;
  String? _loadedPluginId;
  final Map<String, Completer<Map<String, dynamic>?>> _requestCompleters = {};

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
        userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
      ),
      onWebViewCreated: (controller) async {
        _addLog('Headless WebView created.');
        await _setupJavaScriptHandlers(controller);
      },
      shouldInterceptRequest: _shouldInterceptRequest,
      onLoadStop: (controller, url) {
        _addLog('Headless WebView loaded: $url');
      },
      onConsoleMessage: (controller, consoleMessage) {
        _addLog('Console [${consoleMessage.messageLevel}]: ${consoleMessage.message}');
      },
    );

    await _headlessWebView?.run();
    _addLog("HeadlessInAppWebView is running.");
  }

  Future<WebResourceResponse?> _shouldInterceptRequest(InAppWebViewController controller, WebResourceRequest request) async {
    final uri = request.url;
    _addLog('Intercepted request: ${uri.toString()} | isForMainFrame: ${request.isForMainFrame}');

    if (uri.scheme == PROXY_SCHEME && uri.host == PROXY_HOST && uri.path.startsWith(PROXY_PATH_FETCH)) {
      _addLog('Proxy request matched for URL: ${uri.toString()}');
      final targetUrlParam = uri.queryParameters['targetUrl'];
      final headersParam = uri.queryParameters['headers'];

      if (targetUrlParam == null || targetUrlParam.isEmpty) {
        _addLog('Proxy Error: Missing targetUrl parameter.');
        return WebResourceResponse(
          contentType: 'text/plain',
          data: Uint8List.fromList('Proxy Error: Missing targetUrl parameter'.codeUnits),
          statusCode: 400,
        );
      }

      try {
        final targetUrl = Uri.parse(targetUrlParam);
        _addLog('Proxying to target: $targetUrl');

        Map<String, String> requestHeaders = {};
        if (headersParam != null && headersParam.isNotEmpty) {
          try {
            final decodedHeaders = jsonDecode(Uri.decodeComponent(headersParam)) as Map<String, dynamic>;
            decodedHeaders.forEach((key, value) => requestHeaders[key] = value.toString());
            _addLog('Using custom headers from plugin: $requestHeaders');
          } catch (e) {
            _addLog('Error decoding headers: $e');
          }
        }

        final cookieManager = CookieManager.instance();
        final cookies = await cookieManager.getCookies(url: WebUri.uri(targetUrl));
        if (cookies.isNotEmpty) {
             requestHeaders['Cookie'] = cookies.map((c) => '${c.name}=${c.value}').join('; ');
        }

        _addLog('Making backend HTTP GET to: $targetUrl with headers: $requestHeaders');
        final response = await http.get(targetUrl, headers: requestHeaders);
        _addLog('Backend response received: ${response.statusCode} for $targetUrl');

        String htmlBody = utf8.decode(response.bodyBytes, allowMalformed: true);
        String injectionScript = '''
          <script type="text/javascript">
            (function() {
              console.log('[Injected-Receiver] Hello from the script injected by Flutter!');
              function handleMessage(event) {
                if (event.data && event.data.type === 'executeScript') {
                    console.log('[Injected-Receiver] Received a script to execute from parent window.');
                    try {
                      eval(event.data.script);
                      console.log('[Injected-Receiver] Script execution started.');
                    } catch (e) {
                      console.error('[Injected-Receiver] Error executing script via eval:', e);
                      window.parent.postMessage({ type: 'phoneQueryResult', data: { success: false, error: 'Eval execution failed: ' + e.toString() } }, '*');
                    }
                }
              }
              window.removeEventListener('message', handleMessage);
              window.addEventListener('message', handleMessage, false);
              console.log('[Injected-Receiver] Message listener is now active and waiting for commands.');
            })();
          </script>
        ''';

        if (htmlBody.contains('<head>')) {
          htmlBody = htmlBody.replaceFirst('<head>', '<head>$injectionScript');
        } else if (htmlBody.contains('<html>')) {
          htmlBody = htmlBody.replaceFirst('<html>', '<html><head>$injectionScript</head>');
        } else {
          htmlBody = injectionScript + htmlBody;
        }
         // --- [删除] 以下是您原始代码中处理响应头的部分 ---
/*
        final Map<String, String> responseHeaders = {};
        bool cspRemoved = false;
        response.headers.forEach((key, value) {
          if (key.toLowerCase() != 'content-security-policy') {
            responseHeaders[key] = value;
          } else {
            cspRemoved = true;
          }
        });
        if (cspRemoved) {
          _addLog('Found and REMOVED Content-Security-Policy header.');
        }
*/
      // --- [修改] 以下部分替换了您原有的头部处理逻辑 ---
      
      // 准备要返回给 WebView 的响应头。
      // 我们需要从原始响应中移除一些可能导致 iframe 加载失败的安全性相关的头信息。
      final Map<String, String> responseHeaders = {};

      // 定义一个“黑名单”，包含所有需要被移除的头信息（统一使用小写以便比较）。
      final headersToRemove = [
        'x-frame-options',              // 核心问题：禁止 iframe 嵌入
        'content-security-policy',      // 可能阻止我们注入的脚本或页面内的资源加载
        'permissions-policy',           // 可能限制 iframe 内的功能
        'feature-policy',               // permissions-policy 的旧版名称
        'cross-origin-embedder-policy', // 启用跨域隔离，会破坏代理内容
        'cross-origin-opener-policy',   // 同上
      ];

      // 遍历从 cleverdialer.com 收到的每一个响应头
      response.headers.forEach((key, value) {
        final lowerCaseKey = key.toLowerCase();
        
        // 检查当前头是否在我们的“黑名单”中
        if (!headersToRemove.contains(lowerCaseKey)) {
          // 如果不在黑名单里，就把它加入到最终要返回的响应头中
          responseHeaders[key] = value;
        } else {
          // 如果在黑名单里，就记录日志并丢弃它，不返回给 WebView
           _addLog('Found and REMOVED problematic header: "$key"');
        }
      });
      // --- [修改结束] ---
        return WebResourceResponse(
          contentType: 'text/html',
          contentEncoding: 'utf-8',
          data: Uint8List.fromList(utf8.encode(htmlBody)),
          statusCode: response.statusCode,
          headers: responseHeaders,
        );
      } catch (e) {
        _addLog('Proxy request failed entirely: $e');
        return WebResourceResponse(
          contentType: 'text/plain',
          data: Uint8List.fromList('Proxy request failed: $e'.codeUnits),
          statusCode: 500,
        );
      }
    }
    return null;
  }

  Future<void> _setupJavaScriptHandlers(InAppWebViewController controller) async {
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
        });

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
              if (requestId != null && _requestCompleters.containsKey(requestId)) {
                _requestCompleters[requestId]!.complete(resultData);
                _requestCompleters.remove(requestId);
              }
            } catch (e) {
              _addLog('Error parsing plugin result: $e');
            }
          }
        });
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
        await _headlessWebView!.webViewController!.evaluateJavascript(source: response.body);
        _addLog('JS plugin code injected. Waiting for "pluginLoaded" message from JS...');
      } else {
        _addLog('Failed to load JS plugin code. Status: ${response.statusCode}');
      }
    } catch (e) {
      _addLog('Error loading JS plugin code: $e');
    }
  }

  Future<Map<String, dynamic>?> testPlugin(
    PluginEntry plugin, {
    String? phoneNumber, // 使用可为空的命名参数
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
    while (!_isPluginJsLoaded && attempts < 100) { // Wait for max 10 seconds
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

      // --- 替换/REPLACE ---
      // 移除旧的 switch 逻辑，直接根据传入的参数生成JS变量
      // Remove the old switch logic. Directly generate JS variables from parameters.
      final phoneParam = (phoneNumber != null && phoneNumber.isNotEmpty) ? "'$phoneNumber'" : 'null';
      final nationalParam = (nationalNumber != null && nationalNumber.isNotEmpty) ? "'$nationalNumber'" : 'null';
      final e164Param = (e164Number != null && e164Number.isNotEmpty) ? "'$e164Number'" : 'null';
      // --- END REPLACEMENT ---
      
      await _headlessWebView!.webViewController!.evaluateJavascript(source: '''
        (function(pluginId, requestId) {
          if (window.plugin && window.plugin[pluginId] && window.plugin[pluginId].generateOutput) {
            console.log(`Calling plugin[pluginId].generateOutput with numbers...`);
            // 直接将三个参数传递给 JS 函数
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
      ''');

      final result = await completer.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          _requestCompleters.remove(requestId);
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