import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CloudFlareD1Service {
  static final String _accountId = dotenv.get('CF_ACCOUNT_ID');
  static final String _apiToken = dotenv.get('CF_API_TOKEN');
  static const String _baseUrl = 'https://api.cloudflare.com/client/v4/accounts';

  // 执行D1原子操作
  Future<Map<String, dynamic>> atomicUpdate({
    required String databaseId,
    required String query,
    required Map<String, dynamic> params,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$_accountId/d1/database/$databaseId/query'),
      headers: {
        'Authorization': 'Bearer $_apiToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'sql': query,
        'params': params,
      }),
    );

    return _handleResponse(response);
  }

  // 获取增量变更
  Future<List<Map<String, dynamic>>> getChanges({
    required String databaseId,
    required DateTime since,
  }) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$_accountId/d1/database/$databaseId/changes?'
          'since=${since.toIso8601String()}'),
      headers: {'Authorization': 'Bearer $_apiToken'},
    );

    return _handleResponse(response)['result'] ?? [];
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('D1 API请求失败: ${response.statusCode}');
  }
}