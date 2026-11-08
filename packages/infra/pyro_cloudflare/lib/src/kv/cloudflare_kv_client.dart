import 'package:http/http.dart' as http;
import '../config/cloudflare_config.dart';

/// Cloudflare KV 键值数据库底层 Client
class CloudflareKVClient {
  final CloudflareConfig config;
  final http.Client _httpClient;

  CloudflareKVClient({
    required this.config,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// 写入键值对
  Future<bool> put(String key, String value, {int? expirationTtl}) async {
    if (!config.isValid) return false;
    try {
      final uri = Uri.parse('${config.workerUrl}/api/kv/key/$key');
      final headers = config.authHeaders;
      final response = await _httpClient.put(
        uri,
        headers: headers,
        body: value,
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// 读取键对应的值
  Future<String?> get(String key) async {
    if (!config.isValid) return null;
    try {
      final uri = Uri.parse('${config.workerUrl}/api/kv/key/$key');
      final response = await _httpClient.get(uri, headers: config.authHeaders);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (_) {}
    return null;
  }

  /// 删除键值对
  Future<bool> delete(String key) async {
    if (!config.isValid) return false;
    try {
      final uri = Uri.parse('${config.workerUrl}/api/kv/key/$key');
      final response = await _httpClient.delete(uri, headers: config.authHeaders);
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (_) {
      return false;
    }
  }
}
