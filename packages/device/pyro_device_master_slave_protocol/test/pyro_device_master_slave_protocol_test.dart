import 'package:test/test.dart';
import 'package:pyro_device_master_slave_protocol/pyro_device_master_slave_protocol.dart';

void main() {
  group('pyro_device_master_slave_protocol 单元测试', () {
    test('DeviceNode 角色权限与数据库初始化规则校验', () {
      final masterNode = DeviceNode(
        deviceId: 'dev_A',
        deviceName: 'Phone A (Master)',
        role: DeviceRole.master,
        keysConfig: {'supabase_key': 'key_123'},
        lastHeartbeatTime: DateTime.now(),
      );

      final slaveNode = DeviceNode(
        deviceId: 'dev_B',
        deviceName: 'Tablet B (Slave)',
        role: DeviceRole.slave,
        keysConfig: {'supabase_key': 'key_123'}, // 密钥完备
        lastHeartbeatTime: DateTime.now(),
      );

      expect(masterNode.canInitializeDatabase, isTrue);
      expect(slaveNode.canInitializeDatabase, isFalse); // Slave 严禁重复初始化数据库
      expect(slaveNode.keysConfig['supabase_key'], equals('key_123')); // Key 一样不少
    });

    test('DeviceInterface 零物理依赖静态句柄与注入回调测试', () async {
      String? lastAction;
      Map<String, dynamic>? lastPayload;

      // 验证未注入 Handler 时静默无感返回 false
      final silentResult = await DeviceInterface.performDeviceOperation(
        action: 'register',
        payload: {'id': 'device_01'},
      );
      expect(silentResult, isFalse);

      // 装配层注入 Handler
      DeviceInterface.setDeviceHandler((action, payload) async {
        lastAction = action;
        lastPayload = payload;
        return true;
      });

      final successResult = await DeviceInterface.performDeviceOperation(
        action: 'register',
        payload: {'id': 'device_01', 'name': 'My Device'},
      );

      expect(successResult, isTrue);
      expect(lastAction, equals('register'));
      expect(lastPayload?['name'], equals('My Device'));
    });
  });
}
