import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/cloud_sync/services/cloud_sync_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/google_drive_sync_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/onedrive_sync_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/webdav_sync_service.dart';





/// Provider for WebDAV sync service
final webdavSyncServiceProvider = Provider<CloudSyncService>((ref) {
  return WebDAVSyncService();
});

/// Provider for OneDrive sync service
final onedriveSyncServiceProvider = Provider<CloudSyncService>((ref) {
  return OneDriveSyncService();
});

/// Provider for Google Drive sync service
final googleDriveSyncServiceProvider = Provider<CloudSyncService>((ref) {
  return GoogleDriveSyncService();
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