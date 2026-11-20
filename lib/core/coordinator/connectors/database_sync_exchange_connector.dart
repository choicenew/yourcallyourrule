import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_central_database_cloudflare/pyro_central_database_cloudflare.dart';
import 'package:pyro_central_database_hub/pyro_central_database_hub.dart';
import 'package:pyro_cloudflare/pyro_cloudflare.dart';
import 'package:pyro_cloud_drive_googledrive/pyro_cloud_drive_googledrive.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_cloud_drive_onedrive/pyro_cloud_drive_onedrive.dart';
import 'package:pyro_cloud_drive_webdav/pyro_cloud_drive_webdav.dart';
import 'package:pyro_device_master_slave_hub/pyro_device_master_slave_hub.dart';
import 'package:pyro_sync_hub/pyro_sync_hub.dart';
import 'package:pyro_user_database_cloudflare/pyro_user_database_cloudflare.dart';
import 'package:pyro_user_database_hub/pyro_user_database_hub.dart';
import 'package:yourcallyourrule/env.dart';
import 'package:yourcallyourrule/features/cloud_drive/services/environment.dart';
import 'package:yourcallyourrule/features/remote_filter/data/datasources/remote_number_datasource.dart';
import '../app_coordinator.dart';

final centralDatabaseHubProvider = Provider<CentralDatabaseHub>((ref) => CentralDatabaseHub());
final userDatabaseHubProvider = Provider<UserDatabaseHub>((ref) => UserDatabaseHub());
final deviceMasterSlaveHubProvider = Provider<DeviceMasterSlaveHub>((ref) => DeviceMasterSlaveHub());
final syncHubProvider = Provider<SyncHub>((ref) => SyncHub());

class DatabaseSyncExchangeConnector {
  final Ref ref;
  final AppCoordinator coordinator;
  final CentralDatabaseHub centralDatabaseHub;
  final UserDatabaseHub userDatabaseHub;
  final CloudDriveHub cloudDriveHub;
  final DeviceMasterSlaveHub deviceMasterSlaveHub;
  final SyncHub syncHub;

  const DatabaseSyncExchangeConnector({
    required this.ref,
    required this.coordinator,
    required this.centralDatabaseHub,
    required this.userDatabaseHub,
    required this.cloudDriveHub,
    required this.deviceMasterSlaveHub,
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

    // 2. 本地用户数据库引擎节点注册
    try {
      userDatabaseHub.registerAdapter(
        CloudflareSyncProvider(
          workerUrl: Env.cfWorkerUrl,
          apiSecret: Env.workerApiSecret,
        ),
      );
      debugPrint('[DatabaseSyncConnector] Registered UserDatabase Sync Adapters');
    } catch (e) {
      debugPrint('[DatabaseSyncConnector] Error registering UserDatabase Sync Adapters: $e');
    }

    // 3. 远程中央数据库适配器注册
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
      debugPrint('[DatabaseSyncConnector] Registered CentralDatabase CloudflareCentralDbAdapter');
    } catch (e) {
      debugPrint('[DatabaseSyncConnector] Error registering CentralDatabase Adapters: $e');
    }

    // 4. 设备管理中枢与增量同步中枢
    debugPrint('[DatabaseSyncConnector] Initialized DeviceMasterSlaveHub & SyncHub for Multi-Device and Incremental Sync');

    // 5. 本地数据变更监听管道
    coordinator.on('local_user_data_changed', (payload) async {
      debugPrint('[DatabaseSyncConnector] Local User Database changed, triggering user sync...');
      await syncUserDatabase();
    });

    // 6. 远程中央数据库拉取事件管道
    coordinator.on('remote_central_db_update', (payload) async {
      final countryIsoCode = payload['countryIsoCode'] as String? ?? '';
      debugPrint('[DatabaseSyncConnector] Remote Central DB update triggered for country: $countryIsoCode');
      await syncCentralDatabase(countryIsoCode: countryIsoCode);
    });
  }

  /// 宿主协调层专属受控 Cloudflare 传输 Client (用于中央数据库及公共配置请求)
  CloudflareWorkerClient get workerClient {
    return CloudflareWorkerClient(
      config: CloudflareConfig(
        workerUrl: Env.cfWorkerUrl,
        apiSecret: Env.workerApiSecret,
        accountId: '',
      ),
    );
  }

  /// 推送变更至远程 Cloudflare Worker
  Future<bool> pushChanges({
    required List<Map<String, dynamic>> changes,
    required String deviceId,
  }) async {
    final res = await workerClient.post('/sync/push', {
      'deviceId': deviceId,
      'changes': changes,
    });
    return res != null && (res['success'] == true || res['status'] == 'ok');
  }

