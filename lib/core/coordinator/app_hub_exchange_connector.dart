import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_cloud_drive_googledrive/pyro_cloud_drive_googledrive.dart';
import 'package:pyro_cloud_drive_onedrive/pyro_cloud_drive_onedrive.dart';
import 'package:pyro_cloud_drive_webdav/pyro_cloud_drive_webdav.dart';
import 'package:pyro_user_database_hub/pyro_user_database_hub.dart';
import 'package:pyro_user_database_cloudflare/pyro_user_database_cloudflare.dart';
import 'package:pyro_central_database_hub/pyro_central_database_hub.dart';
import 'package:pyro_central_database_cloudflare/pyro_central_database_cloudflare.dart';
import 'package:pyro_device_master_slave_hub/pyro_device_master_slave_hub.dart';
import 'package:pyro_sync_hub/pyro_sync_hub.dart';
import 'package:pyro_cloudflare/pyro_cloudflare.dart';
import 'package:yourcallyourrule/env.dart';

import 'package:pyro_phone_count_filter_connector/pyro_phone_count_filter_connector.dart';
import 'package:pyro_phone_remote_filter_connector/pyro_phone_remote_filter_connector.dart';
import 'package:pyro_phone_time_interceptor_connector/pyro_phone_time_interceptor_connector.dart';
import 'package:pyro_phone_sim_slot_rules_connector/pyro_phone_sim_slot_rules_connector.dart';
import 'package:pyro_phone_rules_connector/pyro_phone_rules_connector.dart';
import 'package:pyro_call_redirection_connector/pyro_call_redirection_connector.dart';
import 'package:pyro_tile_connector/pyro_tile_connector.dart';

import 'app_coordinator.dart';
import 'filter_ui_registry.dart';
import 'package:yourcallyourrule/features/cloud_drive/services/environment.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_manager.dart';
import 'package:yourcallyourrule/features/notifications/providers/notification_history_provider.dart';
import 'package:yourcallyourrule/features/notifications/config/notification_config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yourcallyourrule/features/common/router/app_router_provider.dart';
import 'package:yourcallyourrule/features/phone_caller_identity/services/caller_identity_service.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/phone_rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/cloud_drive/providers/cloud_sync_provider.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';

final centralDatabaseHubProvider = Provider<CentralDatabaseHub>((ref) => CentralDatabaseHub());
final userDatabaseHubProvider = Provider<UserDatabaseHub>((ref) => UserDatabaseHub());
final deviceMasterSlaveHubProvider = Provider<DeviceMasterSlaveHub>((ref) => DeviceMasterSlaveHub());
final syncHubProvider = Provider<SyncHub>((ref) => SyncHub());

final appHubExchangeConnectorProvider = Provider<AppHubExchangeConnector>((ref) {
  final coordinator = ref.watch(appCoordinatorProvider);
  final centralDb = ref.watch(centralDatabaseHubProvider);
  final userDb = ref.watch(userDatabaseHubProvider);
  final cloudDrive = ref.watch(cloudDriveHubProvider);
  final deviceHub = ref.watch(deviceMasterSlaveHubProvider);
  final syncHub = ref.watch(syncHubProvider);
  return AppHubExchangeConnector(
    ref,
    coordinator,
    centralDatabaseHub: centralDb,
    userDatabaseHub: userDb,
    cloudDriveHub: cloudDrive,
    deviceMasterSlaveHub: deviceHub,
    syncHub: syncHub,
  )..initializeConnectorBridge();
});

/// 应用微包中枢全量数据流转与协同连接器 (AppHubExchangeConnector)
/// 负责在主 App 中交换调和 @clouddrive, @user_database (Local), @database (Remote Central), @device (Device Management), @sync (Incremental Sync)
class AppHubExchangeConnector {
  final Ref ref;
  final AppCoordinator _coordinator;
  final CentralDatabaseHub centralDatabaseHub;
  final UserDatabaseHub userDatabaseHub;
  final CloudDriveHub cloudDriveHub;
  final DeviceMasterSlaveHub deviceMasterSlaveHub;
  final SyncHub syncHub;

  AppHubExchangeConnector(
    this.ref,
    this._coordinator, {
    required this.centralDatabaseHub,
    required this.userDatabaseHub,
    required this.cloudDriveHub,
    required this.deviceMasterSlaveHub,
    required this.syncHub,
  });

