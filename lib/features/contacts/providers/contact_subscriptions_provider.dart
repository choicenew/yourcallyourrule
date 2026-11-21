import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:yourcallyourrule/features/contacts/repositories/contact_subscription_repository.dart';
import 'package:yourcallyourrule/features/contacts/data/repositories/contact_subscription_repository_impl.dart';

part 'contact_subscriptions_provider.g.dart';

/// 联系人订阅数据状态的 Notifier
@Riverpod(keepAlive: true)
class ContactSubscriptionsNotifier extends _$ContactSubscriptionsNotifier {
  late final ContactSubscriptionRepository _contactSubscriptionRepository;

  @override
  Future<List<PhoneSubscriptionPayload>> build() async {
    _initRepository();
    return _loadContactSubscriptions();
  }

  void _initRepository() {
    _contactSubscriptionRepository = ref.read(contactSubscriptionRepositoryProvider);
  }

  Future<List<PhoneSubscriptionPayload>> _loadContactSubscriptions() async {
    try {
      return await _contactSubscriptionRepository.getAll();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return [];
    }
  }

  Future<void> addContactSubscription(PhoneSubscriptionPayload subscription) async {
    state = const AsyncValue.loading();
    try {
      await _contactSubscriptionRepository.save(subscription);
      state = AsyncValue.data(await _loadContactSubscriptions());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateContactSubscription(PhoneSubscriptionPayload subscription) async {
    state = const AsyncValue.loading();
    try {
      await _contactSubscriptionRepository.update(subscription);
      state = AsyncValue.data(await _loadContactSubscriptions());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteContactSubscription(String subscriptionId) async {
    state = const AsyncValue.loading();
    try {
      await _contactSubscriptionRepository.deleteById(subscriptionId);
      state = AsyncValue.data(await _loadContactSubscriptions());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
