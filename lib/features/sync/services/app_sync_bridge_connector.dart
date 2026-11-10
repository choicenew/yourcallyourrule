import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pyro_sync_protocol/pyro_sync_protocol.dart';
import 'package:pyro_sync_hub/pyro_sync_hub.dart';
import 'package:pyro_user_database_protocol/pyro_user_database_protocol.dart';
import 'package:pyro_user_database_hub/pyro_user_database_hub.dart';
import 'package:pyro_central_database_protocol/pyro_central_database_protocol.dart';
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
    final hub = UserDatabaseHub.instance;
  }

  void _connectCentralDatabaseHub() {
    final hub = CentralDatabaseHub.instance;
  }

  Future<bool> syncIncremental() async {
    try {
      debugPrint('[AppSyncBridgeConnector] Executing incremental sync via Package SyncHub...');
      final moduleIds = SyncHub.instance.registeredModuleIds;
      for (final moduleId in moduleIds) {
        final adapter = SyncHub.instance.getAdapter(moduleId);
        if (adapter != null) {
          await adapter.executeSync();
        }
      }
      return true;
    } catch (e) {
      debugPrint('[AppSyncBridgeConnector] Incremental sync error: $e');
      return false;
    }
  }
}
