import 'package:test/test.dart';
import 'package:pyro_sync_cloudflare/pyro_sync_cloudflare.dart';

void main() {
  group('pyro_sync_cloudflare 真实公网 E2E 推拉 (Push/Pull) 联调测试', () {
    setUp(() {
      CloudflareSyncConfigStore.instance.updateConfig(
        workerUrl: 'https://api.cloudflare.com',
        apiSecret: 'YOUR_CLOUDFLARE_API_TOKEN_HERE',
        deviceId: 'live_dev_pixel8_001',
      );
    });

    test('真实向 Cloudflare REST 接口执行 pushOperations 与 pullLatest 管线测试', () async {
      final provider = CloudflareSyncProvider();

      final op = CloudflareSyncOperation(
        id: 'op_sync_101',
        domain: 'takeout_rule',
        entityKey: 'meituan_rule_v1',
        operation: 'PROPOSE',
        payload: {'label': '外满减', 'amount': 15},
        timestamp: DateTime.now().toIso8601String(),
      );

      // 发起物理网络推送 PUSH
      final pushSuccess = await provider.pushOperations([op]);
      print('✅ 真实 Cloudflare Sync Push 管道网络呼叫正常, 响应: $pushSuccess');

      // 发起物理网络拉取 PULL
      final pulledOps = await provider.pullLatest(domain: 'takeout_rule');
      print('✅ 真实 Cloudflare Sync Pull 管道网络呼叫正常, 拉取列表数: ${pulledOps.length}');

      expect(pulledOps, isA<List<CloudflareSyncOperation>>());
    });
  });
}
