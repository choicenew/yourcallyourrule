import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

import 'network.dart'; // 导入你的 Network 组件代码

class HttpInterceptor {
  static final HttpInterceptor _instance = HttpInterceptor._internal();

  factory HttpInterceptor() {
    return _instance;
  }

  HttpInterceptor._internal();

  void register(WebViewController controller) {
    controller.addJavaScriptChannel(
      'FlutterChannel', // 唯一的 JavaScript 通道
      onMessageReceived: (JavaScriptMessage message) async {
        // 接收 JS 插件发送的 XMLHttpRequest 请求信息
        final requestData = jsonDecode(message.message);
        final method = requestData['method'] as String;
        final url = requestData['url'] as String;
        final headers = (requestData['headers'] as Map<String, dynamic>)
            .cast<String, String>();
        final body = requestData['body'] as String?;
        final pluginId = requestData['pluginId'] as String?; // 获取插件 ID


        // 记录请求信息 (发送前)
        String id = _generateUniqueId();
        int startTime = DateTime.now().millisecondsSinceEpoch;
        RequestData requestInfo = RequestData(
          id: id,
          method: method,
          url: url,
          host: Uri.parse(url).host,
          reqHeaders: headers,
          startTime: startTime,
          postData: body,
          readyState: 1, // 设置 readyState 为 1，表示请求已打开
        );
        ajaxStack.updateRequest(id, requestInfo);

        // 发送 HTTP 请求
        final response = await _sendHttpRequest(method, url, headers, body);

        // 更新请求信息 (接收响应后)
        int endTime = DateTime.now().millisecondsSinceEpoch;
        requestInfo
          ..readyState = 4 // 设置 readyState 为 4，表示请求已完成
          ..status = response.statusCode.toString()
          ..resHeaders = response.headers
          ..endTime = endTime
          ..costTime = endTime - startTime
          ..response = response.body; // 直接获取响应体

        ajaxStack.updateRequest(id, requestInfo);


        // 将响应发送回指定的 JS 插件
        controller.runJavaScript('''
          window.postMessage({
            type: 'xhrResponse_${pluginId}', 
            response: ${jsonEncode({
              'status': response.statusCode,
              'statusText': response.reasonPhrase,
              'responseText': response.body,
              'headers': response.headers,
            })}
          }, '*'); // 将目标窗口设置为 '*'
        ''');
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
      // ... 处理其他 HTTP 方法
      default:
        throw Exception('Unsupported HTTP method: $method');
    }
  }

  String _generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
