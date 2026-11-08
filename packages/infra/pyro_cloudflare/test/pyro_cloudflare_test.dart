import 'dart:convert';
import 'dart:typed_data';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pyro_cloudflare/pyro_cloudflare.dart';

void main() {
  group('pyro_cloudflare 基础设施 Client 单元测试', () {
    late CloudflareConfig config;

    setUp(() {
      config = const CloudflareConfig(
        workerUrl: 'https://test-worker.dev',
        apiSecret: 'test-secret-key-123',
        accountId: 'test-account-id',
      );
    });

    test('CloudflareConfig 鉴权头构建校验', () {
      expect(config.isValid, isTrue);
      final headers = config.authHeaders;
      expect(headers['X-API-SECRET'], equals('test-secret-key-123'));
      expect(headers['X-ACCOUNT-ID'], equals('test-account-id'));
    });

    test('CloudflareD1Client 查询模拟测试', () async {
      final mockClient = MockClient((request) async {
        expect(request.url.path, equals('/api/d1/query'));
        expect(request.headers['X-API-SECRET'], equals('test-secret-key-123'));
        return http.Response(
          jsonEncode({
            'results': [
              {'id': 1, 'name': 'test_rule'}
            ],
            'meta': {'changes': 1}
          }),
          200,
        );
      });

      final d1Client = CloudflareD1Client(config: config, httpClient: mockClient);
      final result = await d1Client.query('SELECT * FROM rules WHERE id = ?', [1]);

      expect(result.success, isTrue);
      expect(result.rows.length, equals(1));
      expect(result.rows.first['name'], equals('test_rule'));
      expect(result.rowsAffected, equals(1));
    });

    test('CloudflareR2Client 上传/下载模拟测试', () async {
      final mockClient = MockClient((request) async {
        if (request.method == 'PUT') {
          return http.Response('', 200);
        } else if (request.method == 'GET') {
          return http.Response.bytes(Uint8List.fromList([1, 2, 3, 4]), 200);
        }
        return http.Response('', 400);
      });

      final r2Client = CloudflareR2Client(config: config, httpClient: mockClient);
      final putOk = await r2Client.putObject('rule.json', Uint8List.fromList([1, 2, 3, 4]));
      expect(putOk, isTrue);

      final data = await r2Client.getObject('rule.json');
      expect(data, isNotNull);
      expect(data!.length, equals(4));
    });

    test('CloudflareKVClient 读写测试', () async {
      final mockClient = MockClient((request) async {
        if (request.method == 'PUT') {
          return http.Response('OK', 200);
        } else if (request.method == 'GET') {
          return http.Response('value_123', 200);
        }
        return http.Response('', 404);
      });

      final kvClient = CloudflareKVClient(config: config, httpClient: mockClient);
      final putOk = await kvClient.put('key1', 'value_123');
      expect(putOk, isTrue);

      final val = await kvClient.get('key1');
      expect(val, equals('value_123'));
    });

    test('CloudflareWorkerClient 自定义接口交互测试', () async {
      final mockClient = MockClient((request) async {
        return http.Response(jsonEncode({'status': 'ok'}), 200);
      });

      final workerClient = CloudflareWorkerClient(config: config, httpClient: mockClient);
      final res = await workerClient.post('/api/v1/custom', {'action': 'ping'});
      expect(res, isNotNull);
      expect(res!['status'], equals('ok'));
    });
  });
}
