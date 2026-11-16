import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:pyro_phone_subscription_hub/pyro_phone_subscription_hub.dart';
import 'package:yourcallyourrule/features/phone_subscription/repositories/subscription_repository.dart';
import 'package:yourcallyourrule/features/phone_subscription/data/repositories/subscription_repository_impl.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'phone_subscription_service.g.dart';

/// PhoneSubscriptionService Riverpod Provider
@Riverpod(keepAlive: true)
PhoneSubscriptionService phoneSubscriptionService(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return PhoneSubscriptionService(
    SubscriptionRepositoryImpl(db),
    RuleRepositoryImpl(db),
  );
}

/// 电话规则订阅服务
class PhoneSubscriptionService {
  final SubscriptionRepository _repository;
  final RuleRepository _ruleRepository;
  final Uuid _uuid = const Uuid();

  PhoneSubscriptionService(
    this._repository,
    this._ruleRepository,
  );

  Future<List<PhoneSubscriptionPayload>> getAll() async {
    try {
      return await _repository.getAll();
    } catch (e) {
      return [];
    }
  }

  Future<List<PhoneSubscriptionPayload>> getEnabledSubscriptions() async {
    final all = await getAll();
    return all.where((s) => s.displayName != null).toList();
  }

  Future<PhoneSubscriptionPayload> addSubscription(String name, String url, {bool isEnabled = true}) async {
    final payloadId = _uuid.v4();
    final subscription = PhoneSubscriptionPayload(
      payloadId: payloadId,
      kind: PhoneSubscriptionKind.phoneRules,
      rawJsonMap: {
        'displayName': name,
        'downloadUrl': url,
        'isEnabled': isEnabled,
      },
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
    return await _repository.save(subscription);
  }

  Future<bool> deleteSubscription(String id) async {
    return await _repository.deleteById(id);
  }

  Future<List<PhoneRuleEntity>> updateRulesFromSubscription(PhoneSubscriptionPayload subscription) async {
    // 纯粹通过 pyro_phone_subscription_hub 分发，遵循 Package 规范
    await PhoneRulesSubscriptionControlCenter.instance.dispatchPayload(subscription);
    final rules = await _ruleRepository.getAll();
    return rules.where((r) => r.subscriptionId == subscription.payloadId).toList();
  }
}
