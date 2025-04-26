import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

class PluginWebViewService {
  final Logger _logger = Logger('PluginWebViewService');
  HeadlessInAppWebView? _headlessWebView;
  InAppWebViewController? _webViewController;
    // Add uuid instance
  final Uuid _uuid = Uuid();
  String? _loadedPluginId;
  // 完整保留原始的事件处理机制
  final Map<String, Completer<Map<String, dynamic>?>> _pluginQueryCompleters = {};
  final StreamController<String> _pluginReadyController = StreamController<String>.broadcast();
  final Map<String, bool> _pluginReadyStatus = {};

  // 补充完整的WebView配置
  Future<void> initializeWebView() async {
    _headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri("about:blank")),
      initialSettings: InAppWebViewSettings(
        isInspectable: true,
        javaScriptEnabled: true,
        javaScriptCanOpenWindowsAutomatically: true,
        allowUniversalAccessFromFileURLs: true,
        allowFileAccessFromFileURLs: true,
      ),
      onWebViewCreated: (controller) {
        _webViewController = controller;
        _setupJavaScriptHandlers(controller);
      },
      onConsoleMessage: (controller, consoleMessage) {
        _logger.info('WebView Console: ${consoleMessage.message}');
      },
    );
    await _headlessWebView?.run();
  }

  // 完整实现JavaScript处理器
  void _setupJavaScriptHandlers(InAppWebViewController controller) {
    controller.addJavaScriptHandler(
      handlerName: 'TestPageChannel',
      callback: (args) {
        if (args.isNotEmpty) {
          try {
            final jsonData = jsonDecode(args[0]);
            _logger.info('Received TestPageChannel message: $jsonData');
            
            if (jsonData['type'] == 'pluginLoaded') {
              final pluginId = jsonData['pluginId'];
              _pluginReadyStatus[pluginId] = true;
              _pluginReadyController.add(pluginId);
            } else if (jsonData['type'] == 'pluginReady') {
              final pluginId = jsonData['pluginId'];
              _logger.info('Plugin ready: $pluginId');
              _pluginReadyStatus[pluginId] = true;
              _pluginReadyController.add(pluginId);
            } else if (jsonData['type'] == 'pluginError') {
              final pluginId = jsonData['pluginId'];
              final error = jsonData['error'];
              _logger.severe('Plugin error ($pluginId): $error');
              _pluginReadyController.addError(error);
            }
          } catch (e) {
            _logger.severe('Error processing TestPageChannel message: $e');
          }
        }
      }
    );
  
    controller.addJavaScriptHandler(
      handlerName: 'PluginResultChannel',
      callback: (args) {
        if (args.isNotEmpty) {
          try {
            final decoded = jsonDecode(args[0]);
            final requestId = decoded['requestId'];
            final pluginId = decoded['pluginId'];
            
            if (pluginId != _loadedPluginId) {
              _logger.warning('Received message for unloaded plugin: $pluginId');
              return;
            }
            
            if (_pluginQueryCompleters.containsKey(requestId)) {
              if (decoded['type'] == 'pluginResult') {
                final data = Map<String, dynamic>.from(decoded['data']);
                _pluginQueryCompleters[requestId]!.complete(data);
              } else if (decoded['type'] == 'pluginError') {
                final errorMessage = decoded['error'] ?? 'Unknown plugin error';
                _pluginQueryCompleters[requestId]!.completeError(
                  PlatformException(
                    code: 'PLUGIN_ERROR',
                    message: errorMessage,
                    details: {'pluginId': pluginId, 'requestId': requestId},
                  )
                );
              }
              _pluginQueryCompleters.remove(requestId);
            }
          } catch (e, stack) {
            _logger.severe('Error processing PluginResultChannel', e, stack);
          }
        }
      }
    );
  
    // 完整HTTP请求处理逻辑
    controller.addJavaScriptHandler(
      handlerName: 'RequestChannel',
      callback: (args) async {
        if (args.isNotEmpty) {
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
            
            final response = await http.Request(
              method,
              Uri.parse(url)
            )..headers.addAll(headers);
            
            if (body != null) {
              response.body = body;
            }

            final responseStream = await response.send();
            final responseBody = await responseStream.stream.bytesToString();

            final responseData = {
              'externalRequestId': externalRequestId,
              'phoneRequestId': phoneRequestId,
              'status': responseStream.statusCode,
              'statusText': responseStream.reasonPhrase,
              'responseText': responseBody,
              'headers': responseStream.headers,
            };

            await controller.evaluateJavascript(source: '''
              window.plugin.$_loadedPluginId.handleResponse(${jsonEncode(responseData)});
            ''');
          } catch (e, stack) {
            _logger.severe('HTTP Request failed', e, stack);
            await controller.evaluateJavascript(source: '''
              window.plugin.$_loadedPluginId.handleError({
                error: 'HTTP Request Failed: ${e.toString()}'
              });
            ''');
          }
        }
      }
    );
  }

  // 完整插件加载逻辑
  Future<void> loadPlugin(String pluginId, String scriptContent) async {
    final scriptTag = '''
      <script id="$pluginId">
        $scriptContent
      </script>
    ''';
    
    await _webViewController?.evaluateJavascript(source: '''
      document.body.insertAdjacentHTML('beforeend', ${jsonEncode(scriptTag)});
    ''');
    
    _pluginReadyStatus[pluginId] = false;
  }

  // 完整插件调用逻辑
  Future<Map<String, dynamic>?> callPlugin(
    String pluginId,
    String phoneNumber,
    String nationalNumber,
    String e164Number
  ) async {
    final requestId = _uuid.v4(); // Updated to use class field
    final completer = Completer<Map<String, dynamic>?>();
    _pluginQueryCompleters[requestId] = completer;
  
    await _webViewController?.evaluateJavascript(source: '''
      window.plugin.$pluginId.handleCall({
        phoneNumber: "$phoneNumber",
        nationalNumber: "$nationalNumber",
        e164Number: "$e164Number",
        requestId: "$requestId"
      });
    ''');
  
    return completer.future;
  }

  Future<void> dispose() async {
    await _headlessWebView?.dispose();
    _webViewController = null;
    _pluginQueryCompleters.forEach((key, completer) => completer.completeError('WebView disposed'));
    _pluginQueryCompleters.clear();
    _pluginReadyStatus.clear();
    await _pluginReadyController.close();
  }
}