  /// 从服务器获取自上次同步以来的变更
  Future<List<Map<String, dynamic>>> getChanges({
    DateTime? since,
    required String deviceId,
    List<String>? countryCodes,
  }) async {
    final query = <String, String>{
      'deviceId': deviceId,
      if (since != null) 'since': since.toIso8601String(),
      if (countryCodes != null) 'countryCodes': countryCodes.join(','),
    };
    final res = await workerClient.get('/sync/pull', query);
    if (res != null && res['changes'] is List) {
      return List<Map<String, dynamic>>.from(res['changes'] as List);
    }
    return [];
  }

  /// 获取特定国家的初始规则数据 (Worker API 通道)
  Future<List<Map<String, dynamic>>> getInitialDataForCountry(
    String countryIsoCode,
  ) async {
    final res = await workerClient.get('/sync/initial/$countryIsoCode');
    if (res != null && res['data'] is List) {
      return List<Map<String, dynamic>>.from(res['data'] as List);
    }
    return [];
  }

  /// 获取云端提案限制与投票配置
  Future<Map<String, dynamic>> getProposalLimitsConfig() async {
    final res = await workerClient.get('/config/limits');
    return res ?? {};
  }

  /// 执行本地个人库同步
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

  /// 执行远程中央库指定国家规则同步并批量写入本地持久化库 (RemoteNumberDataSource)
  Future<int> syncCentralCountryRules({
    required String countryIsoCode,
    RemoteNumberDataSource? dataSource,
  }) async {
    final targetDataSource = dataSource ?? ref.read(remoteNumberDataSourceProvider);
    int totalCount = 0;

    try {
      final domain = countryIsoCode.isNotEmpty ? 'rules_$countryIsoCode' : 'rules_global';
      final List<Map<String, dynamic>> numbers = [];

      // 1. 优先通过 CentralDatabaseHub 多适配器拉取公共实体
      for (final adapter in centralDatabaseHub.allAdapters) {
        final entities = await adapter.fetchPublicEntities(domain);
        debugPrint('[DatabaseSyncConnector] Central database fetched ${entities.length} entities for domain: $domain via ${adapter.moduleId}');
        for (final entity in entities) {
          final payload = Map<String, dynamic>.from(entity.payload);
          if (!payload.containsKey('phoneNumber') && entity.entityKey.isNotEmpty) {
            payload['phoneNumber'] = entity.entityKey;
          }
          numbers.add(payload);
        }
      }

      // 2. 若中央库适配器尚未返回实体，回退至 Worker 初始化通道
      if (numbers.isEmpty && countryIsoCode.isNotEmpty) {
        final workerData = await getInitialDataForCountry(countryIsoCode);
        numbers.addAll(workerData);
      }

      if (numbers.isNotEmpty && targetDataSource != null) {
        await targetDataSource.bulkInsertFromServer(countryIsoCode, numbers);
        totalCount = numbers.length;
      }
      return totalCount;
    } catch (e) {
      debugPrint('[DatabaseSyncConnector] syncCentralCountryRules error: $e');
      rethrow;
    }
  }

  /// 执行远程中央库同步拉取
  Future<bool> syncCentralDatabase({String countryIsoCode = '', RemoteNumberDataSource? dataSource}) async {
    try {
      final count = await syncCentralCountryRules(
        countryIsoCode: countryIsoCode,
        dataSource: dataSource,
      );
      debugPrint('[DatabaseSyncConnector] Central database sync completed with $count entities.');
      return true;
    } catch (e) {
      debugPrint('[DatabaseSyncConnector] syncCentralDatabase error: $e');
      return false;
    }
  }

  /// 广播执行本地个人库与远程中央库双流同步
  Future<bool> triggerFullSystemSync({String countryIsoCode = ''}) async {
    try {
      debugPrint('[DatabaseSyncConnector] Triggering Full System Dual-Stream Sync...');
      final userSyncSuccess = await syncUserDatabase();
      final centralSyncSuccess = await syncCentralDatabase(countryIsoCode: countryIsoCode);

      coordinator.emit('full_system_sync_completed', {
        'userSyncSuccess': userSyncSuccess,
        'centralSyncSuccess': centralSyncSuccess,
        'timestamp': DateTime.now().toIso8601String(),
      });
      return userSyncSuccess && centralSyncSuccess;
    } catch (e) {
      debugPrint('[DatabaseSyncConnector] triggerFullSystemSync error: $e');
      return false;
    }
  }
}

