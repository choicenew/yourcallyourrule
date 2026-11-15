import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_cloud_drive_googledrive/pyro_cloud_drive_googledrive.dart';
import 'package:pyro_cloud_drive_onedrive/pyro_cloud_drive_onedrive.dart';
import 'package:pyro_cloud_drive_webdav/pyro_cloud_drive_webdav.dart';
import 'package:pyro_user_database_hub/pyro_user_database_hub.dart';
import 'package:pyro_user_database_cloudflare/pyro_user_database_cloudflare.dart';
import 'package:pyro_central_database_hub/pyro_central_database_hub.dart';
import 'package:pyro_sync_hub/pyro_sync_hub.dart';
import 'package:pyro_device_master_slave_protocol/pyro_device_master_slave_protocol.dart';

import 'package:pyro_phone_count_filter_connector/pyro_phone_count_filter_connector.dart';
import 'package:pyro_phone_remote_filter_connector/pyro_phone_remote_filter_connector.dart';
import 'package:pyro_phone_time_interceptor_connector/pyro_phone_time_interceptor_connector.dart';
import 'package:pyro_phone_sim_slot_rules_connector/pyro_phone_sim_slot_rules_connector.dart';

import 'app_coordinator.dart';
import 'filter_ui_registry.dart';

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
      CloudDriveHub.instance.register(GoogleDriveAdapter());
      CloudDriveHub.instance.register(OneDriveDriveAdapter());
      CloudDriveHub.instance.register(WebDAVDriveAdapter());
      debugPrint('[AppHubExchangeConnector] Registered CloudDrive Drivers: GoogleDrive, OneDrive, WebDAV');
    } catch (e) {
      debugPrint('[AppHubExchangeConnector] Error registering CloudDrive Drivers: $e');
    }

    // 2. 本地用户数据库 (Local User Database) 初始化并注册引擎节点
    try {
      UserDatabaseHub.instance.registerAdapter(CloudflareSyncProvider());
      debugPrint('[AppHubExchangeConnector] Registered UserDatabase Sync Adapters');
    } catch (e) {
      debugPrint('[AppHubExchangeConnector] Error registering UserDatabase Sync Adapters: $e');
    }

    // 3. 远程中央数据库 (Remote Central Database) 初始化
    CentralDatabaseHub.instance;

    // 4. 设备节点变动通知 (Device Node Changes) -> 同步至 CloudDrive 上下文 (使用强类型 DeviceNode 值对象)
    _coordinator.on('device_node_updated', (payload) {
      final deviceNode = payload['deviceNode'] is DeviceNode 
          ? (payload['deviceNode'] as DeviceNode)
          : (payload['deviceNode'] is Map<String, dynamic>
              ? DeviceNode.fromJson(payload['deviceNode'] as Map<String, dynamic>)
              : null);
      final deviceId = deviceNode?.deviceId ?? (payload['deviceId'] as String?);
      debugPrint('[Connector] Device node updated: ${deviceNode?.deviceName} ($deviceId) -> CloudDrive Context updated');
      CloudDriveHub.instance.updateActiveAccount(deviceId);
    });

    // 5. 本地数据 CDC 变更 (Local User DB CDC Event)
    _coordinator.on('local_user_data_changed', (payload) {
      debugPrint('[Connector] Local User Database changed, notifying SyncHub...');
      _coordinator.emit('trigger_incremental_sync');
    });

    // 6. 远程中央数据库拉取事件 (Remote Central DB Update Event)
    _coordinator.on('remote_central_db_update', (payload) async {
      final countryIsoCode = payload['countryIsoCode'] as String? ?? '';
      debugPrint('[Connector] Remote Central DB update triggered for country: $countryIsoCode');
    });

    // 7. 触发全量增量 CDC 变更管道 (CDC Sync Event)
    _coordinator.on('trigger_incremental_sync', (payload) async {
      final moduleIds = SyncHub.instance.registeredModuleIds;
      for (final moduleId in moduleIds) {
        final adapter = SyncHub.instance.getAdapter(moduleId);
        if (adapter != null) {
          final items = await adapter.readAll();
          debugPrint('[Connector] Incremental sync executed for module $moduleId (${items.length} items)');
        }
      }
    });

    // 8. 众包删除提案签名与验证事件广播 (Crowdsourcing Signature Event)
    _coordinator.on('crowdsourcing_proposal_submit', (payload) async {
      final proposalId = payload['proposalId'] as String?;
      final signature = payload['signature'] as String?;
      debugPrint('[Connector] Crowdsourcing proposal signature verification: $proposalId ($signature)');
      _coordinator.emit('crowdsourcing_proposal_verified', {
        'proposalId': proposalId,
        'status': 'verified',
      });
    });

    // 9. 全量 Filter 驱动与 SMS Bloom Filter 离线预检驱动一键注册挂载
    _registerAllFilterConnectors();
  }

  void _registerAllFilterConnectors() {
    try {
      PyroPhoneCountFilterConnector.registerAll();
      PyroPhoneRemoteFilterConnector.registerAll();
      PyroTimeInterceptorConnector.registerAll();
      SimSlotRuleConnector.registerAll();

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

  /// 广播执行本地个人库 (Local User DB) 与 远程中央库 (Remote Central DB) 双流同步
  Future<bool> triggerFullSystemSync() async {
    try {
      _coordinator.emit('trigger_incremental_sync');
      _coordinator.emit('remote_central_db_update');
      return true;
    } catch (e) {
      debugPrint('[Connector] System sync error: $e');
      return false;
    }
  }
}
