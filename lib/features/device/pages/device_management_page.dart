import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_device_master_slave_ui/pyro_device_master_slave_ui.dart' hide AppLocalizations;
import 'package:pyro_device_master_slave/pyro_device_master_slave.dart';
import 'package:pyro_device_master_slave_protocol/pyro_device_master_slave_protocol.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 设备集群管理页面 —— 100% 渲染包内自注册标准控制面板，100% 接入标准 AppLocalizations
class DeviceManagementPage extends ConsumerWidget {
  const DeviceManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final manager = DeviceClusterManager(
      localNode: DeviceNode(
        deviceId: 'local_device_01',
        deviceName: '${l10n.currentDeviceTitle} (${l10n.masterRoleTitle})',
        role: DeviceRole.primary,
        lastHeartbeatTime: DateTime.now(),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          l10n.deviceManagementTitle,
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
        child: DeviceClusterControlPanel(manager: manager),
      ),
    );
  }
}
