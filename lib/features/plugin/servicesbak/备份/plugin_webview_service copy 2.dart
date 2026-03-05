import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:yourcallyourrule/common/error/logger.dart';

// 特殊的代理前缀，JS插件会用这个前缀构建iframe的src
const String PROXY_SCHEME = "https";
const String PROXY_HOST = "flutter-webview-proxy.internal";
const String PROXY_PATH_FETCH = "/fetch";

/// 插件WebView服务 - 负责WebView核心管理
/// 遵循单一职责原则，只负责WebView的初始化和基本操作
class PluginWebViewService {
  // --- [修改] Singleton Pattern ---
  static final PluginWebViewService _instance = PluginWebViewService._internal();
  factory PluginWebViewService() => _instance;
  PluginWebViewService._internal();
  // --- [修改结束] ---

  // --- [新增] Headless WebView 和初始化管理 ---
  HeadlessInAppWebView? _headlessWebView;
  final Completer<void> _initCompleter = Completer<void>();
  // --- [新增结束] ---

  // WebView控制器
  InAppWebViewController? _webViewController;

  // 跟踪每个插件的就绪状态
  final Map<String, bool> _pluginReadyStatus = {};

  // 用于通知插件就绪状态的StreamController
  final StreamController<String> _pluginReadyController =
      StreamController<String>.broadcast();

  // 存储每个插件查询的Completer
  final Map<String, Completer<Map<String, dynamic>?>> _pluginQueryCompleters =
      {};

  // 当前加载的插件ID
  String? _loadedPluginId;
  bool _isPluginLoaded = false;

  // 获取插件就绪状态流
  Stream<String> get pluginReadyStream => _pluginReadyController.stream;

  void _addLog(String log) {
    debugPrint(log);
  }

  // 构造函数
  // [删除] PluginWebViewService();

