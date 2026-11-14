import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';

part 'rule_management_service.g.dart';

/// RuleManagementService Riverpod Provider
@Riverpod(keepAlive: true)
RuleManagementService ruleManagementService(Ref ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  return RuleManagementService(ruleRepository);
}

/// 规则管理服务类，提供各种动作类型规则的管理功能
class RuleManagementService {
  final RuleRepository _ruleRepository;
  final Uuid _uuid = const Uuid();

  RuleManagementService(this._ruleRepository);

  Future<void> addPhoneRule(String name, PhoneNumber phoneNumber, RuleAction action) async {
    final rule = PhoneRuleEntity(
      id: _uuid.v4(),
      name: name,
      phoneNumber: phoneNumber.value,
      actionType: action.type.name,
    );
    await _ruleRepository.saveRule(rule);
  }

  Future<void> removeRule(String ruleId) async {
    await _ruleRepository.deleteRule(ruleId);
  }

  Future<List<PhoneRuleEntity>> getAllRulesByActionType(RuleActionType? actionType) async {
    final rules = await _ruleRepository.getAll();
    if (actionType == null) {
      return rules;
    }
    return rules.where((r) => r.actionType == actionType.name).toList();
  }

  Future<List<PhoneRuleEntity>> getRulesByActionType(PhoneNumber phoneNumber, RuleAction? action) async {
    final rules = await _ruleRepository.getAll();
    return rules.where((rule) {
      final matchesNumber = rule.phoneNumber == phoneNumber.value;
      final matchesAction = action == null || rule.actionType == action.type.name;
      return matchesNumber && matchesAction && rule.isEnabled;
    }).toList();
  }

  Future<List<PhoneRuleEntity>> getRulesByPhoneNumber(PhoneNumber phoneNumber) async {
    final rules = await _ruleRepository.getAll();
    return rules.where((rule) => rule.phoneNumber == phoneNumber.value && rule.isEnabled).toList();
  }

  Future<void> updatePhoneNumberRule(PhoneRuleEntity rule) async {
    await _ruleRepository.updateRule(rule);
  }

  Future<void> toggleRuleStatus(String ruleId, bool isEnabled) async {
    await _ruleRepository.updateEnabledStatus(ruleId, isEnabled);
  }

  Future<List<PhoneRuleEntity>> getAllRules() async {
    return await _ruleRepository.getAll();
  }
}
