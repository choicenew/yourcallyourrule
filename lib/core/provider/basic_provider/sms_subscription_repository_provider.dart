import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_subscription.dart';
import 'package:yourcallyourrule/core/repositories/sms_subscription_repository.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';

import 'database_service_provider.dart';

/// SMS订阅仓库提供者
final smsSubscriptionRepositoryProvider =
    Provider<SmsSubscriptionRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // 返回SMS订阅仓库实现
  return SmsSubscriptionRepositoryImpl(databaseService);
});

/// SMS订阅仓库实现类
class SmsSubscriptionRepositoryImpl implements SmsSubscriptionRepository {
  final DatabaseService _databaseService;

  SmsSubscriptionRepositoryImpl(this._databaseService);

  @override
  Future<List<SmsSubscription>> getAll() async {
    final maps = await _databaseService.queryAll('sms_subscriptions');
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<SmsSubscription?> getById(String id) async {
    final map = await _databaseService.queryById('sms_subscriptions', id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<SmsSubscription> save(SmsSubscription entity) async {
    await _databaseService.insert('sms_subscriptions', entity.toMap());
    return entity;
  }

  @override
  Future<SmsSubscription> update(SmsSubscription entity) async {
    await _databaseService.update(
        'sms_subscriptions', entity.id, entity.toMap());
    return entity;
  }

  @override
  Future<bool> delete(SmsSubscription entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('sms_subscriptions', id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<SmsSubscription> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  @override
  Future<List<SmsSubscription>> saveAll(List<SmsSubscription> entities) async {
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
    final maps = await _databaseService.queryWhere(
        'sms_subscriptions', 'phoneNumber', number);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
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
    // 获取所有启用的订阅
    final subscriptions = await getAllEnabled();
    // 筛选出需要更新的订阅（例如：最后更新时间超过一定时间）
    final now = DateTime.now();
    return subscriptions.where((subscription) {
      if (subscription.lastUpdated == null) return true;
      final difference = now.difference(subscription.lastUpdated!);
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
      if (subscription.lastUpdated == null) return false;
      final difference = now.difference(subscription.lastUpdated!);
      return difference.inDays >= 30; // 假设30天为过期时间
    }).toList();

    // 删除过期的订阅
    for (var subscription in expiredSubscriptions) {
      await delete(subscription);
    }

    return expiredSubscriptions.length;
  }

  @override
  Future<List<SmsSubscription>> getAllEnabled() async {
    final maps = await _databaseService.queryWhere(
        'sms_subscriptions', 'isEnabled', true);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<List<SmsSubscription>> getByType(String type) async {
    final maps =
        await _databaseService.queryWhere('sms_subscriptions', 'type', type);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<SmsSubscription?> getByName(String name) async {
    final maps =
        await _databaseService.queryWhere('sms_subscriptions', 'name', name);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }
}
