import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/cloud_sync/services/cloud_sync_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/google_drive_sync_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/onedrive_sync_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/webdav_sync_service.dart';
import 'device_management_provider.dart';

// [无需修改] 
final webdavSyncServiceProvider = Provider<CloudSyncService>((ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return WebDAVSyncService(configRepository: configRepository, ref: ref);
});

final onedriveSyncServiceProvider = Provider<CloudSyncService>((ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return OneDriveSyncService(configRepository: configRepository, ref: ref);
});

final googleDriveSyncServiceProvider = Provider<CloudSyncService>((ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return GoogleDriveSyncService(configRepository: configRepository, ref: ref);
});

// [无需修改] 保持你原本最简单的 State 写法
class ActiveSyncServiceNotifier extends Notifier<CloudSyncService?> {
  @override
  CloudSyncService? build() {
    return null;
  }

  void setActiveService(CloudSyncService? service) {
    state = service;
  }
}

final activeSyncServiceProvider =
    NotifierProvider<ActiveSyncServiceNotifier, CloudSyncService?>(
  ActiveSyncServiceNotifier.new,
);

// [无需修改]
final cloudSyncStatusProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final activeService = ref.watch(activeSyncServiceProvider);
  if (activeService == null) {
    return {
      'connected': false,
      'service_type': 'none',
      'auto_sync_enabled': false,
    };
  }
  return activeService.getSyncStatus();
});

// [唯一修改的地方] 
// 逻辑非常简单：遍历时，看看 activeService 是不是当前这个服务，如果是，就用 activeService。
final allCloudSyncStatusProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  // 1. 拿到那个“唯一真神” (当前活跃且已连接的服务实例)
  final activeService = ref.watch(activeSyncServiceProvider);

  // 2. 拿到三个“默认替身” (用于占位和初始化)
  final defaultServices = [
    ref.watch(webdavSyncServiceProvider),
    ref.watch(onedriveSyncServiceProvider),
    ref.watch(googleDriveSyncServiceProvider),
  ];

  // 3. 【核心逻辑】: 遍历列表，并行获取状态
  // 逻辑只有一句话：如果 activeService 是当前这个类型的实例，就用 activeService，否则用默认的。
  final futures = defaultServices.map((service) {
    if (activeService != null && activeService.runtimeType == service.runtimeType) {
      // 发现 activeService 就是当前这个类型 (例如都是 GoogleDriveSyncService)
      // 直接使用 activeService 获取状态 (它肯定是 Connected)
      return activeService.getSyncStatus();
    }
    // 否则使用默认实例获取状态 (它肯定是 Disconnected)
    return service.getSyncStatus();
  });

  // 4. 等待所有结果并返回
  return Future.wait(futures);
});