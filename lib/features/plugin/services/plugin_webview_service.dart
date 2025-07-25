import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

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
    print(log);
  }

  // 构造函数
  PluginWebViewService();

  // 初始化WebView
  Future<void> initializeWebView(InAppWebViewController controller) async {
    _webViewController = controller;
    await _setupJavaScriptHandlers(controller);
    _addLog('WebView initialized and handlers setup complete');
  }

  // 设置JavaScript处理程序
  Future<void> _setupJavaScriptHandlers(InAppWebViewController controller) async {
    // 插件通信通道
    controller.addJavaScriptHandler(
      handlerName: 'TestPageChannel',
      callback: (args) {
        if (args.isNotEmpty) {
          print('TestPageChannel message: ${args[0]}');
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
              print('Plugin ready: ${jsonData['pluginId']}');

              // 标记插件为就绪状态
              _pluginReadyStatus[jsonData['pluginId']] = true;
              // 通过StreamController发送插件就绪通知
              _pluginReadyController.add(jsonData['pluginId']);
            } else if (jsonData['type'] == 'pluginError') {
              print('Plugin error: ${jsonData['error']}');
            }
          } catch (e) {
            
            print('Received message: ${args[0]}');
          }
        }
      },
    );

    // 插件结果通道
    controller.addJavaScriptHandler(
      handlerName: 'PluginResultChannel',
      callback: (args) {
        print('Received message on PluginResultChannel: ${args[0]}');
        if (args.isNotEmpty) {
          try {
            final Map<String, dynamic> decodedMessage = jsonDecode(args[0]);

            // 检查消息类型、pluginId和requestId是否匹配
            if (decodedMessage['type'] == 'pluginResult' &&
                decodedMessage['pluginId'] == _loadedPluginId) {
              final requestId = decodedMessage['requestId'];
              final data = Map<String, dynamic>.from(decodedMessage['data']);

              // 查找并完成对应的Completer
              if (_pluginQueryCompleters.containsKey(requestId)) {
                _pluginQueryCompleters[requestId]!.complete(data);
                _pluginQueryCompleters.remove(requestId); // 移除已完成的Completer
              }
            } else if (decodedMessage['type'] == 'pluginError' &&
                decodedMessage['pluginId'] == _loadedPluginId) {
              final requestId = decodedMessage['requestId'];
              if (_pluginQueryCompleters.containsKey(requestId)) {
                _pluginQueryCompleters[requestId]!.completeError(
                  decodedMessage['error'] ?? 'Unknown error from plugin',
                );
                _pluginQueryCompleters.remove(requestId); // 移除已完成的Completer
              }
            }
          } catch (e) {
            AppLogger.error('处理PluginResultChannel消息时发生异常', e);
            print('Error processing message on PluginResultChannel: $e');
          }
        }
      },
    );

    // 请求通道，用于接收JS发送的请求信息
    controller.addJavaScriptHandler(
      handlerName: 'RequestChannel',
      callback: (args) async {
        if (args.isNotEmpty) {
          print('Received request from JS: ${args[0]}');
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
            print('Error handling request: $e');
          }
        }
      },
    );

    // 控制台日志处理程序
    controller.addJavaScriptHandler(
      handlerName: 'consoleLog',
      callback: (args) {
        if (args.isNotEmpty) {
          print('JS Console Log: ${args[0]}');
        }
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'consoleWarn',
      callback: (args) {
        if (args.isNotEmpty) {
          print('JS Console Warn: ${args[0]}');
        }
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'consoleError',
      callback: (args) {
        if (args.isNotEmpty) {
          print('JS Console Error: ${args[0]}');
        }
      },
    );
  }

  // 发送HTTP请求
  Future<http.Response> _sendHttpRequest(String method, String url,
      Map<String, String> headers, String? body) async {
    print("打印Sending headers: $headers");
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
    if (_webViewController == null) {
      throw Exception('WebView控制器未初始化');
    }

    print('Executing script for plugin: $pluginId');

    // 重置插件就绪状态
    _pluginReadyStatus[pluginId] = false;
    _isPluginLoaded = false;
    _loadedPluginId = pluginId;

    // 执行JS插件代码
    await _webViewController?.evaluateJavascript(source: script);

    print('Waiting for pluginReady message for plugin: $pluginId');
  }

  // 等待插件就绪
  Future<void> waitForPluginReady(String pluginId) async {
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
      print('Timeout: Plugin $pluginId did not send pluginReady message.');
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
    await _webViewController?.evaluateJavascript(source: jsCode);

    // 等待结果
    try {
      return await completer.future.timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          _pluginQueryCompleters.remove(requestId);
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
    final requestId =
        'query_${pluginId}_${DateTime.now().millisecondsSinceEpoch}';
    final completer = Completer<Map<String, dynamic>?>();
    _pluginQueryCompleters[requestId] = completer;

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
        const Duration(seconds: 10),
        onTimeout: () {
          _pluginQueryCompleters.remove(requestId);
          throw TimeoutException(
              'Plugin output generation timed out: $pluginId');
        },
      );
    } catch (e) {
      AppLogger.error('生成插件输出失败', e);
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
  }


// 添加状态监听扩展
void addPluginStateListener(String pluginId, Function(bool) listener) {
  _pluginReadyController.stream.where((id) => id == pluginId).listen((_) {
    listener(_pluginReadyStatus[pluginId] ?? false);
  });
}
}