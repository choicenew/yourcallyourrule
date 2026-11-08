import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import '../config/cloudflare_config.dart';

/// Cloudflare Worker REST 自定义路由通用交互底座
/// 内部自带 Isolate 下沉机制，大流量与 JSON 解析绝不阻塞主 UI 线程
class CloudflareWorkerClient {
  final CloudflareConfig config;
  final http.Client _httpClient;

  CloudflareWorkerClient({
    required this.config,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// 发起通用 POST 请求到 Worker 自定义 Endpoint (后台 Isolate 线程解包)
  Future<Map<String, dynamic>?> post(String path, Map<String, dynamic> payload) async {
    if (!config.isValid) return null;
    try {
      final sanitizedPath = path.startsWith('/') ? path : '/$path';
      final uri = Uri.parse('${config.workerUrl}$sanitizedPath');
      final body = await Isolate.run(() => jsonEncode(payload));

      final response = await _httpClient.post(
        uri,
        headers: config.authHeaders,
        body: body,
      );

      if (response.statusCode == 200) {
        return await Isolate.run(() => jsonDecode(response.body) as Map<String, dynamic>);
      }
    } catch (_) {}
    return null;
  }

  /// 发起通用 GET 请求到 Worker 自定义 Endpoint (后台 Isolate 线程解包)
  Future<Map<String, dynamic>?> get(String path, [Map<String, String>? queryParameters]) async {
    if (!config.isValid) return null;
    try {
      final sanitizedPath = path.startsWith('/') ? path : '/$path';
      var uri = Uri.parse('${config.workerUrl}$sanitizedPath');
      if (queryParameters != null && queryParameters.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParameters);
      }

      final response = await _httpClient.get(uri, headers: config.authHeaders);
      if (response.statusCode == 200) {
        return await Isolate.run(() => jsonDecode(response.body) as Map<String, dynamic>);
      }
    } catch (_) {}
    return null;
  }
}
