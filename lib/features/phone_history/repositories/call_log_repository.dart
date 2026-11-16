import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';

/// 通话记录仓库接口
abstract class CallLogRepository {
  Future<List<CallLogEntry>> getAll();
  Future<CallLogEntry?> getById(String id);
  Future<CallLogEntry> save(CallLogEntry entity);
  Future<CallLogEntry> update(CallLogEntry entity);
  Future<bool> deleteById(String id);
  Future<bool> delete(CallLogEntry entity);
  Future<bool> deleteAll(List<CallLogEntry> entities);
  Future<int> count();

  Future<List<CallLogEntry>> getRecentLogs();
  Future<List<CallLogEntry>> getLogsByPhoneNumber(String phoneNumber);
  Future<void> updateAll(List<CallLogEntry> logs);
  Future<void> refreshLogs();
  Future<void> addLog(CallLogEntry log);
  Future<int> deleteLogsByDateRange(DateTime startDate, DateTime endDate);
  Future<List<CallLogEntry>> getLogsByDateRange(DateTime startDate, DateTime endDate);
  Future<List<CallLogEntry>> getUnreadLogs();
  Future<void> markAsRead(String logId);
  Future<void> markAllAsRead();
  Future<List<CallLogEntry>> getLogsByLabelId(String labelId);
  Future<List<CallLogEntry>> getLogsWithAnyLabels(List<String> labelIds);
  Future<List<CallLogEntry>> getLogsWithAllLabels(List<String> labelIds);

  Stream<List<CallLogEntry>> watchLogs();
}