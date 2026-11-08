import 'package:test/test.dart';
import 'package:pyro_user_database_cloudflare/pyro_user_database_cloudflare.dart';

void main() {
  group('pyro_sync_cloudflare 个人同步领域包单元测试', () {
    setUp(() {
      CloudflareSyncConfigStore.instance.updateConfig(
        workerUrl: 'https://my-test-worker.workers.dev',
        apiSecret: 'my-secret-key-999',
        deviceId: 'dev_pixel_test',
      );
    });

    test('CloudflareSyncConfigStore 配置更新与持有测试', () {
      final store = CloudflareSyncConfigStore.instance;
      expect(store.isConfigured, isTrue);
      expect(store.workerUrl, equals('https://my-test-worker.workers.dev'));
      expect(store.apiSecret, equals('my-secret-key-999'));
      expect(store.deviceId, equals('dev_pixel_test'));
    });

    test('CloudflareSyncOperation 序列化与反序列化测试', () {
      final op = CloudflareSyncOperation(
        id: 'op_1001',
        domain: 'takeout_rule',
        entityKey: 'meituan_rule_v1',
        operation: 'PROPOSE',
        payload: {'priority': 10, 'label': '外卖免单'},
        timestamp: '2026-10-20T12:00:00Z',
      );

      final json = op.toJson();
      expect(json['id'], equals('op_1001'));
      expect(json['domain'], equals('takeout_rule'));
      expect(json['operation'], equals('PROPOSE'));

      final restored = CloudflareSyncOperation.fromJson(json);
      expect(restored.id, equals('op_1001'));
      expect(restored.payload['label'], equals('外卖免单'));
    });

    test('CloudflareSyncProvider 初始化与基础设施底层 Client 调用测试', () async {
      final provider = CloudflareSyncProvider();
      final initialized = await provider.initialize();
      expect(initialized, isTrue);
      expect(provider.moduleId, equals('cloudflare_kv'));
    });
  });
}
