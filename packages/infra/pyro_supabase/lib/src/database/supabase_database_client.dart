import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import '../config/supabase_config.dart';

/// PostgreSQL REST/RPC 数据库操作底层 Client
/// 内部自带 Isolate 下沉机制，大记录解包与 JSON 解析绝不卡顿 UI 主线程
class SupabaseDatabaseClient {
  final SupabaseConfig config;
  final http.Client _httpClient;

  SupabaseDatabaseClient({
    required this.config,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// 从指定表查询数据 (后台 Isolate 线程解包)
  Future<List<Map<String, dynamic>>> select(
    String table, {
    String columns = '*',
    Map<String, String>? filters,
  }) async {
    if (!config.isValid) return [];
    try {
      final queryParams = {'select': columns, ...?filters};
      final uri = Uri.parse('${config.supabaseUrl}/rest/v1/$table').replace(queryParameters: queryParams);
      final response = await _httpClient.get(uri, headers: config.authHeaders);

      if (response.statusCode == 200) {
        return await Isolate.run(() {
          final decoded = jsonDecode(response.body);
          if (decoded is List) {
            return decoded.cast<Map<String, dynamic>>();
          }
          return <Map<String, dynamic>>[];
        });
      }
    } catch (_) {}
    return [];
  }

  /// 插入数据行 (后台 Isolate 编码)
  Future<bool> insert(String table, Map<String, dynamic> data) async {
    if (!config.isValid) return false;
    try {
      final uri = Uri.parse('${config.supabaseUrl}/rest/v1/$table');
      final headers = {
        ...config.authHeaders,
        'Prefer': 'return=minimal',
      };
      final body = await Isolate.run(() => jsonEncode(data));

      final response = await _httpClient.post(
        uri,
        headers: headers,
        body: body,
      );
      return response.statusCode == 201;
    } catch (_) {
      return false;
    }
  }

  /// 批量 Upsert 更新或插入 (后台 Isolate 编码)
  Future<bool> upsert(String table, List<Map<String, dynamic>> records, {String? onConflict}) async {
    if (!config.isValid || records.isEmpty) return false;
    try {
      final uri = Uri.parse('${config.supabaseUrl}/rest/v1/$table');
      final headers = {
        ...config.authHeaders,
        'Prefer': 'resolution=merge-duplicates,return=minimal',
        if (onConflict != null) 'on_conflict': onConflict,
      };
      final body = await Isolate.run(() => jsonEncode(records));

      final response = await _httpClient.post(
        uri,
        headers: headers,
        body: body,
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (_) {
      return false;
    }
  }

  /// 调用 Supabase RPC 存储过程 (后台 Isolate 解包)
  Future<dynamic> rpc(String functionName, [Map<String, dynamic>? params]) async {
    if (!config.isValid) return null;
    try {
      final uri = Uri.parse('${config.supabaseUrl}/rest/v1/rpc/$functionName');
      final body = await Isolate.run(() => jsonEncode(params ?? {}));
      final response = await _httpClient.post(
        uri,
        headers: config.authHeaders,
        body: body,
      );
      if (response.statusCode == 200) {
        return await Isolate.run(() => jsonDecode(response.body));
      }
    } catch (_) {}
    return null;
  }
}

extension on SupabaseConfig {
  Map<String, String> get authHeaders => defaultHeaders;
}
