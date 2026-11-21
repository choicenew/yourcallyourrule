import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/sms/domain/sms_subscription.dart';
import 'package:yourcallyourrule/features/sms/repositories/sms_subscription_repository.dart';
import 'package:yourcallyourrule/features/sms/data/repositories/sms_subscription_repository_impl.dart';

part 'sms_subscriptions_provider.g.dart';

@Riverpod(keepAlive: true)
class SmsSubscriptionsNotifier extends _$SmsSubscriptionsNotifier {
  late final SmsSubscriptionRepository _smsSubscriptionRepository;

  @override
  Future<List<SmsSubscription>> build() async {
    _initRepository();
    return _loadSmsSubscriptions();
  }

  void _initRepository() {
    _smsSubscriptionRepository = ref.read(smsSubscriptionRepositoryProvider);
  }

  Future<List<SmsSubscription>> _loadSmsSubscriptions() async {
    try {
      return await _smsSubscriptionRepository.getAll();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return [];
    }
  }

  Future<void> addSmsSubscription(SmsSubscription subscription) async {
    state = const AsyncValue.loading();
    try {
      await _smsSubscriptionRepository.save(subscription);
      state = AsyncValue.data(await _loadSmsSubscriptions());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateSmsSubscription(SmsSubscription subscription) async {
    state = const AsyncValue.loading();
    try {
      await _smsSubscriptionRepository.update(subscription);
      state = AsyncValue.data(await _loadSmsSubscriptions());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteSmsSubscription(String subscriptionId) async {
    state = const AsyncValue.loading();
    try {
      await _smsSubscriptionRepository.deleteById(subscriptionId);
      state = AsyncValue.data(await _loadSmsSubscriptions());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> batchUpdateStatus(List<String> ids, bool isEnabled) async {
    state = const AsyncValue.loading();
    try {
      await _smsSubscriptionRepository.batchUpdateSmsStatus(ids, isEnabled);
      state = AsyncValue.data(await _loadSmsSubscriptions());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<SmsSubscription?> getByPhoneNumber(String number) async {
    try {
      return await _smsSubscriptionRepository.getByPhoneNumber(number);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateLastUpdated(String id, DateTime time) async {
    try {
      await _smsSubscriptionRepository.updateLastUpdated(id, time);
      state = AsyncValue.data(await _loadSmsSubscriptions());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<List<SmsSubscription>> getPendingUpdateSubscriptions() async {
    try {
      return await _smsSubscriptionRepository.getPendingUpdateSubscriptions();
    } catch (e) {
      return [];
    }
  }

  Future<int> clearExpiredSubscriptions() async {
    try {
      return await _smsSubscriptionRepository.clearExpiredSubscriptions();
    } catch (e) {
      return 0;
    }
  }
}
