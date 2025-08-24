import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription.dart';
import 'package:yourcallyourrule/core/provider/datasource/local_subscription_datasource_provider.dart';
import 'package:yourcallyourrule/core/repositories/subscription_repository.dart';
import 'package:yourcallyourrule/data/datasources/local/local_subscription_datasource.dart';
import 'package:yourcallyourrule/data/models/subscription_model.dart';


/// 订阅仓库提供者
final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  final dataSource = ref.watch(localSubscriptionDataSourceProvider);
  return SubscriptionRepositoryImpl(dataSource);
});

/// 订阅仓库实现类
class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final LocalSubscriptionDataSource _dataSource;

  SubscriptionRepositoryImpl(this._dataSource);

  @override
  Future<List<Subscription>> getAll() async {
    final models = await _dataSource.getAll();
    return models
        .whereType<SubscriptionModel>()
        .map((m) => m.toEntity())
        .toList();
  }

  @override
  Future<Subscription?> getById(String id) async {
    final model = await _dataSource.getById(id);
    if (model is SubscriptionModel) {
      return model.toEntity();
    }
    return null;
  }

  @override
  Future<Subscription> save(Subscription entity) async {
    final model = SubscriptionModel.fromEntity(entity);
    await _dataSource.insert(model);
    return entity;
  }

  @override
  Future<Subscription> update(Subscription entity) async {
    final model = SubscriptionModel.fromEntity(entity);
    await _dataSource.update(model);
    return entity;
  }

  @override
  Future<bool> delete(Subscription entity) async {
    final result = await _dataSource.delete(entity.id);
    return result > 0;
  }

  @override
  Future<bool> deleteById(String id) async {
    final result = await _dataSource.delete(id);
    return result > 0;
  }

  @override
  Future<bool> deleteAll(List<Subscription> entities) async {
    final ids = entities.map((e) => e.id).toList();
    final result = await _dataSource.deleteAll(ids);
    return result > 0;
  }

  @override
  Future<List<Subscription>> saveAll(List<Subscription> entities) async {
    final models =
        entities.map((e) => SubscriptionModel.fromEntity(e)).toList();
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
    final models = await _dataSource.getAll();
    return models.length;
  }

  @override
  Subscription fromMap(Map<String, dynamic> map) {
    return SubscriptionModel.fromMap(map).toEntity();
  }

  Future<List<Subscription>> getByType(String type) async {
    final models = await _dataSource.getByType(type);
    return models
        .whereType<SubscriptionModel>()
        .map((m) => m.toEntity())
        .toList();
  }

  Future<List<Subscription>> getAllEnabled() async {
    final models = await _dataSource.getEnabledSubscriptions();
    return models
        .whereType<SubscriptionModel>()
        .map((m) => m.toEntity())
        .toList();
  }

  Future<Subscription?> getByName(String name) async {
    final models = await _dataSource.getByName(name);
    if (models != null && models.isNotEmpty) {
      final subscriptionModels = models.whereType<SubscriptionModel>();
      if (subscriptionModels.isNotEmpty) {
        return subscriptionModels.first.toEntity();
      }
    }
    return null;
  }

  @override
  Future<Subscription?> getByUrl(String url) async {
    final model = await _dataSource.getByUrl(url);
    if (model is SubscriptionModel) {
      return model.toEntity();
    }
    return null;
  }

  @override
  Future<int> batchUpdateStatus(List<String> ids, bool isEnabled) async {
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
  Future<void> updateLastUpdated(String id, DateTime time) async {
    final subscription = await getById(id);
    if (subscription != null) {
      final updatedSubscription = subscription.copyWith(lastUpdated: time);
      await update(updatedSubscription);
    }
  }

  @override
  Future<List<Subscription>> getPendingUpdateSubscriptions() async {
    final subscriptions = await _dataSource.getAutoUpdateSubscriptions();
    return subscriptions
        .whereType<SubscriptionModel>()
        .map((m) => m.toEntity())
        .toList();
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
}