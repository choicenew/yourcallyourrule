import 'package:yourcallyourrule/features/sms/domain/sms_subscription.dart';

abstract class SmsSubscriptionRepository {
  Future<List<SmsSubscription>> getAll();
  Future<List<SmsSubscription>> getAllEnabled();
  Future<SmsSubscription?> getById(String id);
  Future<SmsSubscription> save(SmsSubscription entity);
  Future<SmsSubscription> update(SmsSubscription entity);
  Future<bool> deleteById(String id);
  Future<bool> deleteAll(List<String> ids);
  Future<int> batchUpdateSmsStatus(List<String> ids, bool isEnabled);
  Future<SmsSubscription?> getByPhoneNumber(String number);
  Future<void> updateLastUpdated(String id, DateTime time);
  Future<List<SmsSubscription>> getPendingUpdateSubscriptions();
  Future<int> clearExpiredSubscriptions();
}
