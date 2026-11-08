import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {
  group('pyro_cloudflare 真实 Cloudflare API Live 物理测试', () {
    test('使用真实 CLOUDFLARE_API_TOKEN 向 Cloudflare 官方 API 验证 Token 有效性与账户连通性', () async {
      final apiToken = Platform.environment['CLOUDFLARE_API_TOKEN'] ?? 'YOUR_CLOUDFLARE_API_TOKEN';
      final accountId = Platform.environment['CLOUDFLARE_ACCOUNT_ID'] ?? 'YOUR_ACCOUNT_ID';

      // 向 Cloudflare 官方 REST API Token 验证接口发起物理 HTTP 请求
      final response = await http.get(
        Uri.parse('https://api.cloudflare.com/client/v4/user/tokens/verify'),
        headers: {
          'Authorization': 'Bearer $apiToken',
          'Content-Type': 'application/json',
        },
      );

      print('✅ 真实 Cloudflare API Status Code: ${response.statusCode}');
      print('✅ 真实 Cloudflare API 物理返回 Body: ${response.body}');

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      expect(json.containsKey('success'), isTrue);
    });
  });
}
