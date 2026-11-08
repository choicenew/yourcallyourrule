import 'package:test/test.dart';
import 'package:pyro_cloudflare/pyro_cloudflare.dart';
import 'package:pyro_supabase/pyro_supabase.dart';
import 'package:pyro_central_database_protocol/pyro_central_database_protocol.dart';
import 'package:pyro_central_database_hub/pyro_central_database_hub.dart';
import 'package:pyro_central_database/pyro_central_database.dart';

void main() {
  group('pyro_central_database 中央数据库驱动层单元测试', () {
    test('CloudflareCentralDbAdapter 初始化与接口调用测试', () async {
      const config = CloudflareConfig(
        workerUrl: 'https://central-worker.dev',
        apiSecret: 'secret_123',
        accountId: 'acc_123',
      );

      final adapter = CloudflareCentralDbAdapter(config: config);
      expect(adapter.moduleId, equals('cloudflare_d1_central'));

      final ok = await adapter.initialize();
      expect(ok, isTrue);

      CentralDatabaseHub.instance.register(adapter);
      expect(CentralDatabaseHub.instance.getAdapter('cloudflare_d1_central'), equals(adapter));
    });

    test('SupabaseCentralDbAdapter 初始化与接口调用测试', () async {
      const config = SupabaseConfig(
        supabaseUrl: 'https://central.supabase.co',
        anonKey: 'anon_123',
      );

      final adapter = SupabaseCentralDbAdapter(config: config);
      expect(adapter.moduleId, equals('supabase_central'));

      final ok = await adapter.initialize();
      expect(ok, isTrue);

      CentralDatabaseHub.instance.register(adapter);
      expect(CentralDatabaseHub.instance.getAdapter('supabase_central'), equals(adapter));
    });
  });
}
