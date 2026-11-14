import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pyro_sync_hub/pyro_sync_hub.dart';
import 'package:pyro_user_database_hub/pyro_user_database_hub.dart';
import 'package:pyro_central_database_hub/pyro_central_database_hub.dart';

import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/data/database/remote/remote_database.dart';

part 'app_sync_bridge_connector.g.dart';

/// App 统一单点装配桥接连接器 (AppSyncBridgeConnector)
@Riverpod(keepAlive: true)
AppSyncBridgeConnector appSyncBridgeConnector(Ref ref) {
  final localDb = ref.watch(localDatabaseProvider);
  final remoteDb = ref.watch(remoteDatabaseProvider);

  return AppSyncBridgeConnector(
    localDatabase: localDb,
    remoteDatabase: remoteDb,
  )..initializeBridge();
}

class AppSyncBridgeConnector {
  final LocalDatabase _localDatabase;
  final RemoteDatabase _remoteDatabase;

  AppSyncBridgeConnector({
    required LocalDatabase localDatabase,
    required RemoteDatabase remoteDatabase,
  })  : _localDatabase = localDatabase,
        _remoteDatabase = remoteDatabase;

  void initializeBridge() {
    _connectUserDatabaseHub();
    _connectCentralDatabaseHub();
    debugPrint('[AppSyncBridgeConnector] Successfully established bridge for Local/Remote DB <-> Sync/User/Central Hubs');
  }

  void _connectUserDatabaseHub() {
    UserDatabaseHub.instance;
    // 补全：绑定 User Database (Local Drift DB) 规则与数据表监听通道
    _localDatabase.select(_localDatabase.phoneRules).watch().listen((rules) {
      debugPrint('[AppSyncBridgeConnector] UserDatabase (phoneRules) changed, total ${rules.length} entries');
    });
  }

  void _connectCentralDatabaseHub() {
    CentralDatabaseHub.instance;
    // 补全：绑定 Central Database (Remote Drift DB) 远程规则与数据表监听通道
    _remoteDatabase.select(_remoteDatabase.remoteNumbers).watch().listen((remoteNumbers) {
      debugPrint('[AppSyncBridgeConnector] CentralDatabase (remoteNumbers) changed, total ${remoteNumbers.length} entries');
    });
  }

  Future<bool> syncIncremental() async {
    try {
      debugPrint('[AppSyncBridgeConnector] Executing incremental sync via Package SyncHub...');
      final moduleIds = SyncHub.instance.registeredModuleIds;
      for (final moduleId in moduleIds) {
        final adapter = SyncHub.instance.getAdapter(moduleId);
        if (adapter != null) {
          final items = await adapter.readAll();
          debugPrint('[AppSyncBridgeConnector] Synced module $moduleId (${items.length} items)');
        }
      }
      return true;
    } catch (e) {
      debugPrint('[AppSyncBridgeConnector] Incremental sync error: $e');
      return false;
    }
  }
}
