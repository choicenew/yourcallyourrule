import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';

// [注释]: 导入我们需要的 Provider
import 'package:yourcallyourrule/features/call/call_filter/providers/sim_slot_config_provider.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';


part 'sim_slot_rule_filter_service.g.dart';

// [重构]: Provider 现在只提供 Filter Service 实例。
@riverpod
SimSlotRuleFilterService simSlotRuleFilterService(Ref ref) {
  return SimSlotRuleFilterService(ref: ref);
}

/// [重构]: SIM卡槽位规则 *过滤* 服务 (无状态)
/// 它只负责实现 CallFilterInterface 接口的过滤逻辑。
class SimSlotRuleFilterService implements CallFilterInterface {
  final Ref _ref;

  SimSlotRuleFilterService({required Ref ref}) : _ref = ref;

  @override
  Future<bool> shouldAcceptCall(String phoneNumber) async {
    // [注释]: 当没有 SIM 信息时，这个过滤器不执行任何操作，直接允许通过。
    return true;
  }

  /// [注释]: 这是这个过滤器的核心逻辑。
  Future<bool> shouldAcceptCallWithSim(String phoneNumber, {SimInfo? simInfo}) async {
    if (simInfo == null || simInfo.simSlotIndex == null) {
      return true;
    }

    // 1. 从 Notifier 获取最新的启用/禁用配置
    final config = await _ref.read(simSlotConfigProvider.future);
    final isEnabled = config.simSlotFilterEnabled[simInfo.simSlotIndex!] ?? false;

    if (!isEnabled) {
      return true; // 如果此SIM卡的过滤器被禁用，则直接允许通过
    }

    // 2. 从 SimSlotRuleService 获取规则列表
    // [修正]: 我们依赖于已经存在的、职责单一的 SimSlotRuleService。
    final ruleService = _ref.read(simSlotRuleServiceProvider);
    final rules = await ruleService.getSimSlotRules(simInfo.simSlotIndex!);

    // 3. 执行匹配逻辑
    for (var rule in rules) {
      if (rule.matches(phoneNumber)) {
        if (rule.action.type == RuleActionType.block) return false;
        if (rule.action.type == RuleActionType.allow) return true;
      }
    }

    // [注释]: 如果没有匹配到任何阻止或允许规则，则默认允许通过。
    return true;
  }

  @override
  Future<void> initialize() async {
    // [注释]: 此方法可以留空，因为所有初始化都由 Provider 自动处理。
    return;
  }
}