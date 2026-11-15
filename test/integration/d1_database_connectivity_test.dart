import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  String accountId = 'e87712496c83db17e89638a78a4ad71e';
  String databaseId = '5a1c8845-60a6-4ac0-a7bb-f3c445d8a386';
  String apiToken = '';

  final envFile = File('.env');
  if (envFile.existsSync()) {
    final lines = envFile.readAsLinesSync();
    for (final line in lines) {
      if (line.startsWith('CLOUDFLARE_API_TOKEN=')) {
        apiToken = line.split('=')[1].trim();
      } else if (line.startsWith('CLOUDFLARE_ACCOUNT_ID=')) {
        accountId = line.split('=')[1].trim();
      } else if (line.startsWith('D1_DATABASE_ID=')) {
        databaseId = line.split('=')[1].trim();
      }
    }
  }

  test('🔌 在线实测 Cloudflare D1 (callrule_test_d1) 数据库 API 连通性', () async {
    expect(apiToken.isNotEmpty, isTrue, reason: '.env 文件未找到 CLOUDFLARE_API_TOKEN 秘钥');

    final url = 'https://api.cloudflare.com/client/v4/accounts/$accountId/d1/database/$databaseId/query';

    final headers = {
      'Authorization': 'Bearer $apiToken',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'sql': 'SELECT 1 AS alive_check;',
    });

    print('[D1 Connectivity] 发起真实 Cloudflare D1 API SQL 连通性测试...');
    print('[D1 Connectivity] Target URL: $url');

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print('[D1 Connectivity] HTTP Status Code: ${response.statusCode}');
    print('[D1 Connectivity] Response Body: ${response.body}');

    expect(response.statusCode, equals(200));

    final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
    expect(jsonMap['success'], isTrue);

    final resultList = jsonMap['result'] as List?;
    expect(resultList, isNotNull);
    expect(resultList!.isNotEmpty, isTrue);

    final firstResult = resultList.first as Map<String, dynamic>;
    final resultsData = firstResult['results'] as List?;
    expect(resultsData, isNotNull);
    expect(resultsData!.first['alive_check'], equals(1));

    print('✅ [D1 Connectivity] 成功连接到 Cloudflare D1 (callrule_test_d1)，SQL 查询 100% 成功！');
  });
}
