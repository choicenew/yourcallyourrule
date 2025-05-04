import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/subscription/contact_subscription.dart';
import 'package:yourcallyourrule/core/repositories/contact_subscription_repository.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';

import 'database_service_provider.dart';

/// 联系人订阅仓库提供者
final contactSubscriptionRepositoryProvider =
    Provider<ContactSubscriptionRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // 返回联系人订阅仓库实现
  return ContactSubscriptionRepositoryImpl(databaseService);
});

/// 联系人订阅仓库实现类
class ContactSubscriptionRepositoryImpl implements ContactSubscriptionRepository {
  final DatabaseService _databaseService;

  ContactSubscriptionRepositoryImpl(this._databaseService);

  @override
  Future<List<ContactSubscription>> getAll() async {
    final maps = await _databaseService.queryAll('contact_subscriptions');
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<ContactSubscription?> getById(String id) async {
    final map = await _databaseService.queryById('contact_subscriptions', id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<ContactSubscription> save(ContactSubscription entity) async {
    await _databaseService.insert('contact_subscriptions', entity.toMap());
    return entity;
  }

  @override
  Future<ContactSubscription> update(ContactSubscription entity) async {
    await _databaseService.update('contact_subscriptions', entity.id, entity.toMap());
    return entity;
  }

  @override
  Future<bool> delete(ContactSubscription entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('contact_subscriptions', id);
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
  Future<List<ContactSubscription>> saveAll(List<ContactSubscription> entities) async {
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
    final maps = await _databaseService.queryWhere('contact_subscriptions', 'type', type);
    return maps.map((map) => fromMap(map)).toList();
  }

  Future<List<ContactSubscription>> getAllEnabled() async {
    final maps = await _databaseService.queryWhere('contact_subscriptions', 'isEnabled', true);
    return maps.map((map) => fromMap(map)).toList();
  }

  Future<ContactSubscription?> getByName(String name) async {
    final maps = await _databaseService.queryWhere('contact_subscriptions', 'name', name);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }

  @override
  Future<ContactSubscription?> getByUrl(String url) async {
    final maps = await _databaseService.queryWhere('contact_subscriptions', 'url', url);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
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
    final maps = await _databaseService.queryWhere('contact_subscriptions', 'contactName', name);
    return maps.map((map) => fromMap(map)).toList();
  }
}