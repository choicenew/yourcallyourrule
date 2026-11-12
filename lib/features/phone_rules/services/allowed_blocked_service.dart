import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';

part 'allowed_blocked_service.g.dart';

/// AllowedBlockedService 的 @Riverpod Provider
@Riverpod(keepAlive: true)
AllowedBlockedService allowedBlockedService(Ref ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  return AllowedBlockedService(ruleRepository);
}

class AllowedBlockedService {
  final RuleRepository _ruleRepository;
  final Uuid _uuid = const Uuid();

  AllowedBlockedService(this._ruleRepository);

  Future<void> addAllowedBlockedRule(String name, PhoneNumber phoneNumber, RuleAction action) async {
    final rule = PhoneRuleEntity(
      id: _uuid.v4(),
      name: name,
      phoneNumber: phoneNumber.value,
      actionType: action.type.name,
    );
    await _ruleRepository.saveRule(rule);
  }

  Future<List<PhoneRuleEntity>> getAllAllowedRules() async {
    final rules = await _ruleRepository.getAll();
    return rules.where((r) => r.actionType == RuleActionType.allow.name && r.isEnabled).toList();
  }

  Future<List<PhoneRuleEntity>> getAllBlockedRules() async {
    final rules = await _ruleRepository.getAll();
    return rules.where((r) => r.actionType == RuleActionType.block.name && r.isEnabled).toList();
  }

  Future<List<PhoneRuleEntity>> getRulesByActionType(PhoneNumber phoneNumber, RuleAction? action) async {
    final rules = await _ruleRepository.getAll();
    return rules.where((rule) {
      final matchesNumber = rule.phoneNumber == phoneNumber.value;
      final matchesAction = action == null || rule.actionType == action.type.name;
      return matchesNumber && matchesAction && rule.isEnabled;
    }).toList();
  }

  Future<void> removeRule(String ruleId) async {
    await _ruleRepository.deleteRule(ruleId);
  }

  Future<void> updateAllowedBlockedRule(PhoneRuleEntity rule) async {
    await _ruleRepository.updateRule(rule);
  }

  Future<void> toggleRuleStatus(String ruleId, bool isEnabled) async {
    await _ruleRepository.updateEnabledStatus(ruleId, isEnabled);
  }

  Future<bool?> shouldAcceptCall(PhoneNumber phoneNumber) async {
    if (await isInAllowed(phoneNumber)) return true;
    if (await isInBlocked(phoneNumber)) return false;
    return null;
  }

  Future<bool> isInAllowed(PhoneNumber phoneNumber) async {
    final allowed = await getAllAllowedRules();
    return allowed.any((r) => r.phoneNumber == phoneNumber.value);
  }

  Future<bool> isInBlocked(PhoneNumber phoneNumber) async {
    final blocked = await getAllBlockedRules();
    return blocked.any((r) => r.phoneNumber == phoneNumber.value);
  }
}
