import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/database/sync/incremental_sync_manager_remote_database.dart';

/// 提供IncrementalSyncManager的Provider
final incrementalSyncManagerProvider = Provider<IncrementalSyncManager?>((ref) {
  final syncManager = IncrementalSyncManager();
  // 使用异步初始化，确保在使用前已完成初始化
  syncManager.initialize();
  return syncManager;
});