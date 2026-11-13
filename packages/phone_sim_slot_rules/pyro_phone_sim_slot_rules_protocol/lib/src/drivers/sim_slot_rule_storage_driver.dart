import 'package:pyro_phone_sim_slot_rules_protocol/src/models/sim_slot_rule_entity.dart';

/// 卡槽规则持久化 Driver 抽象接口契约 (SimSlotRuleStorageDriver)
abstract class SimSlotRuleStorageDriver {
  Future<List<SimSlotRuleEntity>> getRulesBySimSlot(int simSlotIndex);
  Future<void> saveSimSlotRule(SimSlotRuleEntity rule);
  Future<void> deleteSimSlotRule(String ruleId);
  Future<List<SimSlotRuleEntity>> getAllRules();
}
