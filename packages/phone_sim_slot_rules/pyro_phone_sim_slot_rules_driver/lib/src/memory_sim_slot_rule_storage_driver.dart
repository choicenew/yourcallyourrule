import 'package:flutter/foundation.dart';
import 'package:pyro_phone_sim_slot_rules_protocol/pyro_phone_sim_slot_rules_protocol.dart';

/// 真实内存级卡槽规则持久化驱动 (MemorySimSlotRuleStorageDriver)
class MemorySimSlotRuleStorageDriver implements SimSlotRuleStorageDriver {
  final Map<String, SimSlotRuleEntity> _rules = {};

  MemorySimSlotRuleStorageDriver();

  @override
  Future<List<SimSlotRuleEntity>> getRulesBySimSlot(int simSlotIndex) async {
    return _rules.values.where((r) => r.simSlotIndex == simSlotIndex).toList();
  }

  @override
  Future<void> saveSimSlotRule(SimSlotRuleEntity rule) async {
    _rules[rule.id] = rule;
    debugPrint('[MemorySimSlotRuleDriver] 持久化保存卡槽规则: ${rule.name} -> 卡槽 ${rule.simSlotIndex}');
  }

  @override
  Future<void> deleteSimSlotRule(String ruleId) async {
    _rules.remove(ruleId);
  }

  @override
  Future<List<SimSlotRuleEntity>> getAllRules() async {
    return _rules.values.toList();
  }
}
