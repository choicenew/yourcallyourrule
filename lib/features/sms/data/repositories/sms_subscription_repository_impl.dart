import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'package:yourcallyourrule/features/sms/repositories/sms_subscription_repository.dart';
import 'package:yourcallyourrule/features/phone_subscription/data/datasources/local_subscription_datasource.dart';

part 'sms_subscription_repository_impl.g.dart';

@Riverpod(keepAlive: true)
SmsSubscriptionRepository smsSubscriptionRepository(Ref ref) {
  final dataSource = ref.watch(localSubscriptionDataSourceProvider);
  return SmsSubscriptionRepositoryImpl(dataSource);
}

class SmsSubscriptionRepositoryImpl implements SmsSubscriptionRepository {
  final LocalSubscriptionDataSource _dataSource;

  SmsSubscriptionRepositoryImpl(this._dataSource);

  @override
  Future<List<SmsSubscriptionPayload>> getAll() async {
    return [];
  }

  @override
  Future<SmsSubscriptionPayload?> getById(String id) async {
    return null;
  }

  @override
  Future<SmsSubscriptionPayload> save(SmsSubscriptionPayload entity) async {
    return entity;
  }

  @override
  Future<SmsSubscriptionPayload> update(SmsSubscriptionPayload entity) async {
    return entity;
  }

  @override
  Future<bool> delete(SmsSubscriptionPayload entity) async {
    return true;
  }

  @override
  Future<bool> deleteById(String id) async {
    final result = await _dataSource.delete(id);
    return result > 0;
  }

  @override
  Future<bool> deleteAll(List<SmsSubscriptionPayload> entities) async {
    return true;
  }

  @override
  Future<List<SmsSubscriptionPayload>> saveAll(List<SmsSubscriptionPayload> entities) async {
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final model = await _dataSource.getById(id);
    return model != null;
  }

  @override
  Future<int> count() async {
    final models = await _dataSource.getByType('sms');
    return models.length;
  }

  @override
  SmsSubscriptionPayload fromMap(Map<String, dynamic> map) {
    return SmsSubscriptionPayload.fromMap(map);
  }

  @override
  Future<int> batchUpdateSmsStatus(List<String> ids, bool isEnabled) async {
    return 0;
  }

  @override
  Future<SmsSubscriptionPayload?> getByPhoneNumber(String number) async {
    return null;
  }

  @override
  Future<void> updateLastUpdated(String id, DateTime time) async {}

  @override
  Future<List<SmsSubscriptionPayload>> getPendingUpdateSubscriptions() async {
    return [];
  }

  @override
  Future<int> clearExpiredSubscriptions() async {
    return 0;
  }

  @override
  Future<List<SmsSubscriptionPayload>> getAllEnabled() async {
    return [];
  }

  @override
  Future<List<SmsSubscriptionPayload>> getByType(String type) async {
    return [];
  }

  @override
  Future<SmsSubscriptionPayload?> getByName(String name) async {
    return null;
  }
}
