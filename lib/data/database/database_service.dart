import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/data/database/remote/remote_database.dart';
import 'package:yourcallyourrule/features/sync/services/cloud_sync/incremental_sync_manager.dart';
import 'package:yourcallyourrule/features/sync/services/cloud_sync/sync_conflict_resolver.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

part 'database_service.g.dart';

/// 数据库服务提供者 (简化版：仅托管数据库句柄，不持有废弃的 DataSource 实例)
@Riverpod(keepAlive: true)
DatabaseService databaseService(Ref ref) {
  return DatabaseService();
}

/// 数据库服务类
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  
  late final LocalDatabase localDatabase;
  late final RemoteDatabase remoteDatabase;
  late final IncrementalSyncManager incrementalSyncManager;
  
  DatabaseService._internal() {
    localDatabase = LocalDatabase();
    remoteDatabase = RemoteDatabase();

    final configRepository = SharedPreferencesConfigRepository();
    final conflictResolver = SyncConflictResolver();

    incrementalSyncManager = IncrementalSyncManager(
      conflictResolver,
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
