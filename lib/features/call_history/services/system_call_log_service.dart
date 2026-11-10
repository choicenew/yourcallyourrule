import 'package:advanced_call_log/advanced_call_log.dart' as sys hide CallLogEntry, CallLog;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/call_history/entities/call_log.dart';

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

  Future<bool> hasCallLogPermission() async {
    final status = await Permission.phone.status;
    return status.isGranted;
  }

  Future<bool> requestCallLogPermission() async {
    final status = await Permission.phone.request();
    return status.isGranted;
  }

  Future<int> syncSystemCallLogs() async {
    if (!await hasCallLogPermission()) {
      return 0;
    }

    try {
      final lastLog = await _callLogService.getLastLog();
      final DateTime lastTimestamp = (lastLog != null && lastLog.timestamp != null)
          ? DateTime.fromMillisecondsSinceEpoch(lastLog.timestamp!)
          : DateTime(2000);

      final systemLogs = await sys.CallLog.query();
      int syncCount = 0;

      for (var entry in systemLogs) {
        final callTimestamp = DateTime.fromMillisecondsSinceEpoch(entry.timestamp ?? 0);
        if (callTimestamp.isBefore(lastTimestamp)) {
          continue;
        }

        final durationInSeconds = entry.duration ?? 0;

        final appLog = CallLog(
          id: const Uuid().v4(),
          phoneNumber: entry.number ?? '',
          callType: entry.callType?.toString() ?? 'incoming',
          timestamp: callTimestamp.millisecondsSinceEpoch,
          durationSeconds: durationInSeconds,
          name: entry.name,
          location: entry.simDisplayName,
        );

        await _callLogService.addLog(appLog);
        syncCount++;
      }

      return syncCount;
    } catch (e) {
      debugPrint('同步系统通话记录错误: $e');
      return 0;
    }
  }
}
