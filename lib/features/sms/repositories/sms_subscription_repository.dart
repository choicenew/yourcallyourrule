import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
// base_repository removed

abstract class SmsSubscriptionRepository extends BaseRepository<SmsSubscription, String> {
  // 短信订阅特有方法
  Future<int> batchUpdateSmsStatus(List<String> ids, bool isEnabled);
  
  // 根据手机号查询订�?
  Future<SmsSubscription?> getByPhoneNumber(String number);
  
  // 继承核心订阅仓库的通用方法
  Future<void> updateLastUpdated(String id, DateTime time);
  
  Future<List<SmsSubscription>> getPendingUpdateSubscriptions();
  
  Future<int> clearExpiredSubscriptions();
}