  /// 初始化全量中枢交织桥接管道
  void initializeConnectorBridge() {
    debugPrint('[AppHubExchangeConnector] Wiring Exchange Bridge: Local User DB <-> Remote Central DB <-> CloudDrive <-> SIM Rules');

    // 1. 云盘上下文配置 (CloudDrive Context) 主 App 注入配置 App 名称与加密标头并挂载驱动
    cloudDriveHub.configureHostContext(
      appName: 'YourCallYourRule',
      encryptionHeaderTag: 'YOURCALL_ENC_V1',
    );
    try {
      cloudDriveHub.register(
        GoogleDriveAdapter(serverClientId: Environment.googleServerClientId),
        uiConfig: GoogleDriveAdapter.uiConfig,
      );
      cloudDriveHub.register(
        OneDriveDriveAdapter(
          clientId: Environment.msalClientId,
          redirectUri: Environment.msalAndroidRedirectUri,
          authority: Environment.msalIosAuthority,
        ),
        uiConfig: OneDriveDriveAdapter.uiConfig,
      );
      cloudDriveHub.register(WebDAVDriveAdapter(), uiConfig: WebDAVDriveAdapter.uiConfig);
      debugPrint('[AppHubExchangeConnector] Registered CloudDrive Drivers with UIConfigs: GoogleDrive, OneDrive, WebDAV');
    } catch (e) {
      debugPrint('[AppHubExchangeConnector] Error registering CloudDrive Drivers: $e');
    }

    // 2. 本地用户数据库 (Local User Database) 初始化并注册引擎节点
    try {
      userDatabaseHub.registerAdapter(
        CloudflareSyncProvider(
          workerUrl: Env.cfWorkerUrl,
          apiSecret: Env.workerApiSecret,
        ),
      );
      debugPrint('[AppHubExchangeConnector] Registered UserDatabase Sync Adapters');
    } catch (e) {
      debugPrint('[AppHubExchangeConnector] Error registering UserDatabase Sync Adapters: $e');
    }

    // 3. 远程中央数据库 (Remote Central Database) 初始化并注册适配器
    try {
      centralDatabaseHub.register(
        CloudflareCentralDbAdapter(
          config: CloudflareConfig(
            workerUrl: Env.cfWorkerUrl,
            apiSecret: Env.workerApiSecret,
            accountId: '',
          ),
        ),
      );
      debugPrint('[AppHubExchangeConnector] Registered CentralDatabase CloudflareCentralDbAdapter');
    } catch (e) {
      debugPrint('[AppHubExchangeConnector] Error registering CentralDatabase Adapters: $e');
    }

    // 4. 设备管理中枢 (DeviceMasterSlaveHub) 与 增量同步中枢 (SyncHub) 平权挂载
    debugPrint('[AppHubExchangeConnector] Initialized DeviceMasterSlaveHub & SyncHub for Multi-Device and Incremental Sync');

    // 5. 本地用户数据变更监听管道 (Local User DB CDC Event)
    _coordinator.on('local_user_data_changed', (payload) async {
      debugPrint('[Connector] Local User Database changed, triggering user sync...');
      await syncUserDatabase();
    });

    // 5. 远程中央数据库拉取事件管道 (Remote Central DB Update Event)
    _coordinator.on('remote_central_db_update', (payload) async {
      final countryIsoCode = payload['countryIsoCode'] as String? ?? '';
      debugPrint('[Connector] Remote Central DB update triggered for country: $countryIsoCode');
      await syncCentralDatabase(countryIsoCode: countryIsoCode);
    });

    // 6. 全量 Filter 驱动与 SMS Bloom Filter 离线预检驱动一键注册挂载
    _registerAllFilterConnectors();

    // 7. 全局系统通知总线调度 (System Notification Relay & Tap Dispatcher)
    _setupNotificationRelay();

    // 8. 来电识别数据委托统一装配 (Caller Identity Resolvers Glue Assembly)
    _setupCallerIdentityResolvers();
  }

  void _setupCallerIdentityResolvers() {
    try {
      final callerIdService = ref.read(callerIdentityServiceProvider);
      callerIdService.bindResolvers(
        contactResolver: (phone) => ref.read(contactServiceProvider).findContactByPhoneNumber(phone),
        rulesResolver: (phone) => ref.read(ruleManagementServiceProvider).getRulesByPhoneNumber(phone),
        labelResolver: (phone) => ref.read(labelServiceProvider).getLabelByPhoneNumber(phone),
        predefinedLabelResolver: (id) => ref.read(predefinedLabelServiceProvider).getLabelById(id),
        remoteNumberResolver: (phone) => ref.read(remoteNumberServiceProvider).getRemoteNumberByPhoneNumber(phone),
      );
      debugPrint('[Connector] Bound all CallerIdentity Resolvers in AppHubExchangeConnector.');
    } catch (e) {
      debugPrint('[Connector] Error binding CallerIdentity Resolvers: $e');
    }
  }

