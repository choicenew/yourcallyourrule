import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../config/cloudflare_config.dart';

/// Cloudflare R2 对象存储底层 Client
class CloudflareR2Client {
  final CloudflareConfig config;
  final http.Client _httpClient;

  CloudflareR2Client({
    required this.config,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// 上传对象文件
  Future<bool> putObject(String objectKey, Uint8List bytes, {String contentType = 'application/octet-stream'}) async {
    if (!config.isValid) return false;
    try {
      final uri = Uri.parse('${config.workerUrl}/api/r2/object/$objectKey');
      final headers = {
        ...config.authHeaders,
        'Content-Type': contentType,
      };

      final response = await _httpClient.put(uri, headers: headers, body: bytes);
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (_) {
      return false;
    }
  }

  /// 获取/下载对象文件字节
  Future<Uint8List?> getObject(String objectKey) async {
    if (!config.isValid) return null;
    try {
      final uri = Uri.parse('${config.workerUrl}/api/r2/object/$objectKey');
      final response = await _httpClient.get(uri, headers: config.authHeaders);
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
    } catch (_) {}
    return null;
  }

  /// 删除对象文件
  Future<bool> deleteObject(String objectKey) async {
    if (!config.isValid) return false;
    try {
      final uri = Uri.parse('${config.workerUrl}/api/r2/object/$objectKey');
      final response = await _httpClient.delete(uri, headers: config.authHeaders);
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (_) {
      return false;
    }
  }
}
