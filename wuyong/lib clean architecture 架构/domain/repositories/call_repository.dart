import '../entities/call/call_log.dart';
import 'base_repository.dart';

/// 通话仓库接口
/// 定义通话记录相关的数据操作
abstract class CallRepository extends BaseRepository<CallLog> {

  /// 添加被阻止的通话记录
  Future<void> addBlockedCall(String phoneNumber, DateTime timestamp);
  
  /// 获取被阻止的通话记录
  Future<List<Map<String, dynamic>>> getBlockedCalls();
  
  /// 清除被阻止的通话记录
  Future<void> clearBlockedCalls();

  /// 获取最近的通话记录
  Future<List<CallLog>> getRecent(int limit);
  
  /// 根据通话类型获取通话记录
  Future<List<CallLog>> getByType(CallType type);
  
  /// 根据电话号码获取通话记录
  Future<List<CallLog>> getByPhoneNumber(String phoneNumber);
  
  /// 获取未读的通话记录
  Future<List<CallLog>> getUnread();
  
  /// 标记通话记录为已读
  Future<void> markAsRead(String id);
  
  /// 获取被阻止的通话记录
  Future<List<CallLog>> getBlocked();
  
  /// 清除所有通话记录
  Future<void> clearAll();
  
  /// 获取通话记录总数
  Future<int> getCount();
}