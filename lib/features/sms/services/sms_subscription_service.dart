import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'package:yourcallyourrule/features/sms/repositories/sms_subscription_repository.dart';
import 'package:yourcallyourrule/features/rules/repositories/rule_repository.dart';

part 'sms_subscription_service.g.dart';

/// SmsSubscriptionService Riverpod Provider
@Riverpod(keepAlive: true)
SmsSubscriptionService smsSubscriptionService(Ref ref) {
  final smsSubscriptionRepository = ref.watch(smsSubscriptionRepositoryProvider);
  final ruleRepository = ref.watch(ruleRepositoryProvider);

  return SmsSubscriptionService(
    smsSubscriptionRepository,
    ruleRepository,
  );
}

/// 短信规则订阅服务
class SmsSubscriptionService {
  final SmsSubscriptionRepository _repository;
  final RuleRepository _ruleRepository;
  final Uuid _uuid = const Uuid();

  SmsSubscriptionService(
    this._repository,
    this._ruleRepository,
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

  Future<void> updateRulesFromSubscription(SmsSubscription subscription) async {
    await _repository.updateLastUpdated(subscription.id, DateTime.now());
  }

  Future<bool> deleteSubscription(String id) async {
    return await _repository.deleteById(id);
  }
}
