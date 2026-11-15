import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import '../config/cloudflare_config.dart';

class D1QueryResult {
  final bool success;
  final List<Map<String, dynamic>> rows;
  final int rowsAffected;
  final String? error;

  const D1QueryResult({
    required this.success,
    this.rows = const [],
    this.rowsAffected = 0,
    this.error,
  });
}

class CloudflareD1Client {
  final CloudflareConfig config;
  final http.Client _httpClient;

  CloudflareD1Client({
    required this.config,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  Future<D1QueryResult> query(String sql, [List<dynamic>? params]) async {
    if (!config.isValid) {
      return const D1QueryResult(
        success: false,
        error: 'Invalid CloudflareConfig credentials.',
      );
    }

    try {
      final uri = Uri.parse('${config.workerUrl}/api/d1/query');
      final body = await Isolate.run(() => jsonEncode({
            'sql': sql,
            'params': params ?? [],
          }));

      final response = await _httpClient.post(
        uri,
        headers: config.authHeaders,
        body: body,
      );

      if (response.statusCode == 200) {
        return await Isolate.run(() {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          final results = (data['results'] as List?)?.cast<Map<String, dynamic>>() ?? [];
          final meta = data['meta'] as Map<String, dynamic>?;
          return D1QueryResult(
            success: true,
            rows: results,
            rowsAffected: meta?['changes'] as int? ?? 0,
          );
        });
      } else {
        return D1QueryResult(
          success: false,
          error: 'D1 HTTP Error ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      return D1QueryResult(
        success: false,
        error: 'D1 Network Exception: $e',
      );
    }
  }

  Future<D1QueryResult> batch(List<Map<String, dynamic>> sqlStatements) async {
    if (!config.isValid) {
      return const D1QueryResult(
        success: false,
        error: 'Invalid CloudflareConfig credentials.',
      );
    }

    try {
      final uri = Uri.parse('${config.workerUrl}/api/d1/batch');
      final body = await Isolate.run(() => jsonEncode({'statements': sqlStatements}));

      final response = await _httpClient.post(
        uri,
        headers: config.authHeaders,
        body: body,
      );

      if (response.statusCode == 200) {
        return const D1QueryResult(success: true, rowsAffected: 1);
      }
      return D1QueryResult(
        success: false,
        error: 'D1 Batch Error ${response.statusCode}: ${response.body}',
      );
    } catch (e) {
      return D1QueryResult(
        success: false,
        error: 'D1 Batch Exception: $e',
      );
    }
  }
}
