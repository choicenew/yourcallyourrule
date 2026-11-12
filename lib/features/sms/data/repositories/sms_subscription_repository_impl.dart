import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/sms/domain/sms_subscription.dart';
import 'package:yourcallyourrule/features/sms/repositories/sms_subscription_repository.dart';
import 'package:yourcallyourrule/features/phone_subscription/data/datasources/local_subscription_datasource.dart';

final smsSubscriptionRepositoryProvider = Provider<SmsSubscriptionRepository>((ref) {
  final dataSource = ref.watch(localSubscriptionDataSourceProvider);
  return SmsSubscriptionRepositoryImpl(dataSource);
});

class SmsSubscriptionRepositoryImpl implements SmsSubscriptionRepository {
  final LocalSubscriptionDataSource _dataSource;

  SmsSubscriptionRepositoryImpl(this._dataSource);

  @override
  Future<List<SmsSubscription>> getAll() async {
    return [];
  }

  @override
  Future<List<SmsSubscription>> getAllEnabled() async {
    return [];
  }

  @override
  Future<SmsSubscription?> getById(String id) async {
    return null;
  }

  @override
  Future<SmsSubscription> save(SmsSubscription entity) async {
    return entity;
  }

  @override
  Future<SmsSubscription> update(SmsSubscription entity) async {
    return entity;
  }

  @override
  Future<bool> deleteById(String id) async {
    final result = await _dataSource.delete(id);
    return result > 0;
  }

  @override
  Future<bool> deleteAll(List<String> ids) async {
    return true;
  }

  @override
  Future<int> batchUpdateSmsStatus(List<String> ids, bool isEnabled) async {
    return 0;
  }

  @override
  Future<SmsSubscription?> getByPhoneNumber(String number) async {
    return null;
  }

  @override
  Future<void> updateLastUpdated(String id, DateTime time) async {}

  @override
  Future<List<SmsSubscription>> getPendingUpdateSubscriptions() async {
    return [];
  }

  @override
  Future<int> clearExpiredSubscriptions() async {
    return 0;
  }
}
