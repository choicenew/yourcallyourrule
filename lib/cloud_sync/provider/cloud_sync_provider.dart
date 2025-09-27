import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/cloud_sync/services/cloud_sync_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/google_drive_sync_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/onedrive_sync_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/webdav_sync_service.dart';
import 'device_management_provider.dart';

// [无需修改] - Provider 的定义保持不变
/// Provider for WebDAV sync service
final webdavSyncServiceProvider = Provider<CloudSyncService>((ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return WebDAVSyncService(configRepository: configRepository, ref: ref);
});

/// Provider for OneDrive sync service
final onedriveSyncServiceProvider = Provider<CloudSyncService>((ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return OneDriveSyncService(configRepository: configRepository, ref: ref);
});

/// Provider for Google Drive sync service
final googleDriveSyncServiceProvider = Provider<CloudSyncService>((ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return GoogleDriveSyncService(configRepository: configRepository, ref: ref);
});


// [已修改] - 从 StateProvider 迁移到 NotifierProvider
// 步骤 1: 创建 Notifier 类来管理状态
class ActiveSyncServiceNotifier extends Notifier<CloudSyncService?> {
  @override
  CloudSyncService? build() {
    // 返回初始状态
    return null;
  }

  // 提供一个公共方法来更新状态
  void setActiveService(CloudSyncService? service) {
    state = service;
  }
}

// 步骤 2: 定义 NotifierProvider
final activeSyncServiceProvider =
    NotifierProvider<ActiveSyncServiceNotifier, CloudSyncService?>(
  ActiveSyncServiceNotifier.new,
);


// [无需修改] - FutureProvider 的定义和使用方式保持不变
// 它会正确地监听 activeSyncServiceProvider 的状态变化
/// Provider for cloud sync status
final cloudSyncStatusProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final activeService = ref.watch(activeSyncServiceProvider); // <- 读取方式不变
  if (activeService == null) {
    return {
      'connected': false,
      'service_type': 'none',
      'auto_sync_enabled': false,
    };
  }
  
  return activeService.getSyncStatus();
});

// [无需修改] - FutureProvider 的定义保持不变
/// Provider for cloud sync status of all services
final allCloudSyncStatusProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final services = [
    ref.watch(webdavSyncServiceProvider),
    ref.watch(onedriveSyncServiceProvider),
    ref.watch(googleDriveSyncServiceProvider),
  ];

  final statuses = <Map<String, dynamic>>[];
  for (final service in services) {
    try {
      final status = await service.getSyncStatus();
      statuses.add(status);
    } catch (e) {
      // Handle case where a service might fail to get status
      statuses.add({
        'service_type': service.runtimeType.toString().replaceAll('SyncService', ''),
        'connected': false,
        'online': false,
        'error': e.toString(),
      });
    }
  }

  return statuses;
});