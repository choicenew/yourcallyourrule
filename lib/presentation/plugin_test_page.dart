import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;

// 特殊的代理前缀，JS插件会用这个前缀构建iframe的src
const String PROXY_SCHEME = "https";
const String PROXY_HOST = "flutter-webview-proxy.internal";
const String PROXY_PATH_FETCH = "/fetch";

class TestPage extends StatefulWidget {
  const TestPage({super.key, required this.title});

  final String title;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final TextEditingController _pluginUrlController = TextEditingController(
    text:
        'https://raw.githubusercontent.com/haygcao/test/refs/heads/main/newtellows.js', // 您的在线 JS 插件 URL
  );
  final TextEditingController _phoneNumberController = TextEditingController();
  String _queryResult = '';
  String _jsLogs = ''; // 用于显示JS和代理日志
  InAppWebViewController? _webViewController;
  bool _isPluginJsLoaded = false;
  String? _loadedPluginId;
  final Map<String, Completer<Map<String, dynamic>?>> _requestCompleters = {};

  @override
  void initState() {
    super.initState();
  }

  void _addLog(String log) {
    debugPrint(log); // 打印到控制台
    if (mounted) {
      setState(() {
        _jsLogs =
            "${DateTime.now().toIso8601String().split('T').last} $log\n$_jsLogs";
        if (_jsLogs.length > 5000) {
          // 限制日志长度
          _jsLogs = _jsLogs.substring(0, 5000);
        }
      });
    }
  }

  Future<void> _setupRequestChannel(InAppWebViewController controller) async {
    controller.addJavaScriptHandler(
        handlerName: 'RequestChannel',
        callback: (args) async {
          if (args.isNotEmpty) {
            _addLog('JS->Flutter (RequestChannel): ${args[0]}');
          }
        });
  }

  Future<void> _loadPluginJs() async {
    if (_webViewController == null) {
      _addLog('Error: WebView controller is null. Cannot load plugin JS.');
      return;
    }
    String pluginUrl = _pluginUrlController.text;
    if (pluginUrl.isEmpty) {
      _addLog('Error: Plugin JS URL is empty.');
      return;
    }
    _addLog('Attempting to load JS plugin code from: $pluginUrl');
    try {
      final response = await http.get(Uri.parse(pluginUrl));
      if (response.statusCode == 200) {
        await _webViewController!.evaluateJavascript(source: response.body);
        _addLog(
            'JS plugin code injected. Waiting for "pluginLoaded" message from JS...');
      } else {
        _addLog(
            'Failed to load JS plugin code. Status: ${response.statusCode}');
      }
    } catch (e) {
      _addLog('Error loading JS plugin code: $e');
    }
  }

