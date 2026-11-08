import 'package:test/test.dart';
import 'package:pyro_user_database_supabase/pyro_user_database_supabase.dart';

void main() {
  group('pyro_sync_supabase 真实 Supabase callRuleProject E2E 推拉 (Push/Pull) 联调测试', () {
    setUp(() {
      SupabaseSyncConfigStore.instance.updateConfig(
        supabaseUrl: 'https://wujjtdwsvweaotquafaf.supabase.co',
        anonKey:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind1amp0ZHdzdndlYW90cXVhZmFmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM1NTE3MjcsImV4cCI6MjA3OTEyNzcyN30.d7OqKmxZX8cYmq5lFyJfIqtIDYaCpT-YICFVVZU96Fg',
        serviceRoleKey:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind1amp0ZHdzdndlYW90cXVhZmFmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2MzU1MTcyNywiZXhwIjoyMDc5MTI3NzI3fQ.eT5Qb5dZjtpSQaNQxqLwcGhvjp_aW4V1ke2lmTwTooU',
      );
    });

    test('真实向 Supabase callRuleProject 执行 PULL 拉取管线', () async {
      final manager = SupabaseSyncManager();

      // 验证网络连通性
      final connected = await manager.testConnection();
      print('✅ 真实 Supabase callRuleProject 物理连接状态: $connected');
      expect(connected, isTrue);

      // 执行物理 PULL 查询
      final pulledData = await manager.pullChanges('central_public_entities');
      print('✅ 真实 Supabase PULL 管线数据拉取成功, 返回记录数: ${pulledData.length}');
      expect(pulledData, isA<List<Map<String, dynamic>>>());
    });
  });
}
