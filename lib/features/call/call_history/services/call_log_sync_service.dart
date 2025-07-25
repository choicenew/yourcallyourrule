import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:yourcallyourrule/features/call/call_history/services/system_call_log_service.dart';

/// 通话记录同步服务
/// 负责在后台同步系统通话记录到应用内数据库。
/// 此服务设计为可由后台任务调度器（如 workmanager）调用。
class CallLogSyncService {
  final SystemCallLogService _systemCallLogService;

  /// 构造函数
  CallLogSyncService(this._systemCallLogService);

  /// 初始化服务，此方法目前为空，因为实际的初始化和同步逻辑
  /// 将由后台任务触发器直接调用 `syncSystemCallLogs`。
  Future<void> initialize() async {
    // 在后台任务模式下，不需要在此处进行初始化。
    // 首次同步和定期同步将由 workmanager 管理。
  }

  /// 同步系统通话记录
  /// 这是后台任务将执行的核心逻辑。
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

  /// 请求权限并手动同步
  /// 此方法供用户界面调用，以便用户可以手动触发一次同步。
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

  /// 释放资源
  /// 在当前设计中，由于没有长连接或定时器，此方法为空。
  void dispose() {
    // 不需要释放资源
  }
}