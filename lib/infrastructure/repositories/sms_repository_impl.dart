import '../../domain/entities/sms/sms_message.dart';
import '../../domain/repositories/sms_repository.dart';
import '../../domain/value_objects/phone_number.dart';
import '../datasources/local/database/app_database.dart';
import '../datasources/local/database/dao/sms_dao.dart';
import 'base_repository_impl.dart';

/// 短信仓库实现
/// 实现短信仓库接口，提供短信相关的数据操作
class SmsRepositoryImpl extends BaseRepositoryImpl<SmsMessage, SmsDao> implements SmsRepository {
  SmsRepositoryImpl(AppDatabase database)
      : super(database, database.smsDao);
  
  @override
  Future<List<SmsMessage>> getRecent(int limit) async {
    return await dao.getRecent(limit);
  }
  
  @override
  Future<List<SmsMessage>> getByPhoneNumber(String phoneNumberValue) async {
    try {
      final phoneNumber = PhoneNumber(phoneNumberValue);
      return await dao.getByPhoneNumber(phoneNumber.normalized);
    } catch (e) {
      return [];
    }
  }
  
  @override
  Future<List<SmsMessage>> getByMessageType(String messageType) async {
    return await dao.getByMessageType(messageType);
  }
  
  @override
  Future<List<SmsMessage>> getByDateRange(DateTime start, DateTime end) async {
    return await dao.getByDateRange(start, end);
  }
  
  @override
  Future<List<SmsMessage>> getByRuleId(String ruleId) async {
    return await dao.getByRuleId(ruleId);
  }
  
  @override
  Future<List<SmsMessage>> getUnread() async {
    return await dao.getUnread();
  }
  
  @override
  Future<void> markAsRead(String id) async {
    final sms = await getById(id);
    if (sms != null && !sms.isRead) {
      final updatedSms = sms.copyWith(isRead: true);
      await update(updatedSms);
    }
  }
  
  @override
  Future<void> markAllAsRead(String phoneNumberValue) async {
    try {
      final phoneNumber = PhoneNumber(phoneNumberValue);
      final messages = await getByPhoneNumber(phoneNumber.value);
      
      for (final message in messages) {
        if (!message.isRead) {
          final updatedMessage = message.copyWith(isRead: true);
          await update(updatedMessage);
        }
      }
    } catch (e) {
      // 如果电话号码格式无效，不执行任何操作
    }
  }
}