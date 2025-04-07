import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;

class TestPage extends StatefulWidget {
  const TestPage({super.key, required this.title});

  final String title;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final TextEditingController _pluginUrlController = TextEditingController(
    text:
        'https://raw.githubusercontent.com/haygcao/test/refs/heads/main/inappropriate.js', // 您的在线 JS 插件 URL
  );
  final TextEditingController _phoneNumberController = TextEditingController();
  String _queryResult = '';
  String _jsLogs = '';
  HeadlessInAppWebView? _headlessWebView;
  InAppWebViewController? _webViewController;
  bool _isPluginLoaded = false;
  String? _loadedPluginId; // 存储已加载插件的 ID
  Completer<Map<String, dynamic>?>? _queryCompleter; // 用于传递查询结果

  // 添加一个 Map 来存储每个请求的 requestId 和对应的 Completer
  Map<String, Completer<Map<String, dynamic>?>> _requestCompleters = {};

  @override
  void initState() {
    super.initState();
    _initializeHeadlessWebView();
  }

  Future<void> _initializeHeadlessWebView() async {
    _headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri("about:blank")),
      initialSettings: InAppWebViewSettings(
        isInspectable: true,
        javaScriptEnabled: true,
        javaScriptCanOpenWindowsAutomatically: true,
        allowUniversalAccessFromFileURLs: true, // 启用跨域
        allowFileAccessFromFileURLs: true,
      ),
      onWebViewCreated: (controller) {
        _webViewController = controller;

        // 添加 JavaScript handlers
        controller.addJavaScriptHandler(
          handlerName: 'TestPageChannel',
          callback: (args) {
            // ...
            if (args.isNotEmpty) {
              print('TestPageChannel message: ${args[0]}');
              try {
                final jsonData = jsonDecode(args[0]);
                print('jsonData打印: $jsonData'); // 输出解析后的 JSON 对象
                print('jsonData type: ${jsonData.runtimeType}');
                print('jsonData[\'type\']: ${jsonData['type']}');
                print('jsonData[\'pluginId\']: ${jsonData['pluginId']}');
                print('_loadedPluginId: $_loadedPluginId');
                if (jsonData['type'] == 'pluginLoaded') {
                  setState(() {
                    _loadedPluginId = jsonData['pluginId'];
                    _jsLogs += 'Plugin loaded: ${_loadedPluginId}\n';
                    _isPluginLoaded = true;
                  });
                } else if (jsonData['type'] == 'pluginReady') {
                  setState(() {
                    _jsLogs += 'Plugin Ready: ${jsonData['pluginId']}\n';
                  });
                } else if (jsonData['type'] == 'pluginError') {
                  setState(() {
                    _jsLogs += 'Plugin error: ${jsonData['error']}\n';
                  });
                }
              } catch (e) {
                print('Received message: ${args[0]}');
                _jsLogs += 'Received message: ${args[0]}\n';
              }
            }
          },
        );

        controller.addJavaScriptHandler(
          handlerName: 'PluginResultChannel',
          callback: (args) {
            //...
            print('Received message on PluginResultChannel: ${args[0]}');
            if (args.isNotEmpty) {
              try {
                final Map<String, dynamic> decodedMessage = jsonDecode(args[0]);

                // 检查消息类型、pluginId 和 requestId 是否匹配
                if (decodedMessage['type'] == 'pluginResult' &&
                    decodedMessage['pluginId'] == _loadedPluginId) {
                  final requestId = decodedMessage['requestId'];
                  final data =
                      Map<String, dynamic>.from(decodedMessage['data']);

                  // 查找并完成对应的 Completer
                  if (_requestCompleters.containsKey(requestId)) {
                    _requestCompleters[requestId]!.complete(data);
                    _requestCompleters.remove(requestId); // 移除已完成的 Completer
                  }
                  // 更新 UI
                  setState(() {
                    _queryResult = 'Count: ${data?['count'] ?? ''}\n'
                        'Source Label: ${data?['sourceLabel'] ?? ''}\n'
                        'Match Label: ${data?['predefinedLabel'] ?? ''}\n'
                        'Province: ${data?['province'] ?? ''}\n'
                        'City: ${data?['city'] ?? ''}\n'
                        'Carrier: ${data?['carrier'] ?? ''}\n'
                        'Name: ${data?['name'] ?? ''}\n'
                        'PhoneNumber: ${data?['phoneNumber'] ?? ''}';
                    _jsLogs += 'Query executed, result: $_queryResult\n';
                  });
                } else if (decodedMessage['type'] ==
                        'pluginError' && // 错误也可能有 requestId
                    decodedMessage['pluginId'] == _loadedPluginId) {
                  final requestId = decodedMessage['requestId']; // 获取 requestId
                  if (_requestCompleters.containsKey(requestId)) {
                    _requestCompleters[requestId]!.completeError(
                      decodedMessage['error'] ?? 'Unknown error from plugin',
                    );
                    _requestCompleters.remove(requestId); // 移除已完成的 Completer
                  }
                }
              } catch (e) {
                print('Error processing message on PluginResultChannel: $e');
              }
            }
          },
        );

        // 添加 RequestChannel，用于接收 JS 发送的请求信息
        controller.addJavaScriptHandler(
          handlerName: 'RequestChannel', // 与 JS 中的 callHandler 名称一致
          callback: (args) async {
            // 接收 JS 发送过来的请求信息 (args 是一个 List，第一个元素是请求信息)
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
                // final String requestId = requestData['requestId'];
                final String externalRequestId =
                    requestData['externalRequestId']; // Correct
                final String phoneRequestId =
                    requestData['phoneRequestId']; //  ADD THIS!
                // 使用 http 包发起实际的网络请求
                final response =
                    await _sendHttpRequest(method, url, headers, body);

                print("收到响应:");
                print("Status Code: ${response.statusCode}");
                print('response.body.length: ${response.body.length}');
                print('response.body.length: ${response.headers.length}');
                print(
                    'response.bodyBytes.length: ${response.bodyBytes.length}');
                print('response.body type: ${response.body.runtimeType}');
                print(
                    'response.bodyBytes type: ${response.bodyBytes.runtimeType}');
                debugPrint("Response Body: ${response.body}");
                print(
                    "Response Body: ${utf8.decode(response.bodyBytes)}"); // 将 response.bodyBytes 转换为字符串

                // 将响应数据编码为 JSON 字符串
                final responseData = {
                  // 'requestId': requestId, // 将 requestId 返回给 JS
                  'externalRequestId': externalRequestId, // Corrected
                  'phoneRequestId': phoneRequestId,
                  'status': response.statusCode,
                  'statusText': response.reasonPhrase,
                  'responseText': response.body,
                  'headers': response.headers,
                  //'phoneNumber': extractPhoneNumberFromUrl(url), // Add this!
                };
                final String responseJson = jsonEncode(responseData);

                // 将响应数据发送回 JS
                // 使用 evaluateJavascript，并确保转义特殊字符
                await controller.evaluateJavascript(source: '''
                  window.plugin.$_loadedPluginId.handleResponse($responseJson);
                ''');
              } catch (e) {
                print('Error handling request: $e');
              }
            }
          },
        );
        controller.addJavaScriptHandler(
          handlerName: 'consoleLog',
          callback: (args) {
            if (args.isNotEmpty) {
              print('JS Console Log: ${args[0]}');
              setState(() {
                _jsLogs += 'JS Console Log: ${args[0]}\n';
              });
            }
          },
        );

        controller.addJavaScriptHandler(
          handlerName: 'consoleWarn',
          callback: (args) {
            if (args.isNotEmpty) {
              print('JS Console Warn: ${args[0]}');
              setState(() {
                _jsLogs += 'JS Console Warn: ${args[0]}\n';
              });
            }
          },
        );
        controller.addJavaScriptHandler(
          handlerName: 'consoleError',
          callback: (args) {
            if (args.isNotEmpty) {
              print('JS Console Error: ${args[0]}');
              setState(() {
                _jsLogs += 'JS Console Error: ${args[0]}\n';
              });
            }
          },
        );
      },
      onConsoleMessage: (controller, consoleMessage) {
        print(consoleMessage);
        setState(() {
          _jsLogs +=
              '${consoleMessage.messageLevel.toString()}:${consoleMessage.message}\n';
        });
      },
    );

    _headlessWebView?.run();
  }

  Future<http.Response> _sendHttpRequest(String method, String url,
      Map<String, String> headers, String? body) async {
    print("打印Sending headers: $headers"); // 验证 headers
    switch (method) {
      case 'GET':
        return await http.get(Uri.parse(url), headers: headers);
      case 'POST':
        return await http.post(Uri.parse(url), headers: headers, body: body);
      // ... 处理其他 HTTP 方法
      default:
        throw Exception('Unsupported HTTP method: $method');
    }
  }

  // 加载 JS 插件 (从 URL 加载)
  Future<void> _loadPlugin() async {
    // ... (与之前相同)
    String pluginUrl = _pluginUrlController.text;
    try {
      final response = await http.get(Uri.parse(pluginUrl));
      if (response.statusCode == 200) {
        String jsCode = response.body;
        await _webViewController?.evaluateJavascript(source: jsCode);
        print('Plugin loaded from URL: $pluginUrl');
        setState(() {
          _jsLogs += 'Plugin loaded from URL: $pluginUrl\n';
          _isPluginLoaded = true;
        });
      } else {
        print('Failed to load plugin. Status code: ${response.statusCode}');
        setState(() {
          _jsLogs +=
              'Failed to load plugin. Status code: ${response.statusCode}\n';
        });
      }
    } catch (e) {
      print('Error loading plugin: $e');
      setState(() {
        _jsLogs += 'Error loading plugin: $e\n';
      });
    }
  }

  // 查询电话信息 (现在只是一个触发器，调用 JS 的 generateOutput)
  Future<Map<String, dynamic>?> _queryPhoneInfo() async {
    // ... (与之前相同)
    if (!_isPluginLoaded ||
        _webViewController == null ||
        _loadedPluginId == null) {
      setState(() {
        _queryResult =
            'Plugin is not loaded yet. Please load the plugin first.';
        _jsLogs += 'Attempted to query before plugin was loaded\n';
      });
      return null;
    }

    String phoneNumber = _phoneNumberController.text;
    final requestId = _generateUniqueId(); // 生成 requestId, 用于和JS中的Completer对应
    _queryCompleter = Completer<Map<String, dynamic>?>();
    _requestCompleters[requestId] = _queryCompleter!; //

    // 调用 JS 插件中的函数
    await _webViewController!.evaluateJavascript(source: '''
    (function(pluginId, requestId) {
      if (window.plugin && window.plugin[pluginId]) {
        window.plugin[pluginId].generateOutput('$phoneNumber', '', '', '$requestId');
      } else {
        console.error('Plugin not found or not loaded:', pluginId);
      }
    })('$_loadedPluginId', '$requestId');
''');
    try {
      return await _queryCompleter!.future.timeout(const Duration(seconds: 16));
    } catch (e) {
      print('Error or timeout waiting for result from JavaScript: $e');
      setState(() {
        _queryResult = 'Error: Timeout or other error';
        _jsLogs += 'Error: Timeout or other error\n';
      });
      _requestCompleters.remove(requestId); // 超时也要移除
      return null; // 或者抛出异常，取决于你的错误处理策略
    }
  }

  @override
  void dispose() {
    _headlessWebView?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _pluginUrlController,
              decoration: const InputDecoration(hintText: 'Enter plugin URL'),
            ),
            ElevatedButton(
              onPressed: _loadPlugin,
              child: const Text('Load Plugin'),
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(hintText: 'Enter phone number'),
            ),
            ElevatedButton(
              onPressed: _queryPhoneInfo, // 查询信息
              child: const Text('Query'),
            ),
            Text('Query Result: $_queryResult'),
            Expanded(
              child: SingleChildScrollView(
                child: Text('JS Logs: $_jsLogs'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
