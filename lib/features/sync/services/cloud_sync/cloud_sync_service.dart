import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_cloud_drive_database/pyro_cloud_drive_database.dart';

part 'cloud_sync_service.g.dart';

/// 主 App 云盘同步与加密备份 Riverpod 适配服务 (CloudSyncService)
/// 100% 委托调配 packages/clouddrive/ 包组 (CloudDriveControlCenter & DeviceManagementService)
@Riverpod(keepAlive: true)
CloudSyncService cloudSyncService(Ref ref) {
  return CloudSyncService.instance;
}

class CloudSyncService {
  static final CloudSyncService instance = CloudSyncService._();

  CloudSyncService._();

  /// 开启全量增量同步
  Future<bool> startIncrementalSync() async {
    debugPrint('[CloudSyncService] 调起 pyro_cloud_drive_hub 云盘增量同步引擎');
    return await CloudDriveControlCenter.instance.triggerSync();
  }

  /// 获知设备管理服务实例
  DeviceManagementService get deviceManagementService => DeviceManagementService.instance;
}
