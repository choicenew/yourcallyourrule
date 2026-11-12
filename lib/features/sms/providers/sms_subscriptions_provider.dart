import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'package:yourcallyourrule/features/sms/repositories/sms_subscription_repository.dart';
import 'package:yourcallyourrule/features/sms/data/repositories/sms_subscription_repository_impl.dart';

class SmsSubscriptionsNotifier extends AsyncNotifier<List<SmsSubscriptionPayload>> {
  late final SmsSubscriptionRepository _smsSubscriptionRepository;

  @override
  Future<List<SmsSubscriptionPayload>> build() async {
    _initRepository();
    return _loadSmsSubscriptions();
  }

  void _initRepository() {
    _smsSubscriptionRepository = ref.read(smsSubscriptionRepositoryProvider);
  }

  Future<List<SmsSubscriptionPayload>> _loadSmsSubscriptions() async {
    try {
      return await _smsSubscriptionRepository.getAll();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  Future<void> addSmsSubscription(SmsSubscriptionPayload subscription) async {
    state = const AsyncValue.loading();
    try {
      await _smsSubscriptionRepository.save(subscription);
      state = AsyncValue.data(await _loadSmsSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateSmsSubscription(SmsSubscriptionPayload subscription) async {
    state = const AsyncValue.loading();
    try {
      await _smsSubscriptionRepository.update(subscription);
      state = AsyncValue.data(await _loadSmsSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteSmsSubscription(String subscriptionId) async {
    state = const AsyncValue.loading();
    try {
      await _smsSubscriptionRepository.deleteById(subscriptionId);
      state = AsyncValue.data(await _loadSmsSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  Future<void> batchUpdateStatus(List<String> ids, bool isEnabled) async {
    state = const AsyncValue.loading();
    try {
      await _smsSubscriptionRepository.batchUpdateSmsStatus(ids, isEnabled);
      state = AsyncValue.data(await _loadSmsSubscriptions());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  Future<SmsSubscriptionPayload?> getByPhoneNumber(String number) async {
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
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  Future<List<SmsSubscriptionPayload>> getPendingUpdateSubscriptions() async {
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

final smsSubscriptionsProvider = AsyncNotifierProvider<SmsSubscriptionsNotifier, List<SmsSubscriptionPayload>>(() {
  return SmsSubscriptionsNotifier();
});
