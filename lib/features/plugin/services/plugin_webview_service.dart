// lib/features/plugin/services/plugin_webview_service.dart

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:yourcallyourrule/common/error/logger.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import 'package:yourcallyourrule/features/plugin/services/webview_request_interceptor.dart';

// 引入我们刚刚创建的拦截器

/// 插件WebView服务 - 负责WebView核心管理
/// 遵循单一职责原则，只负责WebView的初始化和基本操作
class PluginWebViewService {
  // --- [修改] Singleton Pattern ---
  static final PluginWebViewService _instance =
      PluginWebViewService._internal();
  factory PluginWebViewService() => _instance;
  PluginWebViewService._internal();

  // --- [修改结束] ---

  // --- [新增] Headless WebView 和初始化管理 ---
  HeadlessInAppWebView? _headlessWebView;
  final Completer<void> _initCompleter = Completer<void>();
  // --- [新增结束] ---

  // WebView控制器
  InAppWebViewController? _webViewController;

  // --- [新] 创建一个内部拦截器实例，将职责委托给它 ---
  final _requestInterceptor = WebViewRequestInterceptor();

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
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36',
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
        // [修改] 拦截逻辑现在被完全委托给内部处理器！
        return _requestInterceptor.handleInterceptedRequest(
          controller,
          request,
        );
      },
      onConsoleMessage: (controller, consoleMessage) {
        _addLog(
          'JS Console [${consoleMessage.messageLevel}]: ${consoleMessage.message}',
        );
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
  Future<void> _setupJavaScriptHandlers(
    InAppWebViewController controller,
  ) async {
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
            } else if (jsonData['type'] == 'sessionCompleted') {
              final requestId = jsonData['requestId'];
              if (requestId != null) {
                _addLog(
                  'Session completed for requestId [$requestId], cleaning up.',
                );
                // [修改] 委托会话清理
                _requestInterceptor.cleanupSession(requestId);
              }
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
        debugPrint(
          '[PluginResultChannel] 生数据打印Received message on PluginResultChannel: ${args[0]}',
        );
        if (args.isEmpty) {
          debugPrint('[PluginResultChannel] Error: Received empty arguments.');
          return;
        }

        try {
          final Map<String, dynamic> result = jsonDecode(args[0]);
          final String? requestId = result['requestId'];

          if (requestId == null) {
            debugPrint(
              '[PluginResultChannel] Error: "requestId" is missing in the response.',
            );
            return;
          }

          debugPrint('[PluginResultChannel] Processing requestId: $requestId');

          if (_pluginQueryCompleters.containsKey(requestId)) {
            final completer = _pluginQueryCompleters.remove(requestId)!;
            final bool success = result['success'] ?? false;
            final String? error = result['error']?.toString();

            if (success) {
              debugPrint(
                '[PluginResultChannel] Completing successfully for requestId: $requestId',
              );
              completer.complete(result);
            } else {
              // 如果 success 是 false，但 error 字段是 null 或者空字符串，
              // 我们就认为这是 "没有找到结果" 的正常情况，而不是一个真正的错误。
              if (error == null || error.isEmpty) {
                debugPrint(
                  '[PluginResultChannel] Completing with NO RESULT (success:false, no error msg) for requestId: $requestId',
                );
                completer.complete(null); // 正常返回 null
              } else {
                // 只有当 success 是 false 并且 error 字段里有具体错误信息时，
                // 才把它当作一个真正的异常来处理。
                final errorMessage = error ?? 'Unknown plugin error';
                debugPrint(
                  '[PluginResultChannel] Completing with error for requestId: $requestId, Error: $errorMessage',
                );
                completer.completeError(errorMessage);
              }
            }
            // [修改] 委托会话清理
            _requestInterceptor.cleanupSession(requestId);
          } else {
            debugPrint(
              '[PluginResultChannel] Error: No completer found for requestId: $requestId',
            );
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
        if (args.isEmpty) return;
        debugPrint('Received request from JS: ${args[0]}');
        try {
          final requestData = jsonDecode(args[0]);
          final String method = requestData['method'];
          final String url = requestData['url'];

          // 安全转换 Headers，并移除 gzip 压缩头，让 Dart 自动处理
          final Map<String, String> headers = {};
          if (requestData['headers'] != null) {
            (requestData['headers'] as Map<String, dynamic>).forEach((k, v) {
              if (k.toLowerCase() != 'accept-encoding') {
                // 关键修改：移除导致乱码的头
                headers[k] = v.toString();
              }
            });
          }
          final String? body = requestData['body'];
          final String? phoneRequestId = requestData['phoneRequestId'];
          final String? externalRequestId = requestData['externalRequestId'];

          // 关键修改：增加 10秒超时，防止网络不通时卡死
          final response = await _sendHttpRequest(
            method,
            url,
            headers,
            body,
          ).timeout(const Duration(seconds: 10));

          final responseData = {
            'externalRequestId': externalRequestId,
            'phoneRequestId': phoneRequestId,
            'status': response.statusCode,
            'statusText': response.reasonPhrase,
            'responseText': response.body,
            'headers': response.headers,
          };
          final String responseJson = jsonEncode(responseData);

          // 关键修改：确保回调能找到插件 ID
          // 注意：在 main service 中 _loadedPluginId 可能为空，如果它是通过 callPluginMethod 调用的
          // 但这里我们假设是插件主动发起的请求，所以它应该知道自己的 ID
          // 或者我们在 JS 端就处理好回调分配。
          // 方案中的代码使用 _loadedPluginId 或者是 'truecallerPluginchannel'，
          // 这里我们尽量从 requestData 中获取 pluginId 如果有的话，或者使用 _loadedPluginId

          // 为了稳健，我们直接调用 window.plugin[ID].handleResponse
          // JS 侧目前是写死的，我们这里需要动态一点，或者 JS 传过来 pluginId
          // 方案中代码：window.plugin["$targetPluginId"].handleResponse
          // 我们这里沿用 _loadedPluginId，因为它是在 loadScript 时设置的。

          if (_loadedPluginId != null) {
            await controller.evaluateJavascript(
              source:
                  'window.plugin["$_loadedPluginId"].handleResponse($responseJson);',
            );
          } else {
            // Fallback: 尝试广播或者记录错误?
            // 方案建议：final targetPluginId = _loadedPluginId ?? 'truecallerPluginchannel';
            // 既然用户方案里写了 'truecallerPluginchannel' 作为 fallback，我们先保留这个逻辑
            final targetPluginId = _loadedPluginId ?? 'truecallerPluginchannel';
            await controller.evaluateJavascript(
              source:
                  'window.plugin["$targetPluginId"].handleResponse($responseJson);',
            );
          }
        } catch (e) {
          AppLogger.error('RequestChannel Error', e);
          debugPrint('RequestChannel Error: $e');
          // 关键修改：发生错误(如超时)也要通知 JS，防止 JS 永久等待
          try {
            final requestData = jsonDecode(args[0]);
            final targetPluginId = _loadedPluginId ?? 'truecallerPluginchannel';
            final errorData = {
              'phoneRequestId': requestData['phoneRequestId'],
              'status': 0, // 0 表示网络错误
              'error': e.toString(),
            };
            await controller.evaluateJavascript(
              source:
                  'window.plugin["$targetPluginId"].handleResponse(${jsonEncode(errorData)});',
            );
          } catch (innerE) {
            debugPrint('Error sending error response to JS: $innerE');
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
  Future<http.Response> _sendHttpRequest(
    String method,
    String url,
    Map<String, String> headers,
    String? body,
  ) async {
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
    await completer.future.timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        debugPrint(
          'Timeout: Plugin $pluginId did not send pluginReady message.',
        );
        // 超时后取消订阅
        sub?.cancel();
      },
    );
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
    debugPrint(
      '[WebView] Calling plugin method: $pluginId.$methodName for requestId: $requestId',
    );
    await _webViewController?.evaluateJavascript(source: jsCode);

    // 等待结果
    try {
      return await completer.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          _pluginQueryCompleters.remove(requestId);
          // [修改] 委托会话清理
          _requestInterceptor.cleanupSession(requestId); // Cleanup
          debugPrint(
            '[WebView] Timeout for plugin method: $pluginId.$methodName, requestId: $requestId',
          );
          throw TimeoutException(
            'Plugin method call timed out: $pluginId.$methodName',
          );
        },
      );
    } catch (e) {
      _pluginQueryCompleters.remove(requestId);
      // [修改] 委托会话清理
      _requestInterceptor.cleanupSession(requestId); // Cleanup
      AppLogger.error('生成插件输出失败', e);
      rethrow;
    }
  }

  // 生成插件输出
  Future<Map<String, dynamic>?> generatePluginOutput(
    String pluginId,
    String phoneNumber,
    String nationalNumber,
    String e164Number, {
    Map<String, dynamic>? config,
  }) async {
    // --- [修改] 等待初始化完成 ---
    await _initCompleter.future;
    // --- [修改结束] ---
    final requestId =
        'query_${pluginId}_${DateTime.now().millisecondsSinceEpoch}';
    if (_webViewController == null) {
      throw Exception('WebView控制器未初始化');
    }

    final completer = Completer<Map<String, dynamic>?>();
    _pluginQueryCompleters[requestId] = completer;

    debugPrint(
      '[WebView] Generating plugin output for: $pluginId with requestId: $requestId',
    );

    // 注入配置并在回调中执行 generateOutput
    final configJson = jsonEncode(config ?? {});
    await _webViewController?.evaluateJavascript(
      source: '''
      (function(pluginId) {
        if (window.plugin && window.plugin[pluginId]) {
          // [Inject Config]
          window.plugin[pluginId].config = $configJson;
          
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
    ''',
    );

    // 等待结果
    try {
      return await completer.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          _pluginQueryCompleters.remove(requestId);
          // [修改] 委托会话清理
          _requestInterceptor.cleanupSession(requestId); // 清理会话
          debugPrint(
            '[WebView] Timeout generating output for plugin: $pluginId, requestId: $requestId',
          );
          throw TimeoutException(
            'Plugin output generation timed out: $pluginId',
          );
        },
      );
    } catch (e) {
      AppLogger.error('生成插件输出失败', e);
      debugPrint(
        '[WebView] Error generating output for plugin: $pluginId - $e',
      );
      _pluginQueryCompleters.remove(requestId);
      // [修改] 委托会话清理
      _requestInterceptor.cleanupSession(requestId); // 清理会话
      rethrow;
    }
  }

  // 释放资源
  void dispose() {
    _pluginReadyController.close();
    // --- [新增] 停止Headless WebView ---
    _headlessWebView?.dispose();
    _headlessWebView = null;
    // --- [新增结束] ---
  }

  // 获取插件配置Schema
  Future<List<dynamic>?> getPluginSettings(String pluginId) async {
    // --- [修改] 等待初始化完成 ---
    await _initCompleter.future;
    // --- [修改结束] ---
    if (_webViewController == null) {
      throw Exception('WebView控制器未初始化');
    }

    try {
      final result = await _webViewController?.evaluateJavascript(
        source: '''
        (function(pluginId) {
          if (window.plugin && window.plugin[pluginId] && window.plugin[pluginId].info) {
             return JSON.stringify(window.plugin[pluginId].info.settings || []);
          }
          return "[]";
        })('$pluginId');
      ''',
      );

      if (result != null) {
        return jsonDecode(result);
      }
      return [];
    } catch (e) {
      debugPrint('[WebView] Error getting plugin settings: $e');
      return [];
    }
  }

  // 添加状态监听扩展
  void addPluginStateListener(String pluginId, Function(bool) listener) {
    _pluginReadyController.stream.where((id) => id == pluginId).listen((_) {
      listener(_pluginReadyStatus[pluginId] ?? false);
    });
  }
}
