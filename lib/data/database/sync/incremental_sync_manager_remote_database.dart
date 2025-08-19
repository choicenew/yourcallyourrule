// 增量同步管理器，用于处理本地和远程数据库之间的增量同步
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'package:yourcallyourrule/data/database/sync/device_id_service.dart';
import 'package:yourcallyourrule/data/database/sync/sync_scheduler.dart';

import 'package:yourcallyourrule/features/sync_country/services/country_data_service.dart';
import 'package:yourcallyourrule/features/sync_country/services/country_selection_service.dart';
import 'package:yourcallyourrule/features/sync_country/services/download_status_service.dart';

import 'api_service.dart';


import '../../datasources/remote/remote_number_datasource.dart';
import '../../models/sync/sync_record_model.dart';
import '../../repositories/config/config_repository.dart';
import '../remote/remote_database_manager.dart';
// 增量同步管理器类
class IncrementalSyncManager {
  late RemoteNumberDataSource _dataSource;
  late ApiService _apiService;
  late DeviceIdService _deviceIdService;
  late SyncScheduler _syncScheduler;
  late CountryDataService _countryDataService;
  late ConfigRepository _configRepository;
  late CountrySelectionService _countrySelectionService;
  // 新增下载状态服务
  late DownloadStatusService _downloadStatusService;

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
    _syncScheduler = SyncScheduler(dataSource: _dataSource);
    _countrySelectionService = CountrySelectionService(_configRepository);
    // 初始化下载状态服务
    _downloadStatusService = DownloadStatusService(_configRepository);
    _countryDataService = CountryDataService(
      apiService: _apiService,
      remoteNumberDataSource: _dataSource,
    );
  }

  /// Performs the incremental synchronization. This is the primary public method.
  Future<bool> syncIncremental() async {
    if (await _syncScheduler.needsSync) {
      return await _performSync();
    }
    // If sync is not needed, we can consider it a "success" for the background task.
    return true;
  }

  Future<bool> _performSync() async {
    try {
      // --- 阶段 0: 对比"用户选择"和"下载状态"，执行全量操作 ---
      // 1. 获取用户【想要】的国家 和【已经下载】的国家
      final selectedCountries = (await _countrySelectionService.getSelectedCountryDialCodes()).toSet();
      final downloadedCountries = (await _downloadStatusService.getDownloadedCountries()).toSet();

      // 2. 计算需要【新增下载】的国家
      final countriesToDownload = selectedCountries.difference(downloadedCountries);
      for (final countryCode in countriesToDownload) {
        // [核心逻辑] 下载数据，下载成功后，才更新状态
        final downloadedCount = await _countryDataService.downloadCountryData(countryCode);
        if (downloadedCount > 0) {
          await _downloadStatusService.markAsDownloaded(countryCode);
        }
      }

      // 3. 计算需要【删除数据】的国家
      final countriesToRemove = downloadedCountries.difference(selectedCountries);
      for (final countryCode in countriesToRemove) {
        // [核心逻辑] 删除数据，删除成功后，才更新状态
        final removedCount = await _countryDataService.removeCountryData(countryCode);
        if (removedCount > 0) {
          await _downloadStatusService.unmarkAsDownloaded(countryCode);
        }
      }

      // --- 阶段 1 & 2: 执行常规的推拉增量同步 ---
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

      // 6. 使用最新的用户选择作为同步国家列表
      final List<String> syncCountries = selectedCountries.toList();

      // 7. Fetch remote changes from the server since the last sync
      final remoteChanges = await _apiService.getChanges(
        since: lastSyncTime,
        deviceId: deviceId,
        countryCodes: syncCountries,
      );

      if (remoteChanges.isNotEmpty) {
        // 8. Apply remote changes to the local database
        await _dataSource.applyRemoteChanges(remoteChanges);
      }

      // 9. Record the successful sync
      await _recordSync(true, 'Sync successful', pendingOperations.length, remoteChanges.length);

      return true;
    } catch (e) {
      // 10. Record the failed sync
      await _recordSync(false, e.toString(), 0, 0);
      return false;
    }
  }
  
  /// 下载特定国家的数据
  /// 
  /// [countryCode] 国家的拨号代码，例如 '+86'
  /// 返回下载的数据条数
  Future<int> downloadCountryData(String countryCode) async {
    try {
      return await _countryDataService.downloadCountryData(countryCode);
    } catch (e) {
      debugPrint('Error downloading country data: $e');
      return 0;
    }
  }

  /// 移除特定国家的数据
  /// 
  /// [countryCode] 国家的拨号代码，例如 '+86'
  /// 返回删除的数据条数
  Future<int> removeCountryData(String countryCode) async {
    try {
      return await _countryDataService.removeCountryData(countryCode);
    } catch (e) {
      debugPrint('Error removing country data: $e');
      return 0;
    }
  }

  /// 获取当前同步的国家列表
  Future<List<String>> getSyncCountries() async {
    return await _countrySelectionService.getSelectedCountryDialCodes();
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