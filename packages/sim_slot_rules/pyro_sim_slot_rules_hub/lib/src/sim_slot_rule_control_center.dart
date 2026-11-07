import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_sim_slot_rules_protocol/pyro_sim_slot_rules_protocol.dart';

part 'sim_slot_rule_control_center.g.dart';

@Riverpod(keepAlive: true)
SimSlotRuleControlCenter simSlotRuleControlCenter(Ref ref) {
  return SimSlotRuleControlCenter.instance;
}

/// 卡槽规则中枢控制中心 (SimSlotRuleControlCenter)
class SimSlotRuleControlCenter {
  static final SimSlotRuleControlCenter instance = SimSlotRuleControlCenter._();

  SimSlotRuleControlCenter._();

  SimSlotRuleStorageDriver? _storageDriver;

  void registerStorageDriver(SimSlotRuleStorageDriver driver) {
    _storageDriver = driver;
    debugPrint('[SimSlotRuleHub] 已挂载注册存储驱动: ${driver.runtimeType}');
  }

  SimSlotRuleStorageDriver? get storageDriver => _storageDriver;

  Future<List<SimSlotRuleEntity>> getRulesBySimSlot(int simSlotIndex) async {
    return await _storageDriver?.getRulesBySimSlot(simSlotIndex) ?? [];
  }

  Future<void> saveSimSlotRule(SimSlotRuleEntity rule) async {
    await _storageDriver?.saveSimSlotRule(rule);
    debugPrint('[SimSlotRuleHub] 中枢保存卡槽规则: ${rule.name} -> 卡槽 ${rule.simSlotIndex}');
  }
}
