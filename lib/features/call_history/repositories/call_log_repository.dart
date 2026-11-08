import 'package:yourcallyourrule/features/call_history/entities/call_log.dart';

/// 通话记录仓库接口
abstract class CallLogRepository {
  Future<List<CallLog>> getAll();
  Future<CallLog?> getById(String id);
  Future<CallLog> save(CallLog entity);
  Future<CallLog> update(CallLog entity);
  Future<bool> deleteById(String id);
  Future<bool> delete(CallLog entity);
  Future<bool> deleteAll(List<CallLog> entities);
  Future<int> count();

  Future<List<CallLog>> getRecentLogs();
  Future<List<CallLog>> getLogsByPhoneNumber(String phoneNumber);
  Future<void> updateAll(List<CallLog> logs);
  Future<void> refreshLogs();
  Future<void> addLog(CallLog log);
  Future<int> deleteLogsByDateRange(DateTime startDate, DateTime endDate);
  Future<List<CallLog>> getLogsByDateRange(DateTime startDate, DateTime endDate);
  Future<List<CallLog>> getUnreadLogs();
  Future<void> markAsRead(String logId);
  Future<void> markAllAsRead();
  Future<List<CallLog>> getLogsByLabelId(String labelId);
  Future<List<CallLog>> getLogsWithAnyLabels(List<String> labelIds);
  Future<List<CallLog>> getLogsWithAllLabels(List<String> labelIds);

  Stream<List<CallLog>> watchLogs();
}