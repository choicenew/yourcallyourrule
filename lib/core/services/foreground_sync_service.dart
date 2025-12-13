import 'package:flutter/foundation.dart';

import 'package:yourcallyourrule/data/database/sync/incremental_sync_manager_remote_database.dart';
import 'package:yourcallyourrule/data/database/sync/sync_scheduler.dart';
import 'package:yourcallyourrule/features/auto_update/services/auto_update_service.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_sync_service.dart';

/// A service dedicated to performing a synchronization check when the app starts.
///
/// This acts as a reliable fallback for `Workmanager`, ensuring that data gets
/// synced even if background tasks are killed by the OS.
class ForegroundSyncService {
  final IncrementalSyncManager _syncManager;
  final SyncScheduler _syncScheduler;
  final CallLogSyncService _callLogSyncService;
  final AutoUpdateService _autoUpdateService;

  /// The interval for call log sync, matching the background service.
  static const Duration _callLogSyncInterval = Duration(hours: 1);
  DateTime? _lastCallLogSync;

  ForegroundSyncService({
    required IncrementalSyncManager syncManager,
    required SyncScheduler syncScheduler,
    required CallLogSyncService callLogSyncService,
    required AutoUpdateService autoUpdateService,
  })  : _syncManager = syncManager,
        _syncScheduler = syncScheduler,
        _callLogSyncService = callLogSyncService,
        _autoUpdateService = autoUpdateService;

  /// Checks if a sync is needed based on the schedule and performs it if required.
  ///
  /// This method is intended to be called once during application startup.
  Future<void> syncIfNeeded() async {
    debugPrint('ForegroundSyncService: syncIfNeeded called.');
    // Use the scheduler to determine if the time since the last sync has
    // exceeded the defined interval.
    if (await _syncScheduler.needsSync) {
      // If a sync is needed, trigger the incremental sync process.
      // We don't need to await this, as it can run in the background
      // without blocking the UI. Errors are handled within the manager.
    await  _syncManager.syncIncremental();
    debugPrint('✅ [测试模式] 同步执行完成 (检查上方是否有 Pushing/Applying 日志)');
  }

    // Check and trigger call log sync if needed.
    final now = DateTime.now();
    if (_lastCallLogSync == null || now.difference(_lastCallLogSync!) >= _callLogSyncInterval) {
      _callLogSyncService.syncSystemCallLogs();
      _lastCallLogSync = now;
    }

    // Check and trigger auto-update if needed.
    if (await _autoUpdateService.shouldUpdate()) {
      _autoUpdateService.updateAll();
    }
  }
}
