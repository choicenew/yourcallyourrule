import 'package:flutter/foundation.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';

/// 真实内存级通话历史持久化驱动 (MemoryCallLogStorageDriver)
class MemoryCallLogStorageDriver implements CallLogStorageDriver {
  final Map<String, CallLogEntry> _logs = {};

  MemoryCallLogStorageDriver();

  @override
  Future<void> saveCallLog(CallLogEntry entry) async {
    _logs[entry.id] = entry;
    debugPrint('[MemoryCallHistoryDriver] 持久化保存通话日志: ${entry.phoneNumber} (${entry.callType})');
  }

  @override
  Future<List<CallLogEntry>> getAllLogs() async {
    return _logs.values.toList();
  }

  @override
  Future<void> deleteLog(String id) async {
    _logs.remove(id);
  }
}
