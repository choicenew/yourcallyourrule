import 'package:test/test.dart';
import 'package:pyro_device_master_slave_protocol/pyro_device_master_slave_protocol.dart';
import 'package:pyro_device_master_slave_hub/pyro_device_master_slave_hub.dart';

class DummyMasterSlaveAdapter implements MasterSlaveAdapter {
  @override
  String get moduleId => 'dummy_master_slave';

  @override
  Future<DeviceNode> getLocalNode() async => DeviceNode(
        deviceId: 'local',
        deviceName: 'Local',
        role: DeviceRole.master,
        lastHeartbeatTime: DateTime.now(),
      );

  @override
  Future<List<DeviceNode>> getActiveClusterNodes() async => [];

  @override
  Future<bool> setDeviceRole(String deviceId, DeviceRole role) async => true;

  @override
  Future<bool> isDatabaseInitializationAllowed() async => true;

  @override
  Future<bool> initialize() async => true;
}

void main() {
  group('pyro_device_master_slave_hub 中枢单元测试', () {
    setUp(() {
      DeviceMasterSlaveHub.instance.clear();
    });

    test('DeviceMasterSlaveHub 适配器注册与路由', () {
      final hub = DeviceMasterSlaveHub.instance;
      final adapter = DummyMasterSlaveAdapter();

      hub.register(adapter);
      expect(hub.getAdapter('dummy_master_slave'), equals(adapter));
      expect(hub.allAdapters.length, equals(1));
    });
  });
}
