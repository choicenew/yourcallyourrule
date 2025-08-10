import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/cloud_sync/services/cloud_sync_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/google_drive_sync_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/onedrive_sync_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/webdav_sync_service.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'device_management_provider.dart';





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

/// Provider for the currently active cloud sync service
final activeSyncServiceProvider = StateProvider<CloudSyncService?>((ref) => null);

/// Provider for cloud sync status
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