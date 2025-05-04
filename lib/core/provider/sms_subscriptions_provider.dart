import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_subscription.dart';
import 'package:yourcallyourrule/core/repositories/sms_subscription_repository.dart';
import 'providers.dart';

/// 短信订阅数据状态的Notifier类
class SmsSubscriptionsNotifier extends AsyncNotifier<List<SmsSubscription>> {
  late final SmsSubscriptionRepository _smsSubscriptionRepository;

  @override
  Future<List<SmsSubscription>> build() async {
    // 初始化仓库
    _initRepository();
    // 加载所有短信订阅
    return _loadSmsSubscriptions();
  }

  void _initRepository() {
    // 获取仓库实例
    _smsSubscriptionRepository = ref.read(smsSubscriptionRepositoryProvider);
  }

  Future<List<SmsSubscription>> _loadSmsSubscriptions() async {
    try {
      // 获取所有短信订阅
      return await _smsSubscriptionRepository.getAll();
    } catch (e) {
      // 错误处理
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  /// 添加短信订阅
  Future<void> addSmsSubscription(SmsSubscription subscription) async {
    state = const AsyncValue.loading();
    try {
      await _smsSubscriptionRepository.save(subscription);
      state = AsyncValue.data(await _loadSmsSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 更新短信订阅
  Future<void> updateSmsSubscription(SmsSubscription subscription) async {
    state = const AsyncValue.loading();
    try {
      await _smsSubscriptionRepository.update(subscription);
      state = AsyncValue.data(await _loadSmsSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 删除短信订阅
  Future<void> deleteSmsSubscription(String subscriptionId) async {
    state = const AsyncValue.loading();
    try {
      await _smsSubscriptionRepository.deleteById(subscriptionId);
      state = AsyncValue.data(await _loadSmsSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  /// 批量更新短信订阅状态
  Future<void> batchUpdateStatus(List<String> ids, bool isEnabled) async {
    state = const AsyncValue.loading();
    try {
      await _smsSubscriptionRepository.batchUpdateSmsStatus(ids, isEnabled);
      state = AsyncValue.data(await _loadSmsSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  /// 根据手机号获取订阅
  Future<SmsSubscription?> getByPhoneNumber(String number) async {
    try {
      return await _smsSubscriptionRepository.getByPhoneNumber(number);
    } catch (e) {
      return null;
    }
  }
  
  /// 更新最后更新时间
  Future<void> updateLastUpdated(String id, DateTime time) async {
    try {
      await _smsSubscriptionRepository.updateLastUpdated(id, time);
      state = AsyncValue.data(await _loadSmsSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  /// 获取待更新的订阅
  Future<List<SmsSubscription>> getPendingUpdateSubscriptions() async {
    try {
      return await _smsSubscriptionRepository.getPendingUpdateSubscriptions();
    } catch (e) {
      return [];
    }
  }
  
  /// 清除过期订阅
  Future<int> clearExpiredSubscriptions() async {
    try {
      return await _smsSubscriptionRepository.clearExpiredSubscriptions();
    } catch (e) {
      return 0;
    }
  }
}

/// 短信订阅数据提供者
final smsSubscriptionsProvider = AsyncNotifierProvider<SmsSubscriptionsNotifier, List<SmsSubscription>>(() {
  return SmsSubscriptionsNotifier();
});