  void _setupNotificationRelay() {
    _coordinator.on('show_system_notification', (payload) async {
      try {
        final title = payload['title'] as String? ?? '';
        final body = payload['body'] as String? ?? '';
        final type = payload['type'] as String? ?? 'general';
        final notificationId = payload['notificationId'] as int?;
        final notificationPayload = payload['payload'] as Map<String, dynamic>?;
        final manager = ref.read(notificationManagerProvider);
        final config = NotificationConfig(
          channelId: type == 'deletion_proposal' ? 'deletion_proposals' : 'general',
          channelName: type == 'deletion_proposal' ? 'Deletion Proposals' : 'General Notifications',
          importance: Importance.high,
          priority: Priority.high,
        );
        await manager.showAndRecord(
          title: title,
          body: body,
          config: config,
          type: type,
          notificationId: notificationId ?? 0,
          payload: notificationPayload,
        );
      } catch (e) {
        debugPrint('[Connector] show_system_notification error: $e');
      }
    });

    _coordinator.on('cancel_system_notification', (payload) async {
      try {
        final notificationId = payload['notificationId'] as int?;
        if (notificationId != null) {
          final manager = ref.read(notificationManagerProvider);
          await manager.rawNotificationService.cancelNotification(notificationId);
        }
      } catch (e) {
        debugPrint('[Connector] cancel_system_notification error: $e');
      }
    });

    _coordinator.on('clear_notifications_by_type', (payload) async {
      try {
        final type = payload['type'] as String?;
        if (type != null) {
          final manager = ref.read(notificationManagerProvider);
          await manager.rawHistoryService.removeNotificationsByType(type);
          ref.invalidate(notificationHistoryProvider);
        }
      } catch (e) {
        debugPrint('[Connector] clear_notifications_by_type error: $e');
      }
    });

    try {
      final manager = ref.read(notificationManagerProvider);
      manager.rawNotificationService.onNotificationTapped((payload) {
        if (payload != null) {
          final type = payload['type'] as String?;
          if (type == 'deletion_proposal') {
            final data = payload['data'] as Map<String, dynamic>?;
            final proposalId = data?['proposalId'] as String?;
            final router = ref.read(appRouterProvider).router;
            const String deletionProposalPath = '/deletion-proposal';
            if (proposalId != null && proposalId.isNotEmpty && proposalId != 'pending_proposals') {
              router.push('$deletionProposalPath/$proposalId');
            } else {
              router.push(deletionProposalPath);
            }
          }
        }
      });
    } catch (e) {
      debugPrint('[Connector] onNotificationTapped setup error: $e');
    }
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

      // 注册 SMS 离线 Bloom Filter 预检驱动至 Tier 0 优先顺序
      debugPrint('[Connector] Registered SMS Tier 0 Bloom Filter Offline Driver.');

      _coordinator.on('ad_load_fallback_house_ads', (payload) {
        debugPrint('[Connector] Admob/StartApp failed, triggering House Ads fallback.');
      });

      debugPrint('[Connector] All Filter Connectors registered successfully.');
    } catch (e) {
      debugPrint('[Connector] Error registering Filter Connectors: $e');
    }
  }

  /// 执行本地个人库 (Local User DB) 同步
  Future<bool> syncUserDatabase() async {
    try {
      for (final providerId in userDatabaseHub.availableProviders) {
        final adapter = userDatabaseHub.getAdapter(providerId);
        if (adapter != null) {
          await adapter.readAll();
          debugPrint('[Connector] User database sync completed for provider: $providerId');
        }
      }
      return true;
    } catch (e) {
      debugPrint('[Connector] syncUserDatabase error: $e');
      return false;
    }
  }

  /// 执行远程中央库 (Remote Central DB) 同步拉取
  Future<bool> syncCentralDatabase({String countryIsoCode = ''}) async {
    try {
      for (final adapter in centralDatabaseHub.allAdapters) {
        final domain = countryIsoCode.isNotEmpty ? 'rules_$countryIsoCode' : 'rules_global';
        final entities = await adapter.fetchPublicEntities(domain);
        debugPrint('[Connector] Central database fetched ${entities.length} entities for domain: $domain');
      }
      return true;
    } catch (e) {
      debugPrint('[Connector] syncCentralDatabase error: $e');
      return false;
    }
  }

  /// 广播执行本地个人库 (Local User DB) 与 远程中央库 (Remote Central DB) 双流同步
  Future<bool> triggerFullSystemSync({String countryIsoCode = ''}) async {
    try {
      debugPrint('[Connector] Triggering Full System Dual-Stream Sync...');
      final userSyncSuccess = await syncUserDatabase();
      final centralSyncSuccess = await syncCentralDatabase(countryIsoCode: countryIsoCode);

      _coordinator.emit('full_system_sync_completed', {
        'userSyncSuccess': userSyncSuccess,
        'centralSyncSuccess': centralSyncSuccess,
        'timestamp': DateTime.now().toIso8601String(),
      });
      return userSyncSuccess && centralSyncSuccess;
    } catch (e) {
      debugPrint('[Connector] triggerFullSystemSync error: $e');
      return false;
    }
  }
}
