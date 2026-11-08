import 'dart:convert';
import 'dart:typed_data';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pyro_supabase/pyro_supabase.dart';

void main() {
  group('pyro_supabase 基础设施 Client 单元测试', () {
    late SupabaseConfig config;

    setUp(() {
      config = const SupabaseConfig(
        supabaseUrl: 'https://xyz.supabase.co',
        anonKey: 'anon-test-key-123',
      );
    });

    test('SupabaseConfig 统一配置校验', () {
      expect(config.isValid, isTrue);
      final headers = config.defaultHeaders;
      expect(headers['apikey'], equals('anon-test-key-123'));
      expect(headers['Authorization'], equals('Bearer anon-test-key-123'));
    });

    test('SupabaseDatabaseClient SELECT 与 INSERT 模拟测试', () async {
      final mockClient = MockClient((request) async {
        if (request.method == 'GET') {
          return http.Response(
            jsonEncode([
              {'id': 101, 'title': 'test_rule'}
            ]),
            200,
          );
        } else if (request.method == 'POST') {
          return http.Response('', 201);
        }
        return http.Response('', 400);
      });

      final dbClient = SupabaseDatabaseClient(config: config, httpClient: mockClient);
      final rows = await dbClient.select('rules');
      expect(rows.length, equals(1));
      expect(rows.first['title'], equals('test_rule'));

      final insertOk = await dbClient.insert('rules', {'title': 'new_rule'});
      expect(insertOk, isTrue);
    });

    test('SupabaseStorageClient 上传/下载模拟测试', () async {
      final mockClient = MockClient((request) async {
        if (request.method == 'POST') {
          return http.Response('', 200);
        } else if (request.method == 'GET') {
          return http.Response.bytes(Uint8List.fromList([10, 20, 30]), 200);
        }
        return http.Response('', 400);
      });

      final storageClient = SupabaseStorageClient(config: config, httpClient: mockClient);
      final uploadOk = await storageClient.upload('my-bucket', 'file.bin', Uint8List.fromList([10, 20, 30]));
      expect(uploadOk, isTrue);

      final downloaded = await storageClient.download('my-bucket', 'file.bin');
      expect(downloaded, isNotNull);
      expect(downloaded!.length, equals(3));
    });

    test('SupabaseRealtimeClient WebSocket URL 构建测试', () {
      final realtimeClient = SupabaseRealtimeClient(config: config);
      final wsUrl = realtimeClient.getRealtimeWebSocketUrl(topic: 'room_1');
      expect(wsUrl, contains('wss://xyz.supabase.co/realtime/v1/websocket'));
      expect(wsUrl, contains('apikey=anon-test-key-123'));
    });
  });
}
