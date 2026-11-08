import 'package:test/test.dart';
import 'package:pyro_device_master_slave/pyro_device_master_slave.dart';

void main() {
  group('pyro_device_master_slave 物理基础包单元测试', () {
    test('DeviceNode JSON 序列化与反序列化测试', () {
      final now = DateTime.now();
      final node = DeviceNode(
        deviceId: 'dev_001',
        deviceName: 'Pixel 8',
        role: DeviceRole.master,
        ipAddress: '192.168.1.100',
        priority: 10,
        lastHeartbeatTime: now,
      );

      final json = node.toJson();
      expect(json['deviceId'], equals('dev_001'));
      expect(json['role'], equals('master'));

      final restored = DeviceNode.fromJson(json);
      expect(restored.deviceId, equals('dev_001'));
      expect(restored.role, equals(DeviceRole.master));
      expect(restored.priority, equals(10));
    });

    test('MasterSlaveElection 最高优先权重选主测试', () {
      final now = DateTime.now();
      final nodeA = DeviceNode(
        deviceId: 'dev_A',
        deviceName: 'Phone A',
        priority: 5,
        lastHeartbeatTime: now,
      );
      final nodeB = DeviceNode(
        deviceId: 'dev_B',
        deviceName: 'Tablet B',
        priority: 20, // 权重更高
        lastHeartbeatTime: now,
      );

      final electedMaster = MasterSlaveElection.electMaster([nodeA, nodeB]);
      expect(electedMaster, isNotNull);
      expect(electedMaster!.deviceId, equals('dev_B'));
      expect(electedMaster.isMaster, isTrue);
    });

    test('HeartbeatManager 心跳维持与超时剔除测试', () async {
      final heartbeatMgr = HeartbeatManager(
        localDeviceId: 'dev_local',
        timeoutThreshold: const Duration(milliseconds: 200),
      );

      final now = DateTime.now();
      final activeNode = DeviceNode(
        deviceId: 'dev_active',
        deviceName: 'Active Device',
        lastHeartbeatTime: now,
      );

      heartbeatMgr.receiveHeartbeat(activeNode);
      expect(heartbeatMgr.getActiveNodes().length, equals(1));

      // 等待超过 200ms 超时阈值
      await Future.delayed(const Duration(milliseconds: 300));

      final timedOut = heartbeatMgr.getTimedOutNodes();
      expect(timedOut.length, equals(1));
      expect(timedOut.first.deviceId, equals('dev_active'));
      expect(heartbeatMgr.getActiveNodes().isEmpty, isTrue);

      heartbeatMgr.dispose();
    });
  });
}
