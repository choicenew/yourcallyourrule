import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/subscription_repository_provider.dart';
import 'package:yourcallyourrule/core/repositories/subscription_repository.dart';


/// 订阅数据状态的Notifier类
class SubscriptionsNotifier extends AsyncNotifier<List<Subscription>> {
  late final SubscriptionRepository _subscriptionRepository;

  @override
  Future<List<Subscription>> build() async {
    // 初始化仓库
    _initRepository();
    // 加载所有订阅
    return _loadSubscriptions();
  }

  void _initRepository() {
    // 获取仓库实例
    _subscriptionRepository = ref.read(subscriptionRepositoryProvider);
  }

  Future<List<Subscription>> _loadSubscriptions() async {
    try {
      // 获取所有订阅
      return await _subscriptionRepository.getAll();
    } catch (e) {
      // 错误处理
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  /// 添加订阅
  Future<void> addSubscription(Subscription subscription) async {
    state = const AsyncValue.loading();
    try {
      await _subscriptionRepository.save(subscription);
      state = AsyncValue.data(await _loadSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 更新订阅
  Future<void> updateSubscription(Subscription subscription) async {
    state = const AsyncValue.loading();
    try {
      await _subscriptionRepository.update(subscription);
      state = AsyncValue.data(await _loadSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 删除订阅
  Future<void> deleteSubscription(String subscriptionId) async {
    state = const AsyncValue.loading();
    try {
      await _subscriptionRepository.deleteById(subscriptionId);
      state = AsyncValue.data(await _loadSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  /// 批量更新订阅状态
  Future<void> batchUpdateStatus(List<String> ids, bool isEnabled) async {
    state = const AsyncValue.loading();
    try {
      await _subscriptionRepository.batchUpdateStatus(ids, isEnabled);
      state = AsyncValue.data(await _loadSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  /// 根据URL获取订阅
  Future<Subscription?> getByUrl(String url) async {
    try {
      return await _subscriptionRepository.getByUrl(url);
    } catch (e) {
      return null;
    }
  }
  
  /// 更新最后更新时间
  Future<void> updateLastUpdated(String id, DateTime time) async {
    try {
      await _subscriptionRepository.updateLastUpdated(id, time);
      state = AsyncValue.data(await _loadSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  /// 获取待更新的订阅
  Future<List<Subscription>> getPendingUpdateSubscriptions() async {
    try {
      return await _subscriptionRepository.getPendingUpdateSubscriptions();
    } catch (e) {
      return [];
    }
  }
  
  /// 清除过期订阅
  Future<int> clearExpiredSubscriptions() async {
    try {
      return await _subscriptionRepository.clearExpiredSubscriptions();
    } catch (e) {
      return 0;
    }
  }
}

/// 订阅数据提供者
final subscriptionsProvider = AsyncNotifierProvider<SubscriptionsNotifier, List<Subscription>>(() {
  return SubscriptionsNotifier();
});