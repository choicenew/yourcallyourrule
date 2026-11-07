import 'package:pyro_phone_call_history_protocol/src/models/call_log_entry.dart';

/// 通话历史持久化 Driver 抽象接口契约 (CallLogStorageDriver)
abstract class CallLogStorageDriver {
  Future<void> saveCallLog(CallLogEntry entry);
  Future<List<CallLogEntry>> getAllLogs();
  Future<void> deleteLog(String id);
}
