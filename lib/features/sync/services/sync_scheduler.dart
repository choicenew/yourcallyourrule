import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yourcallyourrule/features/remote_filter/data/datasources/remote_number_datasource.dart';

part 'sync_scheduler.g.dart';

/// SyncScheduler Provider
@Riverpod(keepAlive: true)
SyncScheduler syncScheduler(Ref ref) {
  final remoteNumberDataSource = ref.watch(remoteNumberDataSourceProvider);
  return SyncScheduler(dataSource: remoteNumberDataSource);
}

/// 负责控制数据库同步时间间隔与触发条件判定 (SyncScheduler)
///
/// 通过比对最后一次成功同步的时间戳与设置的间隔 (默认 24 小时)，判断当前是否需要触发增量同步
class SyncScheduler {
  final RemoteNumberDataSource _dataSource;
  final Duration _syncInterval;

  SyncScheduler({
    required RemoteNumberDataSource dataSource,
    Duration? syncInterval,
  })  : _dataSource = dataSource,
        _syncInterval = syncInterval ?? const Duration(days: 1);

  /// 检查当前是否达到了同步触发间隔
  Future<bool> get needsSync async {
    final lastSyncTime = await _dataSource.getLastSyncTime();
    if (lastSyncTime == null) {
      return true; // 如果从未同步过，需要立即触发同步
    }

    final now = DateTime.now();
    final difference = now.difference(lastSyncTime);

    return difference >= _syncInterval;
  }
}
