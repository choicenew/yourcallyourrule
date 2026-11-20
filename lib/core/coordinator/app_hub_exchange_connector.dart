import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_user_database_hub/pyro_user_database_hub.dart';
import 'package:pyro_central_database_hub/pyro_central_database_hub.dart';
import 'package:pyro_device_master_slave_hub/pyro_device_master_slave_hub.dart';
import 'package:pyro_sync_hub/pyro_sync_hub.dart';
import 'package:pyro_crowdsourcing_arbiter/pyro_crowdsourcing_arbiter.dart';

import 'package:pyro_phone_count_filter_connector/pyro_phone_count_filter_connector.dart';
import 'package:pyro_phone_remote_filter_connector/pyro_phone_remote_filter_connector.dart';
import 'package:pyro_phone_time_interceptor_connector/pyro_phone_time_interceptor_connector.dart';
import 'package:pyro_phone_sim_slot_rules_connector/pyro_phone_sim_slot_rules_connector.dart';
import 'package:pyro_phone_rules_connector/pyro_phone_rules_connector.dart';
import 'package:pyro_call_redirection_connector/pyro_call_redirection_connector.dart';
import 'package:pyro_tile_connector/pyro_tile_connector.dart';

import 'app_coordinator.dart';
import 'filter_ui_registry.dart';
import 'package:yourcallyourrule/features/cloud_drive/providers/cloud_sync_provider.dart';
import 'connectors/crowdsourcing_exchange_connector.dart';
import 'connectors/database_sync_exchange_connector.dart';
import 'connectors/notification_exchange_connector.dart';
import 'connectors/telephony_policy_exchange_connector.dart';

export 'connectors/crowdsourcing_exchange_connector.dart';
export 'connectors/database_sync_exchange_connector.dart';
export 'connectors/notification_exchange_connector.dart';
export 'connectors/sms_exchange_connector.dart';
export 'connectors/telephony_policy_exchange_connector.dart';

final appHubExchangeConnectorProvider = Provider<AppHubExchangeConnector>((ref) {
  final coordinator = ref.watch(appCoordinatorProvider);
  final databaseSync = DatabaseSyncExchangeConnector(
    ref: ref,
    coordinator: coordinator,
    centralDatabaseHub: ref.watch(centralDatabaseHubProvider),
    userDatabaseHub: ref.watch(userDatabaseHubProvider),
    cloudDriveHub: ref.watch(cloudDriveHubProvider),
    deviceMasterSlaveHub: ref.watch(deviceMasterSlaveHubProvider),
    syncHub: ref.watch(syncHubProvider),
  );
  final crowdsourcing = CrowdsourcingExchangeConnector(
    coordinator: coordinator,
    arbiter: ref.watch(crowdsourcingArbiterProvider),
  );
  final notification = NotificationExchangeConnector(
    ref: ref,
    coordinator: coordinator,
  );
  final telephonyPolicy = TelephonyPolicyExchangeConnector(ref: ref);

  return AppHubExchangeConnector(
    ref: ref,
    coordinator: coordinator,
    databaseSync: databaseSync,
    crowdsourcing: crowdsourcing,
    notification: notification,
    telephonyPolicy: telephonyPolicy,
  )..initializeConnectorBridge();
});

/// 应用微包中枢全量数据流转与协同连接器 (AppHubExchangeConnector)
/// 负责在主 App 中作为星型总机，组合调度数据库、众包、通知、电话策略等各领域子连接器
class AppHubExchangeConnector {
  final Ref ref;
  final AppCoordinator coordinator;
  final DatabaseSyncExchangeConnector databaseSync;
  final CrowdsourcingExchangeConnector crowdsourcing;
  final NotificationExchangeConnector notification;
  final TelephonyPolicyExchangeConnector telephonyPolicy;

  const AppHubExchangeConnector({
    required this.ref,
    required this.coordinator,
    required this.databaseSync,
    required this.crowdsourcing,
    required this.notification,
    required this.telephonyPolicy,
  });

  CentralDatabaseHub get centralDatabaseHub => databaseSync.centralDatabaseHub;
  UserDatabaseHub get userDatabaseHub => databaseSync.userDatabaseHub;
  CloudDriveHub get cloudDriveHub => databaseSync.cloudDriveHub;
  DeviceMasterSlaveHub get deviceMasterSlaveHub => databaseSync.deviceMasterSlaveHub;
  SyncHub get syncHub => databaseSync.syncHub;
  CrowdsourcingArbiterService get crowdsourcingArbiter => crowdsourcing.arbiter;

  /// 初始化全量中枢交织桥接管道
  void initializeConnectorBridge() {
    debugPrint('[AppHubExchangeConnector] Wiring Exchange Bridges across domain connectors...');
    databaseSync.initialize();
    crowdsourcing.initialize();
    telephonyPolicy.initialize();
    notification.initialize();
    _registerAllFilterConnectors();
  }

  void _registerAllFilterConnectors() {
    try {
      PyroPhoneRulesConnector.registerAll();
      PyroPhoneCountFilterConnector.registerAll();
      PyroPhoneRemoteFilterConnector.registerAll();
      PyroTimeInterceptorConnector.registerAll();
      SimSlotRuleConnector.registerAll();
      CallRedirectionConnectors.ensureMounted();
      TileConnectors.ensureMounted();

      // 注册主 App 胶水层 Filter UI 动态注册工厂
      FilterUiRegistry.init();

      debugPrint('[AppHubExchangeConnector] All Filter Connectors registered successfully.');
    } catch (e) {
      debugPrint('[AppHubExchangeConnector] Error registering Filter Connectors: $e');
    }
  }

  /// 执行本地个人库 (Local User DB) 同步
  Future<bool> syncUserDatabase() => databaseSync.syncUserDatabase();

  /// 执行远程中央库 (Remote Central DB) 同步拉取
  Future<bool> syncCentralDatabase({String countryIsoCode = ''}) =>
      databaseSync.syncCentralDatabase(countryIsoCode: countryIsoCode);

  /// 广播执行本地个人库 (Local User DB) 与 远程中央库 (Remote Central DB) 双流同步
  Future<bool> triggerFullSystemSync({String countryIsoCode = ''}) =>
      databaseSync.triggerFullSystemSync(countryIsoCode: countryIsoCode);
}
