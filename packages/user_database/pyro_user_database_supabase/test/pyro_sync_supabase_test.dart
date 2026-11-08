import 'package:test/test.dart';
import 'package:pyro_user_database_supabase/pyro_user_database_supabase.dart';

void main() {
  group('pyro_sync_supabase 个人同步领域包单元测试', () {
    setUp(() {
      SupabaseSyncConfigStore.instance.updateConfig(
        supabaseUrl: 'https://wujjtdwsvweaotquafaf.supabase.co',
        anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.dummy_anon',
        serviceRoleKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.dummy_service',
      );
    });

    test('SupabaseSyncConfigStore 配置持有什么与导出测试', () {
      final store = SupabaseSyncConfigStore.instance;
      expect(store.isConfigured, isTrue);
      expect(store.supabaseUrl, equals('https://wujjtdwsvweaotquafaf.supabase.co'));
      expect(store.anonKey, equals('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.dummy_anon'));

      final infraConfig = store.toInfraConfig();
      expect(infraConfig.isValid, isTrue);
      expect(infraConfig.supabaseUrl, equals(store.supabaseUrl));
    });

    test('SupabaseSyncManager 初始化与基础方法调用测试', () {
      final manager = SupabaseSyncManager();
      expect(manager, isNotNull);
    });
  });
}
