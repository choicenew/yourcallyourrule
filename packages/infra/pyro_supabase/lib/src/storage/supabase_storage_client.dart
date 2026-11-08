import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../config/supabase_config.dart';

/// Supabase Storage 桶纯文件流底层 Client
class SupabaseStorageClient {
  final SupabaseConfig config;
  final http.Client _httpClient;

  SupabaseStorageClient({
    required this.config,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// 上传文件字节到 Storage 储物桶
  Future<bool> upload(String bucket, String path, Uint8List bytes, {String contentType = 'application/octet-stream'}) async {
    if (!config.isValid) return false;
    try {
      final uri = Uri.parse('${config.supabaseUrl}/storage/v1/object/$bucket/$path');
      final headers = {
        ...config.defaultHeaders,
        'Content-Type': contentType,
        'x-upsert': 'true',
      };

      final response = await _httpClient.post(uri, headers: headers, body: bytes);
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// 从 Storage 储物桶下载文件字节
  Future<Uint8List?> download(String bucket, String path) async {
    if (!config.isValid) return null;
    try {
      final uri = Uri.parse('${config.supabaseUrl}/storage/v1/object/$bucket/$path');
      final response = await _httpClient.get(uri, headers: config.defaultHeaders);
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
    } catch (_) {}
    return null;
  }

  /// 删除 Storage 储物桶内的指定文件
  Future<bool> remove(String bucket, List<String> paths) async {
    if (!config.isValid || paths.isEmpty) return false;
    try {
      final uri = Uri.parse('${config.supabaseUrl}/storage/v1/object/$bucket');
      final response = await _httpClient.delete(
        uri,
        headers: config.defaultHeaders,
        body: '{"prefixes": $paths}',
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
