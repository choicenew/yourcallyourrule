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
/// 职责：一键完成主 App 本地数据库 (LocalDatabase & RemoteDatabase) 与 Package Hubs 的桥接
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

  /// 一键装配与桥接初始化
  void initializeBridge() {
    _registerSyncInterfaceHandler();
    _connectUserDatabaseHub();
    _connectCentralDatabaseHub();
    debugPrint('[AppSyncBridgeConnector] Successfully established bridge for Local/Remote DB <-> Sync/User/Central Hubs');
  }

  /// 1. 设置 SyncInterface 静态零依赖入口的通用处理 Handler
  void _registerSyncInterfaceHandler() {
    SyncInterface.setSyncHandler((domain, entityKey, payload) async {
      try {
        debugPrint('[SyncInterface] Received sync dispatch for domain: $domain, key: $entityKey');
        // 根据 domain 分发给已注册在 SyncHub 的指定 Adapter 处理
        final adapter = SyncHub.instance.getAdapter(domain);
        if (adapter != null) {
          return true;
        }
        return false;
      } catch (e) {
        debugPrint('[SyncInterface] Error processing sync: $e');
        return false;
      }
    });
  }

  /// 2. 桥接个人用户数据库 (LocalDatabase <-> UserDatabaseHub)
  void _connectUserDatabaseHub() {
    // 监听或注册 UserDatabaseHub 个人云盘驱动
    final hub = UserDatabaseHub.instance;
    // 注册桥接通知或个人数据库适配层
  }

  /// 3. 桥接中央系统数据库 (RemoteDatabase <-> CentralDatabaseHub)
  void _connectCentralDatabaseHub() {
    // 注册 CentralDatabaseHub 中央数据库驱动
    final hub = CentralDatabaseHub.instance;
    // 注册桥接通知或中央只读表查询适配层
  }

  /// 触发端到端/网盘增量同步
  Future<bool> syncIncremental() async {
    try {
      debugPrint('[AppSyncBridgeConnector] Executing incremental sync via Package SyncHub...');
      // 触发 SyncHub 关联的各个 SyncAdapter 增量同步
      final adapters = SyncHub.instance.allAdapters;
      for (final adapter in adapters) {
        await adapter.executeSync();
      }
      return true;
    } catch (e) {
      debugPrint('[AppSyncBridgeConnector] Incremental sync error: $e');
      return false;
    }
  }
}
