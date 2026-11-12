import 'dart:async';

import 'package:advanced_call_log/advanced_call_log.dart' hide CallLogEntry;
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_service.dart';

part 'system_call_log_service.g.dart';

/// 系统通话记录服务提供者
@Riverpod(keepAlive: true)
SystemCallLogService systemCallLogService(Ref ref) {
  return SystemCallLogService(ref.watch(callLogServiceProvider));
}

/// 系统通话记录服务：从 Android 系统读取通话记录并增量同步到应用内
class SystemCallLogService {
  final CallLogService _callLogService;

  SystemCallLogService(this._callLogService);

  Future<bool> hasPermission() async {
    final status = await Permission.phone.status;
    return status.isGranted;
  }

  Future<bool> requestPermission() async {
    final status = await Permission.phone.request();
    return status.isGranted;
  }

  Future<int> syncSystemCallLogs() async {
    if (!await hasPermission()) {
      debugPrint('[SystemCallLogService] 权限未授权，无法同步系统通话记录');
      return 0;
    }

    try {
      final lastLog = await _callLogService.getLastLog();
      final DateTime lastTimestamp = (lastLog != null && lastLog.timestamp != null)
          ? DateTime.fromMillisecondsSinceEpoch(lastLog.timestamp!)
          : DateTime(2000);

      final systemLogs = await CallLog.get();
      int syncCount = 0;

      for (var entry in systemLogs) {
        final callTimestamp = DateTime.fromMillisecondsSinceEpoch(entry.timestamp ?? 0);
        if (callTimestamp.isBefore(lastTimestamp)) {
          continue;
        }

        final durationInSeconds = entry.duration ?? 0;

        final appLog = CallLogEntry(
          id: const Uuid().v4(),
          phoneNumber: entry.number ?? '',
          callType: entry.callType?.toString() ?? 'incoming',
          timestamp: callTimestamp.millisecondsSinceEpoch,
          durationSeconds: durationInSeconds,
          name: entry.name,
        );

        await _callLogService.addLog(appLog);
        syncCount++;
      }

      debugPrint('[SystemCallLogService] 成功同步 $syncCount 条系统通话记录');
      return syncCount;
    } catch (e) {
      debugPrint('[SystemCallLogService] 同步系统通话记录失败: $e');
      return 0;
    }
  }
}
