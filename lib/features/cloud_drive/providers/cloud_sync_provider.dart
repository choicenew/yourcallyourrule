import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_cloud_drive_ui/pyro_cloud_drive_ui.dart' show cloudDriveHubProvider;

export 'package:pyro_cloud_drive_ui/pyro_cloud_drive_ui.dart' show cloudDriveHubProvider;

part 'cloud_sync_provider.g.dart';

@Riverpod(keepAlive: true)
CloudDriveAdapter? activeCloudDriver(Ref ref) {
  final hub = ref.watch(cloudDriveHubProvider);
  return hub.currentDriver;
}

@Riverpod(keepAlive: true)
Future<Map<String, dynamic>> cloudSyncStatus(Ref ref) async {
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
}
