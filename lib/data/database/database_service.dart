// 数据库服务类，用于管理数据库的初始化和提供数据源访问

import 'dart:async';


import 'package:flutter/foundation.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/data/database/remote/remote_database.dart';
import 'package:yourcallyourrule/data/datasources/local/local_call_log_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_contact_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_label_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_location_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_plugin_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_predefined_label_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_phone_rule_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_regex_rule_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_sim_slot_rule_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_sms_regex_rule_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_subscription_datasource.dart';
import 'package:yourcallyourrule/data/datasources/remote/remote_number_datasource.dart';
import 'sync/incremental_sync_manager_remote_database.dart';
import 'sync/api_service.dart';
import 'sync/device_id_service.dart';
import 'sync/sync_scheduler.dart';
import 'package:yourcallyourrule/features/sync_country/services/country_data_service.dart';
import 'package:yourcallyourrule/features/sync_country/services/country_selection_service.dart';
import 'package:yourcallyourrule/features/sync_country/services/download_status_service.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

// 数据库服务类
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  
  // Drift 数据库实例
  late final LocalDatabase localDatabase;
  late final RemoteDatabase remoteDatabase;
  
  // 数据源
  late final LocalContactDataSource localContactDataSource;
  late final LocalLabelDataSource localLabelDataSource;
  late final LocalPhoneRuleDataSource localPhoneRuleDataSource;
  late final LocalRegexRuleDataSource localRegexRuleDataSource;
  late final LocalCallLogDataSource localCallLogDataSource;
  late final LocalSmsRegexRuleDataSource localSmsRegexRuleDataSource;
  late final LocalSubscriptionDataSource localSubscriptionDataSource;
  late final LocalLocationDataSource localLocationDataSource;
  late final LocalPluginDataSource localPluginDataSource;
  late final RemoteNumberDataSource remoteNumberDataSource;
  late final LocalPredefinedLabelDataSource localPredefinedLabelDataSource;
  late final LocalSimSlotRuleDataSource localSimSlotRuleDataSource;
  
  late final IncrementalSyncManager incrementalSyncManager;
  
  // 私有构造函数
  DatabaseService._internal() {
    localDatabase = LocalDatabase();
    remoteDatabase = RemoteDatabase();
    
    // 初始化数据源
    localContactDataSource = LocalContactDataSource(localDatabase);
    localLabelDataSource = LocalLabelDataSource(localDatabase);
    localPhoneRuleDataSource = LocalPhoneRuleDataSource(localDatabase);
    localRegexRuleDataSource = LocalRegexRuleDataSource(localDatabase);
    localCallLogDataSource = LocalCallLogDataSource(localDatabase);
    localSmsRegexRuleDataSource = LocalSmsRegexRuleDataSource(localDatabase);
    localSubscriptionDataSource = LocalSubscriptionDataSource(localDatabase);
    localLocationDataSource = LocalLocationDataSource(localDatabase);
    localPluginDataSource = LocalPluginDataSource(localDatabase);
    remoteNumberDataSource = RemoteNumberDataSource(remoteDatabase);
    localPredefinedLabelDataSource = LocalPredefinedLabelDataSource(localDatabase);
    localSimSlotRuleDataSource = LocalSimSlotRuleDataSource(localDatabase);

    final configRepository = SharedPreferencesConfigRepository();
    final apiService = ApiService();
    final deviceIdService = DeviceIdService(configRepository);
    final syncScheduler = SyncScheduler(dataSource: remoteNumberDataSource);
    final countryDataService = CountryDataService(apiService: apiService, remoteNumberDataSource: remoteNumberDataSource);
    final countrySelectionService = CountrySelectionService(configRepository);
    final downloadStatusService = DownloadStatusService(configRepository);

    incrementalSyncManager = IncrementalSyncManager(
      dataSource: remoteNumberDataSource,
      apiService: apiService,
      deviceIdService: deviceIdService,
      syncScheduler: syncScheduler,
      countryDataService: countryDataService,
      countrySelectionService: countrySelectionService,
      downloadStatusService: downloadStatusService,
    );
  }
  
  // 工厂构造函数
  factory DatabaseService() {
    return _instance;
  }
  
  // 同步远程数据到本地
  Future<bool> syncRemoteToLocal() async {
    try {
      return await incrementalSyncManager.syncIncremental();
    } catch (e) {
      debugPrint('Sync failed: $e');
      return false;
    }
  }
}