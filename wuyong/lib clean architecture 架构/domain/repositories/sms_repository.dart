import '../entities/sms/sms_message.dart';
import 'base_repository.dart';

/// 短信仓库接口
/// 定义短信消息相关的数据操作
abstract class SmsRepository extends BaseRepository<SmsMessage> {
  /// 获取最近的短信消息
  Future<List<SmsMessage>> getRecent(int limit);
  
  /// 根据短信类型获取短信消息
  Future<List<SmsMessage>> getByType(SmsType type);
  
  /// 根据电话号码获取短信消息
  Future<List<SmsMessage>> getByPhoneNumber(String phoneNumber);
  
  /// 获取未读的短信消息
  Future<List<SmsMessage>> getUnread();
  
  /// 标记短信消息为已读
  Future<void> markAsRead(String id);
  
  /// 获取被阻止的短信消息
  Future<List<SmsMessage>> getBlocked();
  
  /// 搜索短信内容
  Future<List<SmsMessage>> searchContent(String query);
  
  /// 清除所有短信消息
  Future<void> clearAll();
  
  /// 获取短信消息总数
  Future<int> getCount();
}