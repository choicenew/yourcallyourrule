import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

import '../utils/http_interceptor.dart'; // 导入拦截器
import '../utils/network.dart'; // 导入 Network 组件代码


class TestPage extends StatefulWidget {
  const TestPage({super.key, required this.title});

  final String title;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final TextEditingController _pluginUrlController = TextEditingController(
      text:
          'https://raw.githubusercontent.com/haygcao/test/refs/heads/main/3baidu.js');
  final TextEditingController _phoneNumberController = TextEditingController();
  String _queryResult = '';
  String _jsLogs = '';
  late final WebViewController _controller;
  bool _isPluginLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'FlutterChannel', 
        onMessageReceived: (JavaScriptMessage message) async {
          // 处理来自 JavaScript 的消息
          if (message.message == 'Plugin loaded') {
            print('Plugin loaded');
            _jsLogs += 'Plugin loaded\n';
          } else if (message.message == 'PluginReady') {
            print('PluginReady');
            setState(() {
              _isPluginLoaded = true;
            });
            _jsLogs += 'PluginReady\n';
          } else if (message.message.startsWith('JS Error:')) {
            print('JS Error: ${message.message}');
            _jsLogs += 'JS Error: ${message.message}\n';
          } else if (message.message is String) {
            try {
              // 尝试解析为 JSON
              final jsonData = jsonDecode(message.message);
              // 处理 JSON 数据，例如更新 UI
              print('Received JSON data: $jsonData');
              _jsLogs += 'Received JSON data: $jsonData\n';
            } catch (e) {
              // 如果不是 JSON，则视为普通字符串消息
              print('Received message: ${message.message}');
              _jsLogs += 'Received message: ${message.message}\n';
            }
          }
        },
      )
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
            print('Page finished loading: $url');
            _jsLogs += 'Page finished loading: $url\n';
            // 在页面加载完成后加载 JS 插件
          //  await _loadPlugin();
          },
        ),
      );

    // 初始化 HTTP 拦截器
    HttpInterceptor().register(_controller);

    _controller.loadRequest(Uri.parse('about:blank'));
  }

  Future<void> _loadPlugin() async {
    String pluginUrl = _pluginUrlController.text;

    try {
      final response = await http.get(Uri.parse(pluginUrl));

      if (response.statusCode == 200) {
        String jsCode = response.body;

        // 执行 JS 代码
        await _controller.runJavaScript(jsCode);

        print('Plugin loading completed from URL: $pluginUrl');
        setState(() {
          _jsLogs += 'Plugin loading completed from URL: $pluginUrl\n';
                  _isPluginLoaded = true; // 设置插件加载状态
        });
      } else {
        print('Failed to load plugin from URL: ${response.statusCode}');
        setState(() {
          _queryResult =
              'Failed to load plugin from URL: ${response.statusCode}';
          _jsLogs +=
              'Failed to load plugin from URL: ${response.statusCode}\n';
        });
      }
    } catch (e) {
      print('Error loading plugin from URL: $e');
      setState(() {
        _queryResult = 'Error loading plugin from URL: $e';
        _jsLogs += 'Error loading plugin from URL: $e\n';
      });
    }
  }

  Future<void> _checkPluginStatus() async {
    try {
      final result = await _controller.runJavaScriptReturningResult('''
        (function() {
          if (typeof window.checkPluginStatus === 'function') {
            return window.checkPluginStatus();
          } else {
            console.error('checkPluginStatus function is not defined');
            return false;
          }
        })();
      ''');

      setState(() {
        _jsLogs += 'Plugin status check result: $result\n';
      });
    } catch (e) {
      print('Error checking plugin status: $e');
      setState(() {
        _jsLogs += 'Error checking plugin status: $e\n';
      });
    }
  }

  Future<void> _queryPhoneNumber() async {
    if (!_isPluginLoaded) {
      setState(() {
        _queryResult =
            'Plugin is not loaded yet. Please load the plugin first.';
        _jsLogs += 'Attempted to query before plugin was loaded\n';
      });
      return;
    }

    String phoneNumber = _phoneNumberController.text;

    try {
      final result = await _controller.runJavaScriptReturningResult('''
        (async function() {
          try {
            console.log('Starting phone number query');
            if (typeof window.plugin === 'undefined' || typeof window.plugin.queryPhoneNumber !== 'function') {
              throw new Error('Plugin or queryPhoneNumber function is not defined');
            }
            console.log('Calling queryPhoneNumber');
            const result = await window.plugin.queryPhoneNumber("$phoneNumber");
            console.log('Query result:', result);
            return JSON.stringify(result);
          } catch (error) {
            console.error('Error in query:', error);
            return JSON.stringify({ error: error.toString() });
          }
        })();
      ''');

      setState(() {
        _queryResult = result.toString();
        _jsLogs += 'Query executed, result: $_queryResult\n';
      });
    } catch (e) {
      print('Error querying phone number: $e');
      setState(() {
        _queryResult = 'Error querying phone number: $e';
        _jsLogs += 'Error querying phone number: $e\n';
      });
    }
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
              decoration:
                  const InputDecoration(hintText: 'Enter phone number'),
            ),
            ElevatedButton(
              onPressed: _queryPhoneNumber,
              child: const Text('Query'),
            ),
            ElevatedButton(
              onPressed: _checkPluginStatus,
              child: const Text('Check Plugin Status'),
            ),
            Text('Query Result: $_queryResult',
                style: const TextStyle(fontSize: 16.0)),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Text('JS Logs:\n$_jsLogs',
                    style: const TextStyle(fontSize: 14.0)),
              ),
            ),
            Expanded(
              child: WebViewWidget(controller: _controller),
            ),
            // 添加 Network 组件
            Expanded(
              child: Network(), // 这里使用你提供的 Network 组件
            ),
          ],
        ),
      ),
    );
  }
}