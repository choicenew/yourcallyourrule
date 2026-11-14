import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_device_master_slave_ui/pyro_device_master_slave_ui.dart';
import 'package:pyro_device_master_slave/pyro_device_master_slave.dart';
import 'package:pyro_device_master_slave_protocol/pyro_device_master_slave_protocol.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 设备集群与主从管理页面 —— 100% 渲染包内 pyro_device_master_slave_ui 自注册标准控制面板
class DeviceManagementPage extends ConsumerWidget {
  const DeviceManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = MasterSlaveManager(
      localNode: DeviceNode(
        deviceId: 'local_device_01',
        deviceName: 'Primary Phone Node',
        role: DeviceRole.master,
        lastHeartbeatTime: DateTime.now(),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).deviceManagementTitle,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SingleChildScrollView(
        child: DeviceMasterSlaveControlPanel(manager: manager),
      ),
    );
  }
}
