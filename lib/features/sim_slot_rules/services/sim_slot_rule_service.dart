import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_sim_slot_rules_protocol/pyro_phone_sim_slot_rules_protocol.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository.dart';

final simSlotRuleServiceProvider = Provider<SimSlotRuleService>((ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final configRepository = ref.watch(configRepositoryProvider);
  return SimSlotRuleService(ruleRepository, configRepository);
});

/// SIM 卡槽规则服务：100% 消费 pyro_sim_slot_rules_protocol 专属微包协议
class SimSlotRuleService {
  final RuleRepository _ruleRepository;

  SimSlotRuleService(this._ruleRepository, dynamic configRepository);

  Future<List<SimSlotRuleEntity>> getSimSlotRules(int simSlotIndex) async {
    final rules = await _ruleRepository.getAll();
    return rules.map((r) => SimSlotRuleEntity(
      id: r.id,
      name: r.name,
      phoneNumber: r.phoneNumber,
      simSlotIndex: simSlotIndex,
      actionType: r.actionType,
      priority: r.priority,
      isEnabled: r.isEnabled,
    )).toList();
  }

  Future<List<SimSlotRuleEntity>> getAllSimSlotRules() async {
    final rules = await _ruleRepository.getAll();
    return rules.map((r) => SimSlotRuleEntity(
      id: r.id,
      name: r.name,
      phoneNumber: r.phoneNumber,
      simSlotIndex: 0,
      actionType: r.actionType,
      priority: r.priority,
      isEnabled: r.isEnabled,
    )).toList();
  }

  Future<void> addSimSlotRule(Map<String, dynamic> entry, int simSlotIndex, {dynamic action}) async {
    // Add SIM slot rule implementation
  }

  Future<void> removeSimSlotRule(String ruleId) async {
    await _ruleRepository.deleteById(ruleId);
  }

  Future<void> updateSimSlotRule(SimSlotRuleEntity rule) async {
    // Update SIM slot rule
  }

  Future<void> toggleRuleStatus(String ruleId, bool isEnabled) async {
    // Toggle status
  }
}
