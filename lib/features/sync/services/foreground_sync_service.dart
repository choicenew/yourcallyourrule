import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sync_scheduler.dart';
import 'app_sync_bridge_connector.dart';
import 'package:yourcallyourrule/data/database/remote/remote_database.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_sync_service.dart';
import 'package:yourcallyourrule/features/call_history/services/system_call_log_service.dart';
import 'package:yourcallyourrule/features/remote_filter/data/datasources/remote_number_datasource.dart';
import 'package:yourcallyourrule/features/auto_update/services/auto_update_service.dart';

final foregroundSyncServiceProvider = Provider<ForegroundSyncService>((ref) {
  final syncManager = ref.watch(appSyncBridgeConnectorProvider);
  final remoteDb = ref.watch(remoteDatabaseProvider);
  final remoteNumberDataSource = RemoteNumberDataSource(remoteDb);
  final syncScheduler = SyncScheduler(dataSource: remoteNumberDataSource);

  final systemCallLogService = ref.watch(systemCallLogServiceProvider);
  final callLogSyncService = CallLogSyncService(systemCallLogService);

  final autoUpdateService = ref.watch(autoUpdateServiceProvider);

  return ForegroundSyncService(
    syncManager: syncManager,
    syncScheduler: syncScheduler,
    callLogSyncService: callLogSyncService,
    autoUpdateService: autoUpdateService,
  );
});

class ForegroundSyncService {
  final AppSyncBridgeConnector _syncConnector;
  final SyncScheduler _syncScheduler;
  final CallLogSyncService _callLogSyncService;
  final AutoUpdateService _autoUpdateService;

  static const Duration _callLogSyncInterval = Duration(hours: 1);
  DateTime? _lastCallLogSync;

  ForegroundSyncService({
    required AppSyncBridgeConnector syncManager,
    required SyncScheduler syncScheduler,
    required CallLogSyncService callLogSyncService,
    required AutoUpdateService autoUpdateService,
  })  : _syncConnector = syncManager,
        _syncScheduler = syncScheduler,
        _callLogSyncService = callLogSyncService,
        _autoUpdateService = autoUpdateService;

  Future<void> syncIfNeeded() async {
    debugPrint('ForegroundSyncService: syncIfNeeded called.');

    if (await _syncScheduler.needsSync) {
      await _syncConnector.syncIncremental();
      debugPrint('[ForegroundSyncService] 同步增量执行完成');
    }

    final now = DateTime.now();
    if (_lastCallLogSync == null || now.difference(_lastCallLogSync!) >= _callLogSyncInterval) {
      await _callLogSyncService.syncSystemCallLogs();
      _lastCallLogSync = now;
    }

    if (await _autoUpdateService.shouldUpdate('rules')) {
      await _autoUpdateService.updateAll();
    }
  }
}
