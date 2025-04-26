import 'package:yourcallyourrule/core/entities/sms/sms_subscription.dart';
import 'package:yourcallyourrule/core/repositories/base_repository.dart';

abstract class SmsSubscriptionRepository extends BaseRepository<SmsSubscription, String> {
  // 短信订阅特有方法
  Future<int> batchUpdateSmsStatus(List<String> ids, bool isEnabled);
  
  // 根据手机号查询订阅
  Future<SmsSubscription?> getByPhoneNumber(String number);
  
  // 继承核心订阅仓库的通用方法
  Future<void> updateLastUpdated(String id, DateTime time);
  
  Future<List<SmsSubscription>> getPendingUpdateSubscriptions();
  
  Future<int> clearExpiredSubscriptions();
}