import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_cloud_drive_googledrive/pyro_cloud_drive_googledrive.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_cloud_drive_onedrive/pyro_cloud_drive_onedrive.dart';
import 'package:pyro_cloud_drive_webdav/pyro_cloud_drive_webdav.dart';
import 'package:pyro_device_primary_secondary_hub/pyro_device_primary_secondary_hub.dart';
import 'package:pyro_sync_hub/pyro_sync_hub.dart';
import 'package:pyro_user_database_hub/pyro_user_database_hub.dart';
import 'package:yourcallyourrule/features/cloud_drive/providers/cloud_sync_provider.dart';
import 'package:yourcallyourrule/features/cloud_drive/services/environment.dart';
import '../app_coordinator.dart';

final userDatabaseHubProvider = Provider<UserDatabaseHub>((ref) => UserDatabaseHub());
final deviceClusterHubProvider = Provider<DeviceClusterHub>((ref) => DeviceClusterHub());
final syncHubProvider = Provider<SyncHub>((ref) => SyncHub());

final databaseSyncExchangeConnectorProvider = Provider<DatabaseSyncExchangeConnector>((ref) {
  final coordinator = ref.watch(appCoordinatorProvider);
  return DatabaseSyncExchangeConnector(
    ref: ref,
    coordinator: coordinator,
    userDatabaseHub: ref.watch(userDatabaseHubProvider),
    cloudDriveHub: ref.watch(cloudDriveHubProvider),
    deviceClusterHub: ref.watch(deviceClusterHubProvider),
    syncHub: ref.watch(syncHubProvider),
  );
});

/// 用户私有数据库与设备同步连接器 (DatabaseSyncExchangeConnector)
/// 专职负责：
/// 1. 调度 UserDatabaseHub（用户个人私有库适配器，受商业化 VIP 门禁控制）
/// 2. 调度 CloudDriveHub（Google Drive, OneDrive, WebDAV）
/// 3. 调度 DeviceMasterSlaveHub（多设备拓扑管理）与 SyncHub（本地增量同步调度）
/// 4. 严格隔离：绝对零权限接触开发者 Central Database 凭证 (Env.workerApiSecret)
class DatabaseSyncExchangeConnector {
  final Ref ref;
  final AppCoordinator coordinator;
  final UserDatabaseHub userDatabaseHub;
  final CloudDriveHub cloudDriveHub;
  final DeviceClusterHub deviceClusterHub;
  final SyncHub syncHub;

  const DatabaseSyncExchangeConnector({
    required this.ref,
    required this.coordinator,
    required this.userDatabaseHub,
    required this.cloudDriveHub,
    required this.deviceClusterHub,
    required this.syncHub,
  });

  void initialize() {
    // 1. 云盘上下文配置与驱动挂载
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
      debugPrint('[DatabaseSyncConnector] Registered CloudDrive Drivers with UIConfigs: GoogleDrive, OneDrive, WebDAV');
    } catch (e) {
      debugPrint('[DatabaseSyncConnector] Error registering CloudDrive Drivers: $e');
    }

    // 2. 设备管理中枢与增量同步中枢
    debugPrint('[DatabaseSyncConnector] Initialized DeviceMasterSlaveHub & SyncHub for Multi-Device and Incremental Sync');

    // 3. 本地用户数据变更监听管道
    coordinator.on('local_user_data_changed', (payload) async {
      debugPrint('[DatabaseSyncConnector] Local User Database changed, triggering user sync...');
      await syncUserDatabase();
    });
  }

  /// 执行本地个人库同步 (受 VIP 门禁限制)
  Future<bool> syncUserDatabase() async {
    try {
      for (final providerId in userDatabaseHub.availableProviders) {
        final adapter = userDatabaseHub.getAdapter(providerId);
        if (adapter != null) {
          await adapter.readAll();
          debugPrint('[DatabaseSyncConnector] User database sync completed for provider: $providerId');
        }
      }
      return true;
    } catch (e) {
      debugPrint('[DatabaseSyncConnector] syncUserDatabase error: $e');
      return false;
    }
  }
}
