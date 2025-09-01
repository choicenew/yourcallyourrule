import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:yourcallyourrule/generated/app_localizations.dart';

// 特殊的代理前缀，JS插件会用这个前缀构建iframe的src
const String PROXY_SCHEME = "https";
const String PROXY_HOST = "flutter-webview-proxy.internal";
const String PROXY_PATH_FETCH = "/fetch";

class TestPage extends StatefulWidget {
  const TestPage({super.key, 
 //required this.title
  });

  //final String title;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final TextEditingController _pluginUrlController = TextEditingController(
    text:
        'https://raw.githubusercontent.com/haygcao/test/refs/heads/main/newtellows.js', // 您的在线 JS 插件 URL
  );
  String _queryResult = '';
  String _jsLogs = ''; // 用于显示JS和代理日志
  InAppWebViewController? _webViewController;
  bool _isPluginJsLoaded = false;
  String? _loadedPluginId;
  final Map<String, Completer<Map<String, dynamic>?>> _requestCompleters = {};

  // --- 状态变量 ---
  // 简单模式的控制器和格式
  final _simplePhoneController = TextEditingController();
  String _selectedNumberFormat = 'phoneNumber';

  // 高级模式的控制器
  final _advancedPhoneNumberController = TextEditingController();
  final _advancedNationalNumberController = TextEditingController();
  final _advancedE164NumberController = TextEditingController();
  
  // --- 新增: 用于切换模式的开关状态 ---
  bool _isAdvancedMode = false;

  @override
  void initState() {
    super.initState();
  }

  void _addLog(String log) {
    print(log); // 打印到控制台
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
  // --- [删除开始] 删除了您原始的、过于严格的代理触发条件 ---
  /*
  // 这段原始代码的问题在于，它只能捕获对 /fetch 的初始请求，
  // 完全错过了页面内部后续发起的对 /css/app.css 或 https://www.cleverdialer.com/fetch 的子请求。
    if (uri.scheme == PROXY_SCHEME &&
        uri.host == PROXY_HOST &&
        uri.path.startsWith(PROXY_PATH_FETCH)) {
      _addLog('Proxy request matched for URL: ${uri.toString()}');
  */
  // --- [删除结束] ---

  // --- [新增开始] 替换为新的、更智能的代理触发条件 ---
  // 新的逻辑会检查两个条件，满足其一即可触发代理：
  // 条件1: 请求发往我们的虚构域名 (处理主页面和相对路径请求)。
  // 条件2: 请求的来源页(Referer)是我们的虚构域名 (处理绝对路径的子请求)。
  final referer = request.headers?['Referer'] ?? request.headers?['referer'];
  final shouldProxy = (uri.host == PROXY_HOST) || (referer?.contains(PROXY_HOST) ?? false);

  if (shouldProxy) {
  // --- [新增结束] ---
    // --- [修改开始] 修改了 try...catch 块内部的逻辑 ---
    // 原始代码的 try 块直接处理请求，因为它假设只有一种请求类型。
    // 新的 try 块内部增加了逻辑来区分主请求和子请求，并为它们分别计算正确的 URL 和请求头。
    try {
      Uri targetUrl;
      Map<String, String> requestHeaders = {};

      // --- [新增开始] 新增了智能判断逻辑，来处理不同类型的请求 ---
      if (uri.host == PROXY_HOST && uri.path.startsWith(PROXY_PATH_FETCH)) {
        // 类型 A: 主页面的初始请求。处理方式和您的原始代码完全一样。
        _addLog('Proxying MAIN request...');
        final targetUrlParam = uri.queryParameters['targetUrl'];
        final headersParam = uri.queryParameters['headers'];
        
        if (targetUrlParam == null || targetUrlParam.isEmpty) {
          _addLog('Proxy Error: Main request is missing targetUrl parameter.');
          // 注意：此处从返回 WebResourceResponse 改为返回 null，让 WebView 自己处理错误
          return null; 
        }
        
        targetUrl = Uri.parse(targetUrlParam);

        if (headersParam != null && headersParam.isNotEmpty) {
          try {
            final decodedHeaders =
                jsonDecode(Uri.decodeComponent(headersParam)) as Map<String, dynamic>;
            decodedHeaders
                .forEach((key, value) => requestHeaders[key] = value.toString());
          } catch (e) {
            _addLog('Error decoding headers for main request: $e');
          }
        }

      } else {
        // 类型 B: 页面内部发起的子请求 (相对路径资源, 或绝对路径 AJAX)
        _addLog('Proxying SUB-request...');
        if (referer == null) {
          _addLog('Proxy Error: Sub-request is missing Referer header, cannot resolve target.');
          return null;
        }

        final originalProxyUrl = Uri.parse(referer);
        final originalTargetUrlParam = originalProxyUrl.queryParameters['targetUrl'];
        
        if (originalTargetUrlParam == null) {
          _addLog('Proxy Error: Could not extract original targetUrl from Referer.');
          return null;
        }
        final originalBaseUrl = Uri.parse(originalTargetUrlParam);

        if (uri.host == PROXY_HOST) {
          // B1: 相对路径资源请求 (e.g., /css/app.css)，需要拼接 URL
          targetUrl = originalBaseUrl.resolve(uri.path);
        } else {
          // B2: 绝对路径子请求 (e.g., https://www.cleverdialer.com/fetch)，URL 就是它本身
          targetUrl = uri;
        }

        // 对于子请求，我们直接使用 WebView 传递过来的头信息
        request.headers?.forEach((key, value) {
          final lowerCaseKey = key.toLowerCase();
          if (lowerCaseKey != 'host' && lowerCaseKey != 'referer') {
            requestHeaders[key] = value;
          }
        });
      }
      // --- [新增结束] ---

      // --- [删除开始] 删除了您原始代码中解析 URL 和请求头的部分 ---
      /* 
      // 以下这部分逻辑已经被移动并整合到了上面新增的智能判断逻辑中，所以这里需要删除。
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
              */
      // --- [删除结束] ---

      _addLog('Proxying to target: $targetUrl');

        final cookieManager = CookieManager.instance();
        final cookies = await cookieManager.getCookies(url: WebUri.uri(targetUrl));
        if (cookies.isNotEmpty) {
             requestHeaders['Cookie'] = cookies.map((c) => '${c.name}=${c.value}').join('; ');
        }
       

        _addLog(
            'Making backend HTTP GET to: $targetUrl with headers: $requestHeaders');
        final response = await http.get(targetUrl, headers: requestHeaders);
        _addLog('Backend response received: ${response.statusCode} for $targetUrl');
      // --- [修改开始] 修改了脚本注入和响应头处理的部分 ---
      
      // 首先获取响应的真实 Content-Type 和 Encoding，以便后续正确返回
      final contentType = response.headers['content-type'] ?? '';
      final contentEncoding = response.headers['content-encoding'];
      var responseBody = response.bodyBytes;

      // --- [新增] 新增了判断条件，只对主框架的 HTML 文档注入脚本 ---
      // 原始代码会对所有返回的内容（包括CSS/JS）注入脚本，这是不正确的。isForMainFrame 属性被定义为一个可空布尔值，也就是 bool?。这意味着它的值可能是 true、false 或者 null
      if (request.isForMainFrame == true && contentType.contains('text/html')) {
        _addLog('Injecting script into main frame content...');
//之后保持不动
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
//之前保持不动
        // 将注入脚本后的 HTML 转换回字节流
        responseBody = Uint8List.fromList(utf8.encode(htmlBody));
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
    
      // --- [删除结束] ---
      // --- [新增] 以下是修正后的代码，它会创建一个新的、干净的响应头，过滤掉所有可能导致问题的头信息 ---
     final Map<String, String> responseHeaders = {}; // 同样从一个空 Map 开始
      bool xFrameRemoved = false;
      bool cspRemoved = false;

      response.headers.forEach((key, value) {
        final lowerCaseKey = key.toLowerCase();
        
        // 我们要拦截并移除这两个头信息
        if (lowerCaseKey == 'x-frame-options') {
          xFrameRemoved = true; // 标记已找到，但不把它加入到 filteredHeaders 中
        } else if (lowerCaseKey == 'content-security-policy') {
          cspRemoved = true; // 标记已找到，同样不加入
        } else {
          // 其他所有头信息都是安全的，可以加入
        responseHeaders[key] = value; // 把安全的头加入到 responseHeaders
        }
      });

      if (xFrameRemoved) {
        _addLog('Found and REMOVED "X-Frame-Options" header.');
      }
      if (cspRemoved) {
        _addLog('Found and REMOVED "Content-Security-Policy" header.');
      }
      // --- [新增结束] ---
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
        // --- 【最终修正】 ---
        // 错误的参数名 `encoding` 已被修正为正确的 `contentEncoding`
              // --- [修改] 修改了返回的 WebResourceResponse，使其更通用 ---
      // 原始代码硬编码了 contentType 和 encoding，现在我们使用从服务器获取的真实值。
        return WebResourceResponse(
          contentType: contentType,
          contentEncoding: contentEncoding,
          data: responseBody,
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
  _addLog('NOT PROXYING request: ${uri.toString()}');
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
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.pluginTestPageTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _pluginUrlController,
              decoration: const InputDecoration(
                hintText: 'Enter plugin JS URL',
                labelText: 'Plugin JS URL',
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _loadPlugin,
              child: Text(_isPluginJsLoaded ? 'Plugin Loaded ✓' : 'Load Plugin JS'),
            ),
            const SizedBox(height: 16),
            
            // --- 新增: 模式切换开关 ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Advanced Mode'),
                Switch(
                  value: _isAdvancedMode,
                  onChanged: (value) {
                    setState(() {
                      _isAdvancedMode = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- 修改: 根据模式显示不同输入框 ---
            if (_isAdvancedMode)
              // --- 高级模式 ---
              Column(
                children: [
                  TextField(
                    controller: _advancedPhoneNumberController,
                    decoration: const InputDecoration(
                      hintText: 'Enter phone number',
                      labelText: 'Phone Number',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _advancedNationalNumberController,
                    decoration: const InputDecoration(
                      hintText: 'Enter national number',
                      labelText: 'National Number',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _advancedE164NumberController,
                    decoration: const InputDecoration(
                      hintText: 'Enter E164 number',
                      labelText: 'E164 Number',
                    ),
                  ),
                ],
              )
            else
              // --- 简单模式 ---
              Column(
                children: [
                  TextField(
                    controller: _simplePhoneController,
                    decoration: const InputDecoration(
                      hintText: 'Enter phone number',
                      labelText: 'Phone Number',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Number Format: '),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _selectedNumberFormat,
                        items: const [
                          DropdownMenuItem(value: 'phoneNumber', child: Text('Phone Number')),
                          DropdownMenuItem(value: 'nationalNumber', child: Text('National Number')),
                          DropdownMenuItem(value: 'e164Number', child: Text('E164 Number')),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedNumberFormat = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _isPluginJsLoaded ? _queryPhoneNumber : null,
              child: const Text('Query Phone Info'),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Query Result:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(_queryResult.isEmpty ? 'No result yet' : _queryResult),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Logs:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          _jsLogs.isEmpty ? 'No logs yet' : _jsLogs,
                          style: const TextStyle(
                              fontSize: 12, fontFamily: 'monospace'),
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
                shouldInterceptRequest: _shouldInterceptRequest,
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

    setState(() {
      _queryResult = 'Querying...';
    });

    String? phoneNumber, nationalNumber, e164Number;

    if (_isAdvancedMode) {
      // --- 高级模式 ---
      phoneNumber = _advancedPhoneNumberController.text.trim();
      nationalNumber = _advancedNationalNumberController.text.trim();
      e164Number = _advancedE164NumberController.text.trim();

      if (phoneNumber.isEmpty && nationalNumber.isEmpty && e164Number.isEmpty) {
        setState(() {
          _queryResult = 'Please enter at least one number in advanced mode.';
        });
        return;
      }
       _addLog('Starting query in advanced mode...');
    } else {
      // --- 简单模式 ---
      final singleNumber = _simplePhoneController.text.trim();
      if (singleNumber.isEmpty) {
        setState(() {
          _queryResult = 'Please enter a phone number.';
        });
        return;
      }
      _addLog('Starting query for phone number: $singleNumber with format: $_selectedNumberFormat');
      // 根据选择的格式，将 singleNumber 赋值给对应的变量
      switch (_selectedNumberFormat) {
        case 'phoneNumber':
          phoneNumber = singleNumber;
          break;
        case 'nationalNumber':
          nationalNumber = singleNumber;
          break;
        case 'e164Number':
          e164Number = singleNumber;
          break;
      }
    }

    try {
      final requestId = 'req_${DateTime.now().millisecondsSinceEpoch}';
      final completer = Completer<Map<String, dynamic>?>();
      _requestCompleters[requestId] = completer;

      // 准备参数，如果为 null 或空，则传递 'null' 字符串
      String phoneParam = (phoneNumber?.isNotEmpty ?? false) ? "'$phoneNumber'" : 'null';
      String nationalParam = (nationalNumber?.isNotEmpty ?? false) ? "'$nationalNumber'" : 'null';
      String e164Param = (e164Number?.isNotEmpty ?? false) ? "'$e164Number'" : 'null';
      
      await _webViewController!.evaluateJavascript(source: '''
        (function(pluginId, requestId) {
          if (window.plugin && window.plugin[pluginId] && window.plugin[pluginId].generateOutput) {
            console.log(`Calling plugin[pluginId].generateOutput with params: ${phoneParam}, ${nationalParam}, ${e164Param}, ${requestId}`);
            window.plugin[pluginId].generateOutput($phoneParam, $nationalParam, $e164Param, requestId);
          } else {
            console.error('Plugin or generateOutput function not found for pluginId:', pluginId);
            window.flutter_inappwebview.callHandler('PluginResultChannel', JSON.stringify({ 
              requestId: requestId,
              success: false, 
              error: 'Plugin or generateOutput function not found for pluginId: ' + pluginId 
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