import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_type.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';

part 'sim_slot_rule_filter_service.g.dart';

@riverpod
SimSlotRuleFilterService simSlotRuleFilterService(Ref ref) {
  return SimSlotRuleFilterService(
    simSlotRuleService: ref.watch(simSlotRuleServiceProvider),
  );
}

/// SIM 卡槽位规则过滤服务
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

  Future<bool> shouldAcceptCallWithSim(String phoneNumber, {SimInfo? simInfo}) {
    return shouldAcceptCall(phoneNumber, simInfo: simInfo);
  }

  @override
  Future<void> initialize() async {
    return;
  }
}