  Future<WebResourceResponse?> _shouldInterceptRequest(
      InAppWebViewController controller, WebResourceRequest request) async {
    final uri = request.url;

    _addLog(
        'Intercepted request: ${uri.toString()} | isForMainFrame: ${request.isForMainFrame}');

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
          data:
              Uint8List.fromList('Proxy Error: Missing targetUrl parameter'.codeUnits),
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
       

        _addLog(
            'Making backend HTTP GET to: $targetUrl with headers: $requestHeaders');
        final response = await http.get(targetUrl, headers: requestHeaders);
        _addLog('Backend response received: ${response.statusCode} for $targetUrl');

        String htmlBody = utf8.decode(response.bodyBytes, allowMalformed: true);

        String injectionScript = '''
          <script type="text/javascript">
            // IIFE to avoid polluting the global scope
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

        // --- 【最终修正】 ---
        // 错误的参数名 `encoding` 已被修正为正确的 `contentEncoding`
        return WebResourceResponse(
          contentType: 'text/html',
          contentEncoding: 'utf-8',
          data: Uint8List.fromList(utf8.encode(htmlBody)),
          statusCode: response.statusCode,
          headers: responseHeaders,
        );
        // --- 【修正结束】 ---

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
  
  // ... 其他代码完全不变 ...

  Future<void> _setupJavaScriptHandlers(InAppWebViewController controller) async {
    controller.addJavaScriptHandler(
        handlerName: 'TestPageChannel',
        callback: (args) async {
          if (args.isNotEmpty) {
            final message = args[0] as String;
            _addLog('JS->Flutter (TestPageChannel): $message');
            if (message.contains('pluginLoaded')) {
              try {
                final data = jsonDecode(message);
                if (data['type'] == 'pluginLoaded') {
                  setState(() {
                    _isPluginJsLoaded = true;
                    _loadedPluginId = data['pluginId'];
                  });
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
        callback: (args) async {
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
              if (requestId != null &&
                  _requestCompleters.containsKey(requestId)) {
                _requestCompleters[requestId]!.complete(resultData);
                _requestCompleters.remove(requestId);
              }
              if (mounted) {
                setState(() {
                  _queryResult = jsonEncode(resultData);
                });
              }
            } catch (e) {
              _addLog('Error parsing plugin result: $e');
              if (mounted) {
                setState(() {
                  _queryResult = 'Error parsing result: $e';
                });
              }
            }
          }
        });
  }

  Future<void> _loadPlugin() async {
    await _loadPluginJs();
  }

  @override
  void dispose() {
    _webViewController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black87),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFEDE8DF),
                  width: 1.1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _pluginUrlController,
                    decoration: InputDecoration(
                      hintText: 'Enter plugin JS URL',
                      labelText: 'Plugin JS URL',
                      labelStyle: TextStyle(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w600),
                      prefixIcon: const Icon(Icons.extension_rounded, color: Color(0xFF6C5CE7), size: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFEDE8DF), width: 1.1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFF6C5CE7), width: 1.5),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF7F5F0),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _loadPlugin,
                      icon: Icon(_isPluginJsLoaded ? Icons.check_circle_rounded : Icons.download_rounded, size: 18),
                      label: Text(_isPluginJsLoaded ? 'Plugin Loaded ✓' : 'Load Plugin JS', style: const TextStyle(fontWeight: FontWeight.w800)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isPluginJsLoaded ? const Color(0xFF34C759) : const Color(0xFF6C5CE7),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      hintText: 'Enter phone number',
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w600),
                      prefixIcon: const Icon(Icons.phone_rounded, color: Color(0xFFFF9500), size: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFEDE8DF), width: 1.1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFFF9500), width: 1.5),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF7F5F0),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isPluginJsLoaded ? _queryPhoneNumber : null,
                      icon: const Icon(Icons.search_rounded, size: 18),
                      label: const Text('Query Phone Info', style: TextStyle(fontWeight: FontWeight.w800)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9500),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFEDE8DF), width: 1.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Query Result:', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5)),
                  const SizedBox(height: 4),
                  Text(
                    _queryResult.isEmpty ? 'No result yet' : _queryResult,
                    style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFEDE8DF), width: 1.1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Logs:', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5)),
                    const SizedBox(height: 6),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          _jsLogs.isEmpty ? 'No logs yet' : _jsLogs,
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'monospace',
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 1, // 最小高度
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri('about:blank')),
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
                  _addLog('InAppWebView created and ready');
                },
                shouldInterceptRequest: (controller, request) =>
                    _shouldInterceptRequest(controller, request),
                onLoadStop: (controller, url) {
                  _addLog('WebView loaded: $url');
                },
                onConsoleMessage: (controller, consoleMessage) {
                  _addLog(
                      'Console [${consoleMessage.messageLevel}]: ${consoleMessage.message}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _queryPhoneNumber() async {
    if (!_isPluginJsLoaded || _loadedPluginId == null) {
      setState(() {
        _queryResult = 'Plugin JS not loaded. Please load the plugin first.';
      });
      return;
    }
    final phoneNumber = _phoneNumberController.text;
    if (phoneNumber.isEmpty) {
      setState(() {
        _queryResult = 'Please enter a phone number.';
      });
      return;
    }

    setState(() {
      _queryResult = 'Querying...';
    });
    _addLog('Starting query for phone number: $phoneNumber');

    try {
      final requestId = 'req_${const Uuid().v4()}';
      final completer = Completer<Map<String, dynamic>?>();
      _requestCompleters[requestId] = completer;

      await _webViewController!.evaluateJavascript(source: '''
        (function(pluginId, requestId) {
          if (window.plugin && window.plugin[pluginId] && window.plugin[pluginId].generateOutput) {
            console.log(`Calling plugin[pluginId].generateOutput with phone: $phoneNumber, requestId: ${requestId}`);
            window.plugin[pluginId].generateOutput('$phoneNumber', null, null, '$requestId');
          } else {
            console.error('Plugin or generateOutput function not found for pluginId:', pluginId);
            window.flutter_inappwebview.callHandler('PluginResultChannel', JSON.stringify({
              requestId: "$requestId",
              success: false,
              error: "initiateQuery function not found"
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

      if (mounted) {
        setState(() {
          _queryResult = jsonEncode(result);
        });
      }
      _addLog('Query completed for requestId: $requestId');
    } catch (e) {
      _addLog('Query error: $e');
      if (mounted) {
        setState(() {
          _queryResult = 'Error: $e';
        });
      }
    }
  }
}
