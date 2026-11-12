import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_user_database_hub/pyro_user_database_hub.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'user_database_service.g.dart';

@Riverpod(keepAlive: true)
UserDatabaseService userDatabaseService(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return UserDatabaseService(db);
}

/// 用户数据库 Feature 业务中转服务 (100% 消费 pyro_user_database_hub)
class UserDatabaseService {
  final LocalDatabase localDb;

  UserDatabaseService(this.localDb);

  Future<void> initializeUserDatabase() async {
    debugPrint('[UserDatabaseService] Initializing UserDatabaseHub...');
    UserDatabaseHub.instance;
  }
}
