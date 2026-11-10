import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/call_history/services/system_call_log_service.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_service.dart';

part 'call_log_sync_service.g.dart';

/// 通话记录同步服务提供者
@Riverpod(keepAlive: true)
CallLogSyncService callLogSyncService(Ref ref) {
  final callLogService = ref.watch(callLogServiceProvider);
  final systemCallLogService = SystemCallLogService(callLogService);
  final syncService = CallLogSyncService(systemCallLogService);
  ref.onDispose(() {
    syncService.dispose();
  });
  return syncService;
}

/// 通话记录同步服务
/// 负责在后台同步系统通话记录到应用内数据库。
class CallLogSyncService {
  final SystemCallLogService _systemCallLogService;

  CallLogSyncService(this._systemCallLogService);

  Future<void> initialize() async {}

  /// 同步系统通话记录
  Future<int> syncSystemCallLogs() async {
    try {
      final hasPermission = await _systemCallLogService.hasCallLogPermission();
      if (!hasPermission) {
        debugPrint('没有读取通话记录权限，跳过后台同步');
        return 0;
      }

      final syncCount = await _systemCallLogService.syncSystemCallLogs();
      debugPrint('后台同步了 $syncCount 条系统通话记录');
      return syncCount;
    } catch (e) {
      debugPrint('后台同步系统通话记录时发生错误: $e');
      return 0;
    }
  }

  Future<int> requestPermissionAndSync() async {
    try {
      final granted = await _systemCallLogService.requestCallLogPermission();
      if (!granted) {
        debugPrint('用户拒绝了读取通话记录权限');
        return 0;
      }
      return await syncSystemCallLogs();
    } catch (e) {
      debugPrint('请求权限并同步系统通话记录错误: $e');
      return 0;
    }
  }

  void dispose() {}
}
