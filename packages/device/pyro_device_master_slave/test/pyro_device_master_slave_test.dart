import 'package:test/test.dart';
import 'package:pyro_device_master_slave_protocol/pyro_device_master_slave_protocol.dart';
import 'package:pyro_device_master_slave_hub/pyro_device_master_slave_hub.dart';
import 'package:pyro_device_master_slave/pyro_device_master_slave.dart';

void main() {
  group('pyro_device_master_slave 驱动层单元测试', () {
    late MasterSlaveManager manager;

    setUp(() {
      final localNode = DeviceNode(
        deviceId: 'dev_local_101',
        deviceName: 'Pixel 8',
        role: DeviceRole.master,
        keysConfig: {'cf_secret': 'cf_123', 'supa_key': 'supa_123'},
        lastHeartbeatTime: DateTime.now(),
      );
      manager = MasterSlaveManager(localNode: localNode);
      DeviceMasterSlaveHub.instance.register(manager);
    });

    test('初始节点数据库初始化权限检查测试', () async {
      final allowed = await manager.isDatabaseInitializationAllowed();
      expect(allowed, isTrue); // Master 节点允许初始化
    });

    test('切换本机角色为 Slave 并管制禁止重复初始化数据库', () async {
      final ok = await manager.setDeviceRole('dev_local_101', DeviceRole.slave);
      expect(ok, isTrue);

      final allowed = await manager.isDatabaseInitializationAllowed();
      expect(allowed, isFalse); // Slave 节点严格禁止重复初始化数据库！

      final node = await manager.getLocalNode();
      expect(node.role, equals(DeviceRole.slave));
      expect(node.keysConfig['supa_key'], equals('supa_123')); // 密钥等配置一样不少
    });
  });
}
