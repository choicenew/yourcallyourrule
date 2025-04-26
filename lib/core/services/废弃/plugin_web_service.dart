import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';

class PluginWebService {
  HeadlessInAppWebView? _headlessWebView;
  InAppWebViewController? _webViewController;
  bool _isPluginLoaded = false;
  String? _loadedPluginId;
  
  // 存储每个插件查询的 Completer
  final Map<String, Completer<Map<String, dynamic>?>> _pluginQueryCompleters = {};
  
  // 跟踪每个插件的就绪状态
  final Map<String, bool> _pluginReadyStatus = {};
  
  // 用于通知插件就绪状态的 StreamController
  final StreamController<String> _pluginReadyController = StreamController<String>.broadcast();
  
  // 添加一个 Map 用于存储已加载的插件对象
  static Map<String, dynamic> loadedPlugins = {};
  
  PluginWebService() {
    // 构造函数中不立即初始化，改为显式调用初始化方法
  }
  
  // 初始化 WebView
  Future<void> initializeWebView() async {
    await _initializeHeadlessWebView();
  }
  
  // 完全保持原始 WebView 初始化逻辑
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

        // 添加 JavaScript handlers，参照原始代码
        controller.addJavaScriptHandler(
          handlerName: 'TestPageChannel',
          callback: (args) {
            if (args.isNotEmpty) {
              print('TestPageChannel message: ${args[0]}');
              try {
                final jsonData = jsonDecode(args[0]);
                print('jsonData打印: $jsonData');
                print('jsonData type: ${jsonData.runtimeType}');
                print('jsonData[\'type\']: ${jsonData['type']}');
                print('jsonData[\'pluginId\']: ${jsonData['pluginId']}');
                print('_loadedPluginId: $_loadedPluginId');
                
                if (jsonData['type'] == 'pluginLoaded') {
                  _loadedPluginId = jsonData['pluginId'];
                  _isPluginLoaded = true;
                  loadedPlugins[jsonData['pluginId']] = true;
                  
                  // 标记插件为就绪状态
                  _pluginReadyStatus[jsonData['pluginId']] = true;
                  // 通过 StreamController 发送插件就绪通知
                  _pluginReadyController.add(jsonData['pluginId']);
                } else if (jsonData['type'] == 'pluginReady') {
                  print('Plugin ready: ${jsonData['pluginId']}');
                  
                  // 标记插件为就绪状态
                  _pluginReadyStatus[jsonData['pluginId']] = true;
                  // 通过 StreamController 发送插件就绪通知
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

        controller.addJavaScriptHandler(
          handlerName: 'PluginResultChannel',
          callback: (args) {
            print('Received message on PluginResultChannel: ${args[0]}');
            if (args.isNotEmpty) {
              try {
                final Map<String, dynamic> decodedMessage = jsonDecode(args[0]);

                // 检查消息类型、pluginId 和 requestId 是否匹配
                if (decodedMessage['type'] == 'pluginResult' &&
                    decodedMessage['pluginId'] == _loadedPluginId) {
                  final requestId = decodedMessage['requestId'];
                  final data = Map<String, dynamic>.from(decodedMessage['data']);

                  // 查找并完成对应的 Completer
                  if (_pluginQueryCompleters.containsKey(requestId)) {
                    _pluginQueryCompleters[requestId]!.complete(data);
                    _pluginQueryCompleters.remove(requestId); // 移除已完成的 Completer
                  }
                } else if (decodedMessage['type'] == 'pluginError' && 
                    decodedMessage['pluginId'] == _loadedPluginId) {
                  final requestId = decodedMessage['requestId']; // 获取 requestId
                  if (_pluginQueryCompleters.containsKey(requestId)) {
                    _pluginQueryCompleters[requestId]!.completeError(
                      decodedMessage['error'] ?? 'Unknown error from plugin',
                    );
                    _pluginQueryCompleters.remove(requestId); // 移除已完成的 Completer
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
                final String externalRequestId = requestData['externalRequestId'];
                final String phoneRequestId = requestData['phoneRequestId'];
                
                // 使用 http 包发起实际的网络请求
                final response = await _sendHttpRequest(method, url, headers, body);

                print("收到响应:");
                print("Status Code: ${response.statusCode}");
                print('response.body.length: ${response.body.length}');
                print('response.headers.length: ${response.headers.length}');
                
                // 将响应数据编码为 JSON 字符串
                final responseData = {
                  'externalRequestId': externalRequestId,
                  'phoneRequestId': phoneRequestId,
                  'status': response.statusCode,
                  'statusText': response.reasonPhrase,
                  'responseText': response.body,
                  'headers': response.headers,
                };
                final String responseJson = jsonEncode(responseData);

                // 将响应数据发送回 JS
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
      },
      onConsoleMessage: (controller, consoleMessage) {
        print(consoleMessage);
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
      // 处理其他 HTTP 方法
      default:
        throw Exception('Unsupported HTTP method: $method');
    }
  }
  
  // 获取插件就绪状态流
  Stream<String> get pluginReadyStream => _pluginReadyController.stream;
  
  // 检查插件是否就绪
  bool isPluginReady(String pluginId) => _pluginReadyStatus[pluginId] ?? false;
  
  // 获取当前加载的插件 ID
  String? get loadedPluginId => _loadedPluginId;
  
  // 执行插件函数
  Future<Map<String, dynamic>?> executePluginFunction(
    String functionName, 
    Map<String, dynamic> params
  ) async {
    if (_loadedPluginId == null || !_isPluginLoaded) {
      throw Exception('No plugin loaded');
    }
    
    final requestId = DateTime.now().millisecondsSinceEpoch.toString();
    final completer = Completer<Map<String, dynamic>?>();
    _pluginQueryCompleters[requestId] = completer;
    
    final paramsJson = jsonEncode(params);
    await _webViewController?.evaluateJavascript(source: '''
      window.plugin.$_loadedPluginId.$functionName($paramsJson, '$requestId');
    ''');
    
    return completer.future;
  }
  
  // 加载插件脚本
  Future<void> loadPluginScript(PluginEntry plugin) async {
    if (_webViewController == null) {
      throw Exception('WebView not initialized');
    }
    
    // 从本地加载脚本
    final scriptPath = await _getPluginScriptPath(plugin.id);
    final file = File(scriptPath);
    
    if (!await file.exists()) {
      throw Exception('Plugin script not found: ${plugin.id}');
    }
    
    final script = await file.readAsString();
    
    // 重置状态
    _isPluginLoaded = false;
    _loadedPluginId = null;
    
    // 注入插件脚本
    await _webViewController!.evaluateJavascript(source: script);
  }
  
  // 保存脚本到本地
  Future<void> saveScriptToLocal(PluginEntry plugin, String script) async {
    final scriptPath = await _getPluginScriptPath(plugin.id);
    final file = File(scriptPath);
    await file.writeAsString(script);
  }
  
  // 获取插件脚本路径
  Future<String> _getPluginScriptPath(String pluginId) async {
    final directory = await _getPluginsDirectory();
    return '${directory.path}/$pluginId.js';
  }
  
  // 获取插件目录
  static Future<Directory> _getPluginsDirectory() async {
    final appSupportDirectory = await getApplicationSupportDirectory();
    final pluginsDirectory = Directory(join(appSupportDirectory.path, 'plugins'));
    
    if (!pluginsDirectory.existsSync()) {
      pluginsDirectory.createSync(recursive: true);
    }
    
    return pluginsDirectory;
  }
  
  // 从插件脚本中提取插件信息
  static Map<String, String> extractPluginInfo(String script) {
    final idRegex = RegExp(r"id: '(.*)',");
    final nameRegex = RegExp(r"name: '(.*)',");
    final versionRegex = RegExp(r"version: '(.*)',");
    
    final idMatch = idRegex.firstMatch(script);
    final nameMatch = nameRegex.firstMatch(script);
    final versionMatch = versionRegex.firstMatch(script);
    
    return {
      'id': idMatch?.group(1) ?? '',
      'name': nameMatch?.group(1) ?? '',
      'version': versionMatch?.group(1) ?? '',
    };
  }
  
  // 提取远程版本
  static String extractRemoteVersion(String script) {
    final versionRegex = RegExp(r"version: '(.*)',");
    final match = versionRegex.firstMatch(script);
    if (match != null && match.groupCount > 0) {
      return match.group(1)!;
    } else {
      throw Exception('无法从脚本中提取远程版本号');
    }
  }
  
  // 检查是否有更新版本
  static bool isNewerVersion(String remoteVersion, String currentVersion) {
    return remoteVersion.compareTo(currentVersion) > 0;
  }
}