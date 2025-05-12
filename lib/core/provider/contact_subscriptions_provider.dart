import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/subscription/contact_subscription.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/contact_subscription_repository_provider.dart';
import 'package:yourcallyourrule/core/repositories/contact_subscription_repository.dart';


/// 联系人订阅数据状态的Notifier类
class ContactSubscriptionsNotifier extends AsyncNotifier<List<ContactSubscription>> {
  late final ContactSubscriptionRepository _contactSubscriptionRepository;

  @override
  Future<List<ContactSubscription>> build() async {
    // 初始化仓库
    _initRepository();
    // 加载所有联系人订阅
    return _loadContactSubscriptions();
  }

  void _initRepository() {
    // 获取仓库实例
    _contactSubscriptionRepository = ref.read(contactSubscriptionRepositoryProvider);
  }

  Future<List<ContactSubscription>> _loadContactSubscriptions() async {
    try {
      // 获取所有联系人订阅
      return await _contactSubscriptionRepository.getAll();
    } catch (e) {
      // 错误处理
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  /// 添加联系人订阅
  Future<void> addContactSubscription(ContactSubscription subscription) async {
    state = const AsyncValue.loading();
    try {
      await _contactSubscriptionRepository.save(subscription);
      state = AsyncValue.data(await _loadContactSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 更新联系人订阅
  Future<void> updateContactSubscription(ContactSubscription subscription) async {
    state = const AsyncValue.loading();
    try {
      await _contactSubscriptionRepository.update(subscription);
      state = AsyncValue.data(await _loadContactSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 删除联系人订阅
  Future<void> deleteContactSubscription(String subscriptionId) async {
    state = const AsyncValue.loading();
    try {
      await _contactSubscriptionRepository.deleteById(subscriptionId);
      state = AsyncValue.data(await _loadContactSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  /// 批量更新联系人订阅状态
  Future<void> batchUpdateStatus(List<String> ids, bool isEnabled) async {
    state = const AsyncValue.loading();
    try {
      await _contactSubscriptionRepository.batchUpdateStatus(ids, isEnabled);
      state = AsyncValue.data(await _loadContactSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  /// 根据URL获取订阅
  Future<ContactSubscription?> getByUrl(String url) async {
    try {
      return await _contactSubscriptionRepository.getByUrl(url);
    } catch (e) {
      return null;
    }
  }
  
  /// 根据联系人名称获取订阅
  Future<List<ContactSubscription>> getByContactName(String name) async {
    try {
      return await _contactSubscriptionRepository.getByContactName(name);
    } catch (e) {
      return [];
    }
  }
  
  /// 更新最后更新时间
  Future<void> updateLastUpdated(String id, DateTime time) async {
    try {
      await _contactSubscriptionRepository.updateLastUpdated(id, time);
      state = AsyncValue.data(await _loadContactSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  /// 获取待更新的订阅
  Future<List<ContactSubscription>> getPendingUpdateSubscriptions() async {
    try {
      return await _contactSubscriptionRepository.getPendingUpdateSubscriptions();
    } catch (e) {
      return [];
    }
  }
  
  /// 清除过期订阅
  Future<int> clearExpiredSubscriptions() async {
    try {
      return await _contactSubscriptionRepository.clearExpiredSubscriptions();
    } catch (e) {
      return 0;
    }
  }
}

/// 联系人订阅数据提供者
final contactSubscriptionsProvider = AsyncNotifierProvider<ContactSubscriptionsNotifier, List<ContactSubscription>>(() {
  return ContactSubscriptionsNotifier();
});