import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/repositories/base_repository.dart';

/// 通话记录仓库接口
abstract class CallLogRepository extends BaseRepository<CallLog, String> {
  /// 获取最近的通话记录
  Future<List<CallLog>> getRecentLogs();
  
  /// 根据电话号码获取通话记录
  Future<List<CallLog>> getLogsByPhoneNumber(String phoneNumber);
  
  /// 监听通话记录变化
  Stream<List<CallLog>> watchLogs();
  
  /// 刷新通话记录
  Future<void> refreshLogs();
  
  /// 添加通话记录
  Future<void> addLog(CallLog log);
  
  /// 删除指定日期范围内的通话记录
  Future<int> deleteLogsByDateRange(DateTime startDate, DateTime endDate);
  
  /// 获取指定日期范围内的通话记录
  Future<List<CallLog>> getLogsByDateRange(DateTime startDate, DateTime endDate);
  
  /// 获取未读的通话记录
  Future<List<CallLog>> getUnreadLogs();
  
  /// 标记通话记录为已读
  Future<void> markAsRead(String logId);
  
  /// 批量标记通话记录为已读
  Future<void> markAllAsRead();
  
  /// 根据标签ID获取通话记录
  Future<List<CallLog>> getLogsByLabelId(String labelId);
  
  /// 获取包含任意指定标签的通话记录
  Future<List<CallLog>> getLogsWithAnyLabels(List<String> labelIds);
  
  /// 获取包含全部指定标签的通话记录 
  Future<List<CallLog>> getLogsWithAllLabels(List<String> labelIds);
}