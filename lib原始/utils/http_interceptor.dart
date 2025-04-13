import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AjaxInterceptor {
  Future<AjaxRequest?> intercept(
    InAppWebViewController controller,
    AjaxRequest ajaxRequest,
    String requestId,
    String? pluginId,
  ) async {
    print("AjaxInterceptor - 开始处理请求: ${ajaxRequest.url}");
    
    try {
      // 设置较长的超时时间
      final client = http.Client();
      final response = await client.get(
        Uri.parse(ajaxRequest.url.toString()),
        headers: ajaxRequest.headers?.toMap().cast<String, String>() ?? {},
      ).timeout(const Duration(seconds: 20));
      
      print("收到响应状态码: ${response.statusCode}");
      
      if (response.statusCode == 200) {
        // 构建响应事件
        final eventData = {
          'type': 'xhrResponse_$pluginId',
          'detail': {
            'response': {
              'status': response.statusCode,
              'statusText': response.reasonPhrase,
              'responseText': response.body,
              'headers': response.headers,
            },
            'requestId': requestId,
          },
        };

        // 触发自定义事件
        await controller.evaluateJavascript(source: """
          const event = new CustomEvent('${eventData['type']}', { 
            detail: ${jsonEncode(eventData['detail'])} 
          });
          window.dispatchEvent(event);
        """);
        
        print("事件已触发: xhrResponse_$pluginId");
      } else {
        throw Exception('HTTP错误: ${response.statusCode}');
      }
      
      client.close();
      return null;
      
    } catch (e) {
      print("AjaxInterceptor 错误: $e");
      // 发送错误事件到 JavaScript
      await controller.evaluateJavascript(source: """
        const errorEvent = new CustomEvent('xhrError_$pluginId', {
          detail: {
            error: "${e.toString()}",
            requestId: "$requestId"
          }
        });
        window.dispatchEvent(errorEvent);
      """);
      return ajaxRequest;
    }
  }
}