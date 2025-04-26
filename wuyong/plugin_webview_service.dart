import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class PluginResult {
  final String pluginId;
  final String requestId;
  final Map<String, dynamic> data;

  PluginResult({
    required this.pluginId,
    required this.requestId,
    required this.data,
  });
}

class PluginError {
  final String pluginId;
  final String requestId;
  final String? errorMessage;

  PluginError({
    required this.pluginId,
    required this.requestId,
    this.errorMessage,
  });
}

class PluginWebViewService {
  final Logger _logger = Logger('PluginWebViewService');
  HeadlessInAppWebView? _headlessWebView;
  InAppWebViewController? _webViewController;
  
  // 插件查询完成器映射
  final Map<String, Completer<Map<String, dynamic>?>> _pluginQueryCompleters = {};
  
  // 插件就绪状态控制器
  final StreamController<String> _pluginReadyController = StreamController<String>.broadcast();
  Stream<String> get onPluginReady => _pluginReadyController.stream;
  
  // 插件就绪状态映射
  final Map<String, bool> _pluginReadyStatus = {};

  Future<void> initializeWebView() async {
    _headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri("about:blank")),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        allowUniversalAccessFromFileURLs: true,
        allowFileAccessFromFileURLs: true,
        cacheEnabled: true,
        databaseEnabled: true,
        domStorageEnabled: true,
        supportZoom: false,
        useWideViewPort: false,
      ),
      onWebViewCreated: (controller) {
        _webViewController = controller;
        _setupJavaScriptHandlers(controller);
      },
      onLoadStop: (controller, url) async {
        _logger.info('WebView loaded: $url');
        await _injectBasePluginFramework();
      },
      onConsoleMessage: (controller, consoleMessage) {
        _logger.info('Plugin console: ${consoleMessage.message}');
      },
    );
    await _headlessWebView?.run();
  }

  Future<void> _injectBasePluginFramework() async {
    final baseFramework = '''
      if (!window.plugin) {
        window.plugin = {};
        window.pluginSystem = {
          ready: function(pluginId) {
            window.flutter_inappwebview.callHandler('PluginReadyChannel', pluginId);
          },
          sendResult: function(requestId, result) {
            window.flutter_inappwebview.callHandler('PluginResultChannel', requestId, result);
          },
          request: function(url, method, headers, body) {
            return window.flutter_inappwebview.callHandler('RequestChannel', url, method, headers, body);
          },
          log: function(level, message) {
            window.flutter_inappwebview.callHandler('consoleLog', level, message);
          }
        };
      }
    ''';
    
    await _webViewController?.evaluateJavascript(source: baseFramework);
  }

  void _setupJavaScriptHandlers(InAppWebViewController controller) {
    // 插件就绪通道
    controller.addJavaScriptHandler(
      handlerName: 'PluginReadyChannel',
      callback: (args) {
        final pluginId = args[0].toString();
        _pluginReadyStatus[pluginId] = true;
        _pluginReadyController.add(pluginId);
        _logger.info('Plugin ready: $pluginId');
        return {'status': 'acknowledged'};
      },
    );

    // 插件结果通道
    controller.addJavaScriptHandler(
      handlerName: 'PluginResultChannel',
      callback: (args) {
        final requestId = args[0].toString();
        final result = args[1] as Map<String, dynamic>?;
        
        final completer = _pluginQueryCompleters[requestId];
        if (completer != null && !completer.isCompleted) {
          completer.complete(result);
          _pluginQueryCompleters.remove(requestId);
        }
        
        return {'received': true};
      },
    );

    // 请求通道 - 处理插件的网络请求
    controller.addJavaScriptHandler(
      handlerName: 'RequestChannel',
      callback: (args) async {
        final url = args[0].toString();
        final method = args[1].toString();
        final headers = args[2] as Map<String, dynamic>;
        final body = args.length > 3 ? args[3] : null;
        
        try {
          final response = await _makeHttpRequest(url, method, headers, body);
          return {
            'statusCode': response.statusCode,
            'headers': response.headers,
            'body': base64Encode(response.bodyBytes),
            'isBase64Encoded': true
          };
        } catch (e) {
          _logger.severe('Error making HTTP request: $e');
          return {
            'error': e.toString(),
            'statusCode': 500,
          };
        }
      },
    );

    // 控制台日志处理
    controller.addJavaScriptHandler(
      handlerName: 'consoleLog',
      callback: (args) {
        final level = args[0].toString();
        final message = args[1].toString();
        
        switch (level) {
          case 'error':
            _logger.severe('Plugin: $message');
            break;
          case 'warn':
            _logger.warning('Plugin: $message');
            break;
          case 'info':
            _logger.info('Plugin: $message');
            break;
          default:
            _logger.fine('Plugin: $message');
        }
        
        return null;
      },
    );
  }

  Future<http.Response> _makeHttpRequest(
    String url, 
    String method, 
    Map<String, dynamic> headers,
    dynamic body
  ) async {
    final httpHeaders = Map<String, String>.from(
      headers.map((key, value) => MapEntry(key, value.toString()))
    );
    
    final uri = Uri.parse(url);
    
    switch (method.toUpperCase()) {
      case 'GET':
        return await http.get(uri, headers: httpHeaders);
      case 'POST':
        return await http.post(uri, headers: httpHeaders, body: body);
      case 'PUT':
        return await http.put(uri, headers: httpHeaders, body: body);
      case 'DELETE':
        return await http.delete(uri, headers: httpHeaders);
      case 'PATCH':
        return await http.patch(uri, headers: httpHeaders, body: body);
      case 'HEAD':
        return await http.head(uri, headers: httpHeaders);
      default:
        throw Exception('Unsupported HTTP method: $method');
    }
  }

  Future<void> loadPlugin(String pluginId, String scriptContent) async {
    if (_webViewController == null) {
      throw Exception('WebView controller not initialized');
    }
    
    // 创建插件命名空间
    final pluginNamespace = '''
      if (!window.plugin['$pluginId']) {
        window.plugin['$pluginId'] = {};
      }
    ''';
    
    await _webViewController?.evaluateJavascript(source: pluginNamespace);
    
    // 加载插件脚本
    await _webViewController?.evaluateJavascript(source: scriptContent);
    
    // 等待插件就绪
    if (!(_pluginReadyStatus[pluginId] ?? false)) {
      await onPluginReady.firstWhere((id) => id == pluginId)
          .timeout(const Duration(seconds: 10), 
                  onTimeout: () => throw TimeoutException('Plugin $pluginId failed to initialize'));
    }
  }

  Future<Map<String, dynamic>?> callPlugin(
    String pluginId,
    String phoneNumber,
    String nationalNumber,
    String e164Number,
  ) async {
    if (_webViewController == null) {
      throw Exception('WebView controller not initialized');
    }
    
    if (!(_pluginReadyStatus[pluginId] ?? false)) {
      throw Exception('Plugin $pluginId is not ready');
    }
    
    final requestId = 'query_${pluginId}_${DateTime.now().millisecondsSinceEpoch}';
    final completer = Completer<Map<String, dynamic>?>();
    _pluginQueryCompleters[requestId] = completer;
    
    await _webViewController?.evaluateJavascript(source: '''
      window.plugin['$pluginId'].generateOutput(
        "$phoneNumber",
        "$nationalNumber",
        "$e164Number",
        "$requestId"
      );
    ''');
    
    return completer.future.timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        _pluginQueryCompleters.remove(requestId);
        throw TimeoutException('Plugin query timed out: $pluginId');
      },
    );
  }

  Future<void> unloadPlugin(String pluginId) async {
    if (_webViewController == null) return;
    
    await _webViewController?.evaluateJavascript(source: '''
      if (window.plugin['$pluginId']) {
        if (typeof window.plugin['$pluginId'].cleanup === 'function') {
          window.plugin['$pluginId'].cleanup();
        }
        delete window.plugin['$pluginId'];
      }
    ''');
    
    _pluginReadyStatus.remove(pluginId);
  }

  Future<void> dispose() async {
    await _headlessWebView?.dispose();
    _headlessWebView = null;
    _webViewController = null;
    _pluginReadyController.close();
    _pluginQueryCompleters.clear();
    _pluginReadyStatus.clear();
  }
}