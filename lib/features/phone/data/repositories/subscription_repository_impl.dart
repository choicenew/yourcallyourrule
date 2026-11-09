import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:yourcallyourrule/features/phone/repositories/subscription_repository.dart';
import 'package:yourcallyourrule/features/phone/data/datasources/local_subscription_datasource.dart';

part 'subscription_repository_impl.g.dart';

@Riverpod(keepAlive: true)
SubscriptionRepository subscriptionRepository(Ref ref) {
  final dataSource = ref.watch(localSubscriptionDataSourceProvider);
  return SubscriptionRepositoryImpl(dataSource);
}

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final LocalSubscriptionDataSource _dataSource;

  SubscriptionRepositoryImpl(this._dataSource);

  @override
  Future<List<PhoneSubscriptionPayload>> getAll() async {
    return await _dataSource.getAll();
  }

  @override
  Future<PhoneSubscriptionPayload?> getById(String id) async {
    return await _dataSource.getById(id);
  }

  @override
  Future<PhoneSubscriptionPayload> save(PhoneSubscriptionPayload entity) async {
    await _dataSource.insert(entity);
    return entity;
  }

  @override
  Future<PhoneSubscriptionPayload> update(PhoneSubscriptionPayload entity) async {
    await _dataSource.update(entity);
    return entity;
  }

  @override
  Future<bool> delete(PhoneSubscriptionPayload entity) async {
    return await deleteById(entity.payloadId);
  }

  @override
  Future<bool> deleteById(String id) async {
    final result = await _dataSource.delete(id);
    return result > 0;
  }

  @override
  Future<bool> deleteAll(List<PhoneSubscriptionPayload> entities) async {
    final ids = entities.map((e) => e.payloadId).toList();
    final result = await _dataSource.deleteAll(ids);
    return result > 0;
  }

  @override
  Future<int> count() async {
    final items = await getAll();
    return items.length;
  }

  @override
  Future<PhoneSubscriptionPayload?> getByUrl(String url) async {
    return await _dataSource.getByUrl(url);
  }
}
