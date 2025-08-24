import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/subscription/contact_subscription.dart';
import 'package:yourcallyourrule/core/repositories/contact_subscription_repository.dart';
import 'package:yourcallyourrule/data/datasources/local/local_subscription_datasource.dart';
import 'package:yourcallyourrule/data/models/subscription_model.dart';

import '../datasource/local_subscription_datasource_provider.dart';

/// 联系人订阅仓库提供者
final contactSubscriptionRepositoryProvider =
    Provider<ContactSubscriptionRepository>((ref) {
  final localSubscriptionDataSource = ref.watch(localSubscriptionDataSourceProvider);
  // 返回联系人订阅仓库实现
  return ContactSubscriptionRepositoryImpl(localSubscriptionDataSource);
});

/// 联系人订阅仓库实现类
class ContactSubscriptionRepositoryImpl implements ContactSubscriptionRepository {
  final LocalSubscriptionDataSource _dataSource;

  ContactSubscriptionRepositoryImpl(this._dataSource);

  @override
  Future<List<ContactSubscription>> getAll() async {
    final models = await _dataSource.queryAll();
    return models
        .whereType<ContactSubscriptionModel>()
        .map((model) => ContactSubscription.fromMap(model.toMap()))
        .toList();
  }

  @override
  Future<ContactSubscription?> getById(String id) async {
    final model = await _dataSource.queryById(id);
    if (model == null) return null;
    return ContactSubscription.fromMap(model.toMap());
  }

  @override
  Future<ContactSubscription> save(ContactSubscription entity) async {
    await _dataSource.insert(ContactSubscriptionModel.fromMap(entity.toMap()));
    return entity;
  }

  @override
  Future<ContactSubscription> update(ContactSubscription entity) async {
    await _dataSource.update(ContactSubscriptionModel.fromMap(entity.toMap()));
    return entity;
  }

  @override
  Future<bool> delete(ContactSubscription entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _dataSource.delete(id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<ContactSubscription> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  @override
  Future<List<ContactSubscription>> saveAll(
      List<ContactSubscription> entities) async {
    for (var entity in entities) {
      await save(entity);
    }
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final subscriptions = await getAll();
    return subscriptions.length;
  }

  @override
  ContactSubscription fromMap(Map<String, dynamic> map) {
    return ContactSubscription.fromMap(map);
  }

  Future<List<ContactSubscription>> getByType(String type) async {
    final models = await _dataSource.getByType(type);
    return models
        .whereType<ContactSubscriptionModel>()
        .map((model) => ContactSubscription.fromMap(model.toMap()))
        .toList();
  }

  Future<List<ContactSubscription>> getAllEnabled() async {
    final models = await _dataSource.getEnabledSubscriptions();
    return models
        .whereType<ContactSubscriptionModel>()
        .map((model) => ContactSubscription.fromMap(model.toMap()))
        .toList();
  }

  Future<ContactSubscription?> getByName(String name) async {
    final models = await _dataSource.getByName(name);
    if (models.isEmpty) return null;
    return ContactSubscription.fromMap(models.first.toMap());
  }

  @override
  Future<ContactSubscription?> getByUrl(String url) async {
    final model = await _dataSource.getByUrl(url);
    if (model == null) return null;
    return ContactSubscription.fromMap(model.toMap());
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
  Future<List<ContactSubscription>> getPendingUpdateSubscriptions() async {
    // 获取所有启用的订阅
    final subscriptions = await getAllEnabled();
    // 筛选出需要更新的订阅（例如：最后更新时间超过一定时间）
    final now = DateTime.now();
    return subscriptions.where((subscription) {
      final difference = now.difference(subscription.lastUpdated);
      return difference.inHours >= 24; // 假设24小时更新一次
    }).toList();
  }

  @override
  Future<int> clearExpiredSubscriptions() async {
    // 获取所有订阅
    final subscriptions = await getAll();
    // 筛选出过期的订阅（例如：最后更新时间超过30天）
    final now = DateTime.now();
    final expiredSubscriptions = subscriptions.where((subscription) {
      final difference = now.difference(subscription.lastUpdated);
      return difference.inDays >= 30; // 假设30天为过期时间
    }).toList();

    // 删除过期的订阅
    for (var subscription in expiredSubscriptions) {
      await delete(subscription);
    }

    return expiredSubscriptions.length;
  }

  @override
  Future<List<ContactSubscription>> getByContactName(String name) async {
    final models = await _dataSource.getByContactName(name);
    return models
        .whereType<ContactSubscriptionModel>()
        .map((model) => ContactSubscription.fromMap(model.toMap()))
        .toList();
  }
}