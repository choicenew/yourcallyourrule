import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'local/local_database.dart';
import 'remote/remote_database.dart';
import '../../features/call_history/data/datasources/local_call_log_datasource.dart';
import '../../features/contacts/data/datasources/local_contact_datasource.dart';
import '../../features/labels/data/datasources/local_label_datasource.dart';
import '../../features/labels/data/datasources/local_label_mark_statistics_datasource.dart';
import '../../features/location/data/datasources/local_location_datasource.dart';
import '../../features/plugin/data/datasources/local_plugin_datasource.dart';
import '../../features/labels/data/datasources/local_predefined_label_datasource.dart';
import '../../features/rules/data/datasources/local_phone_rule_datasource.dart';
import '../../features/rules/data/datasources/local_regex_rule_datasource.dart';
import '../../features/rules/data/datasources/local_sim_slot_rule_datasource.dart';
import '../../features/sms/data/datasources/local_sms_regex_rule_datasource.dart';
import '../../features/phone/data/datasources/local_subscription_datasource.dart';
import '../../features/remote_filter/data/datasources/remote_number_datasource.dart';
import '../../features/sync/services/cloud_sync/incremental_sync_manager.dart';
import '../../features/sync/services/cloud_sync/sync_conflict_resolver.dart';
import '../../features/config/data/repositories/config_repository.dart';

part 'database_service.g.dart';

/// 数据库服务提供者
@Riverpod(keepAlive: true)
DatabaseService databaseService(Ref ref) {
  return DatabaseService();
}

// 数据库服务类
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  
  late final LocalDatabase localDatabase;
  late final RemoteDatabase remoteDatabase;
  
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
  late final LocalLabelMarkStatisticsDataSource localLabelMarkStatisticsDataSource;
  
  late final IncrementalSyncManager incrementalSyncManager;
  
  DatabaseService._internal() {
    localDatabase = LocalDatabase();
    remoteDatabase = RemoteDatabase();
    
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
    localLabelMarkStatisticsDataSource = LocalLabelMarkStatisticsDataSource(localDatabase);

    final configRepository = SharedPreferencesConfigRepository();

    incrementalSyncManager = IncrementalSyncManager(
      DefaultSyncConflictResolver(),
      configRepository: configRepository,
    );
  }
  
  factory DatabaseService() {
    return _instance;
  }
  
  Future<bool> syncRemoteToLocal() async {
    try {
      return true;
    } catch (e) {
      debugPrint('Sync failed: $e');
      return false;
    }
  }
}