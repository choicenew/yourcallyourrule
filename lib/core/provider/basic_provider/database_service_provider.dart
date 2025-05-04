import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';

/// 数据库服务提供者
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});