// 增量同步管理器，用于处理本地和远程数据库之间的增量同步
import 'dart:async';
import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../../core/services/api_service.dart';
import '../../core/services/device_id_service.dart';
import '../../data/datasources/remote/remote_number_datasource.dart';
import '../../data/models/sync/sync_record_model.dart';
import '../../data/repositories/config/config_repository.dart';
import './remote/remote_database_manager.dart';
// 增量同步管理器类
class IncrementalSyncManager {
  late RemoteNumberDataSource _dataSource;
  late ApiService _apiService;
  late DeviceIdService _deviceIdService;
  late ConfigRepository _configRepository;

  // A default constructor that doesn't require parameters.
  IncrementalSyncManager();

  /// Initializes the manager with necessary dependencies.
  /// In a real-world scenario, these would be resolved using a service locator
  /// like GetIt or Riverpod, but for now, we instantiate them directly.
  Future<void> initialize() async {
    final dbManager = RemoteDatabaseManagerImpl();
    _dataSource = RemoteNumberDataSource(dbManager);
    _configRepository = SharedPreferencesConfigRepository();
    _deviceIdService = DeviceIdService(_configRepository);
    _apiService = const ApiService();
  }

  /// Performs the incremental synchronization. This is the primary public method.
  Future<bool> syncIncremental() async {
    return await _performSync();
  }

  Future<bool> _performSync() async {
    try {
      // 1. Get device ID
      final deviceId = await _deviceIdService.getDeviceId();

      // 2. Get local pending changes
      final pendingOperations = await _dataSource.getLocalPendingOperations();

      if (pendingOperations.isNotEmpty) {
        // 3. Push local changes to the remote server
        final bool pushSuccess = await _apiService.pushChanges(
          changes: pendingOperations,
          deviceId: deviceId,
        );

        if (pushSuccess) {
          // 4. Clear the pushed operations from the local pending queue
          final operationIds = pendingOperations.map((op) => op['id'] as String).toList();
          await _dataSource.clearPendingOperations(operationIds);
        } else {
          // If push fails, abort the sync to try again later.
          // This prevents potential data inconsistencies.
          await _recordSync(false, 'Push failed', pendingOperations.length, 0);
          return false;
        }
      }

      // 5. Get the last sync timestamp from the local database
      final lastSyncTime = await _dataSource.getLastSyncTime();

      // 6. Fetch remote changes from the server since the last sync
      final remoteChanges = await _apiService.getChanges(
        since: lastSyncTime,
        deviceId: deviceId,
      );

      if (remoteChanges.isNotEmpty) {
        // 7. Apply remote changes to the local database
        await _dataSource.applyRemoteChanges(remoteChanges);
      }

      // 8. Record the successful sync
      await _recordSync(true, 'Sync successful', pendingOperations.length, remoteChanges.length);

      return true;
    } catch (e) {
      // 9. Record the failed sync
      await _recordSync(false, e.toString(), 0, 0);
      return false;
    }
  }

  Future<void> _recordSync(bool success, String? message, int pushedCount, int pulledCount) async {
    final syncRecord = SyncRecordModel(
      id: const Uuid().v4(),
      syncTime: DateTime.now(),
      status: success ? 'success' : 'failed',
      syncType: 'incremental',
      pushedRecordCount: pushedCount,
      pulledRecordCount: pulledCount,
      errorMessage: success ? null : message,
    );
    await _dataSource.insertSyncRecord(syncRecord);
  }
}