  // --- [新增] 初始化Headless WebView ---
  Future<void> initialize() async {
    if (_headlessWebView != null) {
      return _initCompleter.future;
    }
    _addLog('Initializing Headless WebView...');

    _headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri("about:blank")),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        domStorageEnabled: true,
        databaseEnabled: true,
        useShouldInterceptRequest: true,
        userAgent:
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
      ),
      onWebViewCreated: (controller) async {
        _webViewController = controller;
        await _setupJavaScriptHandlers(controller);
        _addLog('Headless WebView created and handlers setup complete');
        if (!_initCompleter.isCompleted) {
          _initCompleter.complete();
        }
      },
      shouldInterceptRequest: (controller, request) async {
        return handleInterceptedRequest(request);
      },
      onConsoleMessage: (controller, consoleMessage) {
        _addLog(
            'JS Console [${consoleMessage.messageLevel}]: ${consoleMessage.message}');
      },
    );

    await _headlessWebView?.run();
    return _initCompleter.future;
  }
  // --- [新增结束] ---


  // [删除] 初始化WebView
  /*
  Future<void> initializeWebView(InAppWebViewController controller) async {
    _webViewController = controller;
    await _setupJavaScriptHandlers(controller);
    _addLog('WebView initialized and handlers setup complete');
  }
  */

  // 设置JavaScript处理程序
  Future<void> _setupJavaScriptHandlers(InAppWebViewController controller) async {
    // 插件通信通道
    controller.addJavaScriptHandler(
      handlerName: 'TestPageChannel',
      callback: (args) {
        if (args.isNotEmpty) {
          debugPrint('TestPageChannel message: ${args[0]}');
          try {
            final jsonData = jsonDecode(args[0]);

            if (jsonData['type'] == 'pluginLoaded') {
              _loadedPluginId = jsonData['pluginId'];
              _isPluginLoaded = true;

              // 标记插件为就绪状态
              _pluginReadyStatus[jsonData['pluginId']] = true;
              // 通过StreamController发送插件就绪通知
              _pluginReadyController.add(jsonData['pluginId']);
            } else if (jsonData['type'] == 'pluginReady') {
              debugPrint('Plugin ready: ${jsonData['pluginId']}');

              // 标记插件为就绪状态
              _pluginReadyStatus[jsonData['pluginId']] = true;
              // 通过StreamController发送插件就绪通知
              _pluginReadyController.add(jsonData['pluginId']);
            } else if (jsonData['type'] == 'pluginError') {
              debugPrint('Plugin error: ${jsonData['error']}');
            }
          } catch (e) {
            
            debugPrint('Received message: ${args[0]}');
          }
        }
      },
    );

    // 插件结果通道
    controller.addJavaScriptHandler(
      handlerName: 'PluginResultChannel',
      callback: (args) {
        debugPrint('[PluginResultChannel] 生数据打印Received message on PluginResultChannel: ${args[0]}');
        if (args.isEmpty) {
          debugPrint('[PluginResultChannel] Error: Received empty arguments.');
          return;
        }

        try {
          final Map<String, dynamic> result = jsonDecode(args[0]);
          final String? requestId = result['requestId'];

          if (requestId == null) {
            debugPrint('[PluginResultChannel] Error: "requestId" is missing in the response.');
            return;
          }
          
          debugPrint('[PluginResultChannel] Processing requestId: $requestId');

          if (_pluginQueryCompleters.containsKey(requestId)) {
            final completer = _pluginQueryCompleters[requestId]!;
            final bool success = result['success'] ?? false;
            final String? error = result['error'];

            if (success) {
              debugPrint('[PluginResultChannel] Completing successfully for requestId: $requestId');
              completer.complete(result);
            } else {
              final errorMessage = error ?? 'Unknown plugin error';
              debugPrint('[PluginResultChannel] Completing with error for requestId: $requestId, Error: $errorMessage');
              completer.completeError(errorMessage);
            }
            _pluginQueryCompleters.remove(requestId); // 移除已完成的Completer
          } else {
            debugPrint('[PluginResultChannel] Error: No completer found for requestId: $requestId');
          }
        } catch (e) {
          AppLogger.error('处理PluginResultChannel消息时发生异常', e);
          debugPrint('[PluginResultChannel] Error processing message: $e');
        }
      },
    );

    // 请求通道，用于接收JS发送的请求信息
    controller.addJavaScriptHandler(
      handlerName: 'RequestChannel',
      callback: (args) async {
        if (args.isNotEmpty) {
          debugPrint('Received request from JS: ${args[0]}');
          try {
            final requestData = jsonDecode(args[0]);
            final String method = requestData['method'];
            final String url = requestData['url'];
            final Map<String, String> headers =
                (requestData['headers'] as Map<String, dynamic>)
                    .cast<String, String>();
            final String? body = requestData['body'];
            final String externalRequestId = requestData['externalRequestId'];
            final String phoneRequestId = requestData['phoneRequestId'];

            // 使用http包发起实际的网络请求
            final response = await _sendHttpRequest(method, url, headers, body);

            // 将响应数据编码为JSON字符串
            final responseData = {
              'externalRequestId': externalRequestId,
              'phoneRequestId': phoneRequestId,
              'status': response.statusCode,
              'statusText': response.reasonPhrase,
              'responseText': response.body,
              'headers': response.headers,
            };
            final String responseJson = jsonEncode(responseData);

            // 将响应数据发送回JS
            await controller.evaluateJavascript(source: '''
              window.plugin.$_loadedPluginId.handleResponse($responseJson);
            ''');
          } catch (e) {
            AppLogger.error('处理JS请求时发生异常', e);
            debugPrint('Error handling request: $e');
          }
        }
      },
    );

    // 控制台日志处理程序
    controller.addJavaScriptHandler(
      handlerName: 'consoleLog',
      callback: (args) {
        if (args.isNotEmpty) {
          debugPrint('JS Console Log: ${args[0]}');
        }
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'consoleWarn',
      callback: (args) {
        if (args.isNotEmpty) {
          debugPrint('JS Console Warn: ${args[0]}');
        }
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'consoleError',
      callback: (args) {
        if (args.isNotEmpty) {
          debugPrint('JS Console Error: ${args[0]}');
        }
      },
    );
  }

  // 发送HTTP请求
  Future<http.Response> _sendHttpRequest(String method, String url,
      Map<String, String> headers, String? body) async {
    debugPrint("打印Sending headers: $headers");
    switch (method) {
      case 'GET':
        return await http.get(Uri.parse(url), headers: headers);
      case 'POST':
        return await http.post(Uri.parse(url), headers: headers, body: body);
      default:
        throw Exception('Unsupported HTTP method: $method');
    }
  }

  // 加载脚本
  Future<void> loadScript(String pluginId, String script) async {
    // --- [修改] 等待初始化完成 ---
    await _initCompleter.future;
    // --- [修改结束] ---
    if (_webViewController == null) {
      throw Exception('WebView控制器未初始化');
    }

    debugPrint('Executing script for plugin: $pluginId');

    // 重置插件就绪状态
    _pluginReadyStatus[pluginId] = false;
    _isPluginLoaded = false;
    _loadedPluginId = pluginId;

    // 执行JS插件代码
    await _webViewController?.evaluateJavascript(source: script);

    debugPrint('Waiting for pluginReady message for plugin: $pluginId');
  }

  // 等待插件就绪
  Future<void> waitForPluginReady(String pluginId) async {
    // --- [修改] 等待初始化完成 ---
    await _initCompleter.future;
    // --- [修改结束] ---
    // 如果插件已经就绪，则直接返回
    if (_pluginReadyStatus[pluginId] == true) {
      return;
    }

    // 创建一个Completer，用于等待插件就绪
    final completer = Completer<void>();

    // 监听_pluginReadyController的流，等待指定pluginId的插件就绪
    StreamSubscription? sub;
    sub = _pluginReadyController.stream.listen((readyPluginId) {
      if (readyPluginId == pluginId) {
        // 如果等待的插件已就绪，则完成Completer
        if (!completer.isCompleted) {
          completer.complete();
        }
        // 取消订阅，因为已经找到并等待的插件已就绪
        sub?.cancel();
      }
    });

    // 设置超时时间，如果在指定时间内插件未就绪，则打印提示信息
    await completer.future.timeout(const Duration(seconds: 5), onTimeout: () {
      debugPrint('Timeout: Plugin $pluginId did not send pluginReady message.');
      // 超时后取消订阅
      sub?.cancel();
    });
  }

  // 调用插件方法
  Future<Map<String, dynamic>?> callPluginMethod(
    String pluginId,
    String methodName,
    Map<String, dynamic> params,
  ) async {
    // --- [修改] 等待初始化完成 ---
    await _initCompleter.future;
    // --- [修改结束] ---
    if (_webViewController == null) {
      throw Exception('WebView控制器未初始化');
    }

    final requestId = '${methodName}_${DateTime.now().millisecondsSinceEpoch}';
    final completer = Completer<Map<String, dynamic>?>();
    _pluginQueryCompleters[requestId] = completer;

    // 构建JavaScript调用
    final paramsJson = jsonEncode(params);
    final jsCode = '''
      (function() {
        if (window.plugin && window.plugin['$pluginId'] && window.plugin['$pluginId']['$methodName']) {
          window.plugin['$pluginId']['$methodName']($paramsJson, '$requestId');
        } else {
          console.error('Plugin method not found: $pluginId.$methodName');
        }
      })();
    ''';

    // 执行JavaScript
    debugPrint('[WebView] Calling plugin method: $pluginId.$methodName');
    await _webViewController?.evaluateJavascript(source: jsCode);

    // 等待结果
    try {
      return await completer.future.timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          _pluginQueryCompleters.remove(requestId);
          debugPrint('[WebView] Timeout for plugin method: $pluginId.$methodName');
          throw TimeoutException(
              'Plugin method call timed out: $pluginId.$methodName');
        },
      );
    } catch (e) {
          AppLogger.error('生成插件输出失败', e);
      _pluginQueryCompleters.remove(requestId);
      rethrow;
    }
  }

  // 生成插件输出
  Future<Map<String, dynamic>?> generatePluginOutput(
    String pluginId,
    String phoneNumber,
    String nationalNumber,
    String e164Number,
  ) async {
    // --- [修改] 等待初始化完成 ---
    await _initCompleter.future;
    // --- [修改结束] ---
    final requestId =
        'query_${pluginId}_${DateTime.now().millisecondsSinceEpoch}';
    final completer = Completer<Map<String, dynamic>?>();
    _pluginQueryCompleters[requestId] = completer;

    debugPrint('[WebView] 输出Generating plugin output for: $pluginId');
    // 执行JavaScript查询代码
    await _webViewController?.evaluateJavascript(source: '''
      (function(pluginId) {
        if (window.plugin && window.plugin[pluginId]) {
          window.plugin[pluginId].generateOutput(
            "$phoneNumber",
            "$nationalNumber",
            "$e164Number",
            "$requestId"
          );
        } else {
          console.error('Plugin not found or not loaded:', pluginId);
        }
      })('$pluginId');
    ''');

    // 等待结果
    try {
      return await completer.future.timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          _pluginQueryCompleters.remove(requestId);
          debugPrint('[WebView] Timeout generating output for plugin: $pluginId');
          throw TimeoutException(
              'Plugin output generation timed out: $pluginId');
        },
      );
    } catch (e) {
      AppLogger.error('生成插件输出失败', e);
      debugPrint('[WebView] Error generating output for plugin: $pluginId - $e');
      _pluginQueryCompleters.remove(requestId);
      rethrow;
    }
  }

  Future<WebResourceResponse?> handleInterceptedRequest(
      WebResourceRequest request) async {
    final uri = request.url;

    _addLog('Intercepted request: ${uri.toString()}');

    if (uri.scheme == PROXY_SCHEME &&
        uri.host == PROXY_HOST &&
        uri.path.startsWith(PROXY_PATH_FETCH)) {
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
            final decodedHeaders =
                jsonDecode(Uri.decodeComponent(headersParam)) as Map<String, dynamic>;
            decodedHeaders
                .forEach((key, value) => requestHeaders[key] = value.toString());
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
          _addLog('Injection successful into <head>.');
        } else if (htmlBody.contains('<html>')) {
          htmlBody =
              htmlBody.replaceFirst('<html>', '<html><head>$injectionScript</head>');
          _addLog('Injection successful by creating a <head> tag.');
        } else {
          htmlBody = injectionScript + htmlBody;
          _addLog('Injection successful by prepending to the document.');
        }
/*
     // --- [删除] 以下是您原始代码中处理响应头的部分 ---    
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

  // 释放资源
  void dispose() {
    _pluginReadyController.close();
    // --- [新增] 停止Headless WebView ---
    _headlessWebView?.dispose();
    _headlessWebView = null;
    // --- [新增结束] ---
  }


// 添加状态监听扩展
void addPluginStateListener(String pluginId, Function(bool) listener) {
  _pluginReadyController.stream.where((id) => id == pluginId).listen((_) {
    listener(_pluginReadyStatus[pluginId] ?? false);
  });
}
}