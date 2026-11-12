import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';

/// 绑定 pyro_cloud_drive_hub 全局单例注册中心
final cloudDriveHubProvider = Provider<CloudDriveHub>((ref) {
  return CloudDriveHub.instance;
});

final activeCloudDriverProvider = Provider<CloudDriveAdapter?>((ref) {
  final hub = ref.watch(cloudDriveHubProvider);
  return hub.currentDriver;
});

final cloudSyncStatusProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final hub = ref.watch(cloudDriveHubProvider);
  final activeDriver = hub.currentDriver;
  if (activeDriver == null) {
    return {
      'connected': false,
      'service_type': 'none',
      'auto_sync_enabled': false,
    };
  }
  return {
    'connected': true,
    'service_type': activeDriver.driverToken.toString(),
    'auto_sync_enabled': true,
  };
});
