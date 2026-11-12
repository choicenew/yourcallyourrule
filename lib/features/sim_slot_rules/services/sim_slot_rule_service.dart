import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository.dart';

part 'sim_slot_rule_service.g.dart';

@Riverpod(keepAlive: true)
SimSlotRuleService simSlotRuleService(Ref ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final configRepository = ref.watch(configRepositoryProvider);
  return SimSlotRuleService(ruleRepository, configRepository);
}

class SimSlotRuleService {
  final RuleRepository _ruleRepository;

  SimSlotRuleService(this._ruleRepository, dynamic configRepository);

  Future<List<PhoneRuleEntity>> getSimSlotRules(int simSlotIndex) async {
    final rules = await _ruleRepository.getAll();
    return rules.where((r) => r.simSlotIndex == simSlotIndex).toList();
  }

  Future<List<PhoneRuleEntity>> getAllSimSlotRules() async {
    final rules = await _ruleRepository.getAll();
    return rules;
  }

  Future<PhoneRuleEntity> addSimSlotRule(
    dynamic entry,
    int simSlotIndex, {
    required dynamic action,
  }) async {
    final uuid = const Uuid();
    final rule = PhoneRuleEntity(
      id: uuid.v4(),
      simSlotIndex: simSlotIndex,
      action: action as RuleActionPayload,
      phoneNumber: entry.phoneNumber as String? ?? '',
      labelId: entry.labelId as String? ?? '',
      avatar: entry.avatar as String?,
    );
    await _ruleRepository.saveRule(rule);
    return rule;
  }

  Future<void> removeSimSlotRule(String ruleId) async {
    await _ruleRepository.deleteRule(ruleId);
  }

  Future<void> updateSimSlotRule(PhoneRuleEntity rule) async {
    await _ruleRepository.saveRule(rule);
  }

  Future<void> toggleRuleStatus(String ruleId, bool isEnabled) async {
    final rules = await _ruleRepository.getAll();
    final rule = rules.firstWhere((r) => r.id == ruleId);
    final updatedRule = rule.copyWith(isEnabled: isEnabled);
    await _ruleRepository.saveRule(updatedRule);
  }
}
