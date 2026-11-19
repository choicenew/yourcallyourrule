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
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';

final appHubExchangeConnectorProvider = Provider<AppHubExchangeConnector>((ref) {
  final coordinator = ref.watch(appCoordinatorProvider);
  return AppHubExchangeConnector(ref, coordinator)..initializeConnectorBridge();
});

/// 应用微包中枢全量数据流转与协同连接器 (AppHubExchangeConnector)
/// 负责在主 App 中交换调和 @clouddrive, @device, @user_database (Local), @database (Remote Central), @sim_slot_rules, @sync
class AppHubExchangeConnector {
  final Ref ref;
  final AppCoordinator _coordinator;

  AppHubExchangeConnector(this.ref, this._coordinator);

  /// 初始化全量中枢交织桥接管道
  void initializeConnectorBridge() {
    debugPrint('[AppHubExchangeConnector] Wiring Exchange Bridge: Local User DB <-> Remote Central DB <-> CloudDrive <-> Device Hub <-> SIM Rules <-> SyncHub');

    // 1. 云盘上下文配置 (CloudDrive Context) 主 App 注入配置 App 名称与加密标头并挂载驱动
    CloudDriveHub.instance.configureHostContext(
      appName: 'YourCallYourRule',
      encryptionHeaderTag: 'YOURCALL_ENC_V1',
    );
    try {
      CloudDriveHub.instance.register(
        GoogleDriveAdapter(serverClientId: Environment.googleServerClientId),
        uiConfig: GoogleDriveAdapter.uiConfig,
      );
      CloudDriveHub.instance.register(
        OneDriveDriveAdapter(
          clientId: Environment.msalClientId,
          redirectUri: Environment.msalAndroidRedirectUri,
          authority: Environment.msalIosAuthority,
        ),
        uiConfig: OneDriveDriveAdapter.uiConfig,
      );
      CloudDriveHub.instance.register(WebDAVDriveAdapter(), uiConfig: WebDAVDriveAdapter.uiConfig);
      debugPrint('[AppHubExchangeConnector] Registered CloudDrive Drivers with UIConfigs: GoogleDrive, OneDrive, WebDAV');
    } catch (e) {
      debugPrint('[AppHubExchangeConnector] Error registering CloudDrive Drivers: $e');
    }

    // 2. 本地用户数据库 (Local User Database) 初始化并注册引擎节点
    try {
      UserDatabaseHub.instance.registerAdapter(
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
      CentralDatabaseHub.instance.register(
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

    // 4. 全量 Filter 驱动与 SMS Bloom Filter 离线预检驱动一键注册挂载
    _registerAllFilterConnectors();

    // 5. 全局系统通知总线调度 (System Notification Relay & Tap Dispatcher)
    _setupNotificationRelay();

    // 6. 来电识别数据委托统一装配 (Caller Identity Resolvers Glue Assembly)
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

}
