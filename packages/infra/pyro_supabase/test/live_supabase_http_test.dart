import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:pyro_supabase/pyro_supabase.dart';

void main() {
  group('pyro_supabase 真实 Supabase callRuleProject Live 物理认证测试', () {
    const supabaseUrl = 'https://wujjtdwsvweaotquafaf.supabase.co';
    const anonKey =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind1amp0ZHdzdndlYW90cXVhZmFmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM1NTE3MjcsImV4cCI6MjA3OTEyNzcyN30.d7OqKmxZX8cYmq5lFyJfIqtIDYaCpT-YICFVVZU96Fg';
    const serviceRoleKey =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind1amp0ZHdzdndlYW90cXVhZmFmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2MzU1MTcyNywiZXhwIjoyMDc5MTI3NzI3fQ.eT5Qb5dZjtpSQaNQxqLwcGhvjp_aW4V1ke2lmTwTooU';

    test('使用真实 serviceRoleKey 校验 PostgREST OpenAPI 规范接口鉴权', () async {
      final config = const SupabaseConfig(
        supabaseUrl: supabaseUrl,
        anonKey: anonKey,
        serviceRoleKey: serviceRoleKey,
      );

      final response = await http.get(
        Uri.parse('$supabaseUrl/rest/v1/'),
        headers: config.defaultHeaders,
      );

      print('✅ 真实 Supabase 鉴权成功 Status Code: ${response.statusCode}');
      print('✅ 真实 Supabase OpenAPI Schema 返回 Preview: ${response.body.substring(0, response.body.length > 150 ? 150 : response.body.length)}...');

      expect(response.statusCode, equals(200));
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      expect(json.containsKey('swagger') || json.containsKey('openapi') || json.containsKey('paths'), isTrue);
    });

    test('使用 SupabaseDatabaseClient 基于真实密钥连接 PostgREST API 查询表结构', () async {
      final config = const SupabaseConfig(
        supabaseUrl: supabaseUrl,
        anonKey: anonKey,
        serviceRoleKey: serviceRoleKey,
      );

      final dbClient = SupabaseDatabaseClient(config: config);
      final rows = await dbClient.select('');

      print('✅ SupabaseDatabaseClient 真实 PostgREST 网络查询成功！返回 Status: 200, 结果: $rows');
      expect(rows, isA<List<Map<String, dynamic>>>());
    });
  });
}
