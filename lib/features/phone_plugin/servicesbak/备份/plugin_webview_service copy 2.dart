import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:yourcallyourrule/features/common/error/logger.dart';

const String PROXY_SCHEME = "https";
const String PROXY_HOST = "flutter-webview-proxy.internal";
const String PROXY_PATH_FETCH = "/fetch";

class PluginWebViewService {
  static final PluginWebViewService _instance = PluginWebViewService._internal();
  factory PluginWebViewService() => _instance;
  PluginWebViewService._internal();

  HeadlessInAppWebView? _headlessWebView;
  final Completer<void> _initCompleter = Completer<void>();

  InAppWebViewController? _webViewController;

  final Map<String, bool> _pluginReadyStatus = {};

  final StreamController<String> _pluginReadyController =
      StreamController<String>.broadcast();

  final Map<String, Completer<Map<String, dynamic>?>> _pluginQueryCompleters =
      {};

  String? _loadedPluginId;
  bool _isPluginLoaded = false;

  Stream<String> get pluginReadyStream => _pluginReadyController.stream;

  void _addLog(String log) {
    debugPrint(log);
  }

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

  Future<void> _setupJavaScriptHandlers(InAppWebViewController controller) async {
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
              _pluginReadyStatus[jsonData['pluginId']] = true;
              _pluginReadyController.add(jsonData['pluginId']);
            } else if (jsonData['type'] == 'pluginReady') {
              debugPrint('Plugin ready: ${jsonData['pluginId']}');
              _pluginReadyStatus[jsonData['pluginId']] = true;
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

    controller.addJavaScriptHandler(
      handlerName: 'PluginResultChannel',
      callback: (args) {
        if (args.isEmpty) return;
        try {
          final Map<String, dynamic> result = jsonDecode(args[0]);
          final String? requestId = result['requestId'];

          if (requestId == null) return;

          if (_pluginQueryCompleters.containsKey(requestId)) {
            final completer = _pluginQueryCompleters[requestId]!;
            final bool success = result['success'] ?? false;
            final String? error = result['error'];

            if (success) {
              completer.complete(result);
            } else {
              completer.completeError(error ?? 'Unknown error');
            }
            _pluginQueryCompleters.remove(requestId);
          }
        } catch (e) {
          AppLogger.error('Error processing result', e);
        }
      },
    );

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

            final response = await _sendHttpRequest(method, url, headers, body);

            final responseData = {
              'externalRequestId': externalRequestId,
              'phoneRequestId': phoneRequestId,
              'status': response.statusCode,
              'statusText': response.reasonPhrase,
              'responseText': response.body,
              'headers': response.headers,
            };
            final String responseJson = jsonEncode(responseData);

            await controller.evaluateJavascript(source: '''
              window.plugin.$_loadedPluginId.handleResponse($responseJson);
            ''');
          } catch (e) {
            AppLogger.error('Error handling request', e);
          }
        }
      },
    );
  }

  Future<http.Response> _sendHttpRequest(String method, String url,
      Map<String, String> headers, String? body) async {
    switch (method) {
      case 'GET':
        return await http.get(Uri.parse(url), headers: headers);
      case 'POST':
        return await http.post(Uri.parse(url), headers: headers, body: body);
      default:
        throw Exception('Unsupported HTTP method: $method');
    }
  }

  Future<void> loadScript(String pluginId, String script) async {
    await _initCompleter.future;
    if (_webViewController == null) return;

    _pluginReadyStatus[pluginId] = false;
    _isPluginLoaded = false;
    _loadedPluginId = pluginId;

    await _webViewController?.evaluateJavascript(source: script);
  }

  Future<WebResourceResponse?> handleInterceptedRequest(
      WebResourceRequest request) async {
    final uri = request.url;

    if (uri.scheme == PROXY_SCHEME &&
        uri.host == PROXY_HOST &&
        uri.path.startsWith(PROXY_PATH_FETCH)) {
      final targetUrlParam = uri.queryParameters['targetUrl'];
      if (targetUrlParam == null || targetUrlParam.isEmpty) {
        return WebResourceResponse(
          contentType: 'text/plain',
          data: Uint8List.fromList('Missing targetUrl'.codeUnits),
          statusCode: 400,
        );
      }

      try {
        final targetUrl = Uri.parse(targetUrlParam);
        final response = await http.get(targetUrl);
        return WebResourceResponse(
          contentType: 'text/html',
          contentEncoding: 'utf-8',
          data: response.bodyBytes,
          statusCode: response.statusCode,
        );
      } catch (e) {
        return WebResourceResponse(
          contentType: 'text/plain',
          data: Uint8List.fromList('Failed: $e'.codeUnits),
          statusCode: 500,
        );
      }
    }
    return null;
  }

  void dispose() {
    _pluginReadyController.close();
    _headlessWebView?.dispose();
    _headlessWebView = null;
  }
}
