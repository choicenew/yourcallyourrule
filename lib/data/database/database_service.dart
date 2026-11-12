import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/data/database/remote/remote_database.dart';

part 'database_service.g.dart';

/// 数据库服务提供者 (简化版：仅托管数据库句柄)
@Riverpod(keepAlive: true)
DatabaseService databaseService(Ref ref) {
  return DatabaseService();
}

/// 数据库服务类
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  late final LocalDatabase localDatabase;
  late final RemoteDatabase remoteDatabase;

  DatabaseService._internal() {
    localDatabase = LocalDatabase();
    remoteDatabase = RemoteDatabase();
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
