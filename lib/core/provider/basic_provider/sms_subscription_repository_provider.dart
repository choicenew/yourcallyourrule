import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_subscription.dart';
import 'package:yourcallyourrule/core/provider/datasource/local_subscription_datasource_provider.dart';
import 'package:yourcallyourrule/core/repositories/sms_subscription_repository.dart';
import 'package:yourcallyourrule/data/datasources/local/local_subscription_datasource.dart';
import 'package:yourcallyourrule/data/models/subscription_model.dart';

/// SMS订阅仓库提供者
final smsSubscriptionRepositoryProvider =
    Provider<SmsSubscriptionRepository>((ref) {
  final dataSource = ref.watch(localSubscriptionDataSourceProvider);
  return SmsSubscriptionRepositoryImpl(dataSource);
});

/// SMS订阅仓库实现类
class SmsSubscriptionRepositoryImpl implements SmsSubscriptionRepository {
  final LocalSubscriptionDataSource _dataSource;

  SmsSubscriptionRepositoryImpl(this._dataSource);

  @override
  Future<List<SmsSubscription>> getAll() async {
    final models = await _dataSource.getByType('sms');
    return models
        .whereType<SmsSubscriptionModel>()
        .map((m) => m.toEntity())
        .toList();
  }

  @override
  Future<SmsSubscription?> getById(String id) async {
    final model = await _dataSource.getById(id);
    if (model is SmsSubscriptionModel) {
      return model.toEntity();
    }
    return null;
  }

  @override
  Future<SmsSubscription> save(SmsSubscription entity) async {
    final model = SmsSubscriptionModel.fromEntity(entity);
    await _dataSource.insert(model);
    return entity;
  }

  @override
  Future<SmsSubscription> update(SmsSubscription entity) async {
    final model = SmsSubscriptionModel.fromEntity(entity);
    await _dataSource.update(model);
    return entity;
  }

  @override
  Future<bool> delete(SmsSubscription entity) async {
    final result = await _dataSource.delete(entity.id);
    return result > 0;
  }

  @override
  Future<bool> deleteById(String id) async {
    final result = await _dataSource.delete(id);
    return result > 0;
  }

  @override
  Future<bool> deleteAll(List<SmsSubscription> entities) async {
    final ids = entities.map((e) => e.id).toList();
    final result = await _dataSource.deleteAll(ids);
    return result > 0;
  }

  @override
  Future<List<SmsSubscription>> saveAll(List<SmsSubscription> entities) async {
    final models = entities.map((e) => SmsSubscriptionModel.fromEntity(e)).toList();
    await _dataSource.insertAll(models);
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
  SmsSubscription fromMap(Map<String, dynamic> map) {
    return SmsSubscription.fromMap(map);
  }

  @override
  Future<int> batchUpdateSmsStatus(List<String> ids, bool isEnabled) async {
    int count = 0;
    for (var id in ids) {
      final subscription = await getById(id);
      if (subscription != null) {
        final updatedSubscription = subscription.copyWith(isEnabled: isEnabled);
        await update(updatedSubscription);
        count++;
      }
    }
    return count;
  }

  @override
  Future<SmsSubscription?> getByPhoneNumber(String number) async {
    // This method is not directly supported by the new data source.
    // It might need a custom query in the data source or filtering here.
    // For now, returning null as a placeholder.
    return null;
  }

  @override
  Future<void> updateLastUpdated(String id, DateTime time) async {
    final subscription = await getById(id);
    if (subscription != null) {
      final updatedSubscription = subscription.copyWith(lastUpdated: time);
      await update(updatedSubscription);
    }
  }

  @override
  Future<List<SmsSubscription>> getPendingUpdateSubscriptions() async {
    final subscriptions = await getAllEnabled();
    final now = DateTime.now();
    return subscriptions.where((subscription) {
      if (subscription.lastUpdated == null) return true;
      final difference = now.difference(subscription.lastUpdated!);
      return difference.inHours >= 24; // 24-hour update interval
    }).toList();
  }

  @override
  Future<int> clearExpiredSubscriptions() async {
    final subscriptions = await getAll();
    final now = DateTime.now();
    final expiredSubscriptions = subscriptions.where((subscription) {
      if (subscription.lastUpdated == null) return false;
      final difference = now.difference(subscription.lastUpdated!);
      return difference.inDays >= 30; // 30-day expiration
    }).toList();

    await deleteAll(expiredSubscriptions);

    return expiredSubscriptions.length;
  }

  @override
  Future<List<SmsSubscription>> getAllEnabled() async {
    final all = await getAll();
    return all.where((s) => s.isEnabled).toList();
  }

  @override
  Future<List<SmsSubscription>> getByType(String type) async {
    // Assuming type is always 'sms' for this repository
    if (type == 'sms') {
      return getAll();
    }
    return [];
  }

  @override
  Future<SmsSubscription?> getByName(String name) async {
    final all = await getAll();
    try {
      return all.firstWhere((s) => s.name == name);
    } catch (e) {
      return null;
    }
  }
}
