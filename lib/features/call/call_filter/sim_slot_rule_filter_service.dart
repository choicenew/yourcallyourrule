import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_type.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';

part 'sim_slot_rule_filter_service.g.dart';

// [重构]: Provider 注入依赖的 SimSlotRuleService。
@riverpod
SimSlotRuleFilterService simSlotRuleFilterService(Ref ref) {
  return SimSlotRuleFilterService(
    simSlotRuleService: ref.watch(simSlotRuleServiceProvider),
  );
}

/// [重构]: SIM卡槽位规则 *过滤* 服务 (无状态)
/// 它只负责实现 CallFilterInterface 接口的过滤逻辑。
class SimSlotRuleFilterService implements CallFilterInterface {
  final SimSlotRuleService _simSlotRuleService;

  SimSlotRuleFilterService({
    required SimSlotRuleService simSlotRuleService,
  }) : _simSlotRuleService = simSlotRuleService;

  @override
  CallFilterType get filterType => CallFilterType.simSlotRule;

  @override
  Future<bool> shouldAcceptCall(String phoneNumber, {SimInfo? simInfo}) async {
    if (simInfo == null || simInfo.simSlotIndex == null) {
      return true;
    }

    final rules = await _simSlotRuleService.getSimSlotRules(simInfo.simSlotIndex!);

    for (var rule in rules) {
      if (rule.matches(phoneNumber)) {
        if (rule.action.type == RuleActionType.block) return false;
        if (rule.action.type == RuleActionType.allow) return true;
      }
    }

    return true;
  }

  /// 保持向后兼容的方法
  Future<bool> shouldAcceptCallWithSim(String phoneNumber, {SimInfo? simInfo}) {
    return shouldAcceptCall(phoneNumber, simInfo: simInfo);
  }

  @override
  Future<void> initialize() async {
    return;
  }
}