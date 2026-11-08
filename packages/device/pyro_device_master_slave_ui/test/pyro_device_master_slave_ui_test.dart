import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pyro_device_master_slave_protocol/pyro_device_master_slave_protocol.dart';
import 'package:pyro_device_master_slave/pyro_device_master_slave.dart';
import 'package:pyro_device_master_slave_ui/pyro_device_master_slave_ui.dart';

void main() {
  testWidgets('DeviceMasterSlaveControlPanel 控制面板渲染与交互测试', (WidgetTester tester) async {
    final localNode = DeviceNode(
      deviceId: 'dev_test_1',
      deviceName: 'Test Phone',
      role: DeviceRole.master,
      keysConfig: {'cf_key': 'key_abc'},
      lastHeartbeatTime: DateTime.now(),
    );
    final manager = MasterSlaveManager(localNode: localNode);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DeviceMasterSlaveControlPanel(manager: manager),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('主从设备集群与初始化权限控制面板'), findsOneWidget);
    expect(find.textContaining('Test Phone'), findsWidgets);
    expect(find.textContaining('主设备 (Master) 允许进行全局数据库初始化'), findsOneWidget);
  });
}
