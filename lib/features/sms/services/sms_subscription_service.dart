import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/features/sms/domain/sms_subscription.dart';
import 'package:yourcallyourrule/features/sms/repositories/sms_subscription_repository.dart';

part 'sms_subscription_service.g.dart';

@Riverpod(keepAlive: true)
SmsSubscriptionService smsSubscriptionService(Ref ref) {
  final smsSubscriptionRepository = ref.watch(smsSubscriptionRepositoryProvider);

  return SmsSubscriptionService(
    smsSubscriptionRepository,
  );
}

class SmsSubscriptionService {
  final SmsSubscriptionRepository _repository;
  final Uuid _uuid = const Uuid();

  SmsSubscriptionService(
    this._repository,
  );

  Future<List<SmsSubscription>> getAll() async {
    return await _repository.getAll();
  }

  Future<List<SmsSubscription>> getEnabledSubscriptions() async {
    return await _repository.getAllEnabled();
  }

  Future<SmsSubscription> addSubscription(String name, String url, {bool isEnabled = true}) async {
    final subscription = SmsSubscription(
      id: _uuid.v4(),
      name: name,
      url: url,
      isEnabled: isEnabled,
      lastUpdated: DateTime.now(),
    );
    return await _repository.save(subscription);
  }

  Future<SmsSubscription> save(SmsSubscription subscription) async {
    return await _repository.save(subscription);
  }

  Future<void> enableSubscription(SmsSubscription subscription) async {
    await _repository.update(subscription.copyWith(isEnabled: true));
  }

  Future<void> disableSubscription(SmsSubscription subscription) async {
    await _repository.update(subscription.copyWith(isEnabled: false));
  }

  Future<void> updateRulesFromSubscription(SmsSubscription subscription) async {
    await _repository.updateLastUpdated(subscription.id, DateTime.now());
  }

  Future<bool> deleteSubscription(String id) async {
    return await _repository.deleteById(id);
  }
}
