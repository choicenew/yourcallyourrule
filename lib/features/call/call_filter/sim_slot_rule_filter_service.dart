import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/data/models/sim_slot_rule_model.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
// 导入依赖的 Provider
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/sim_slot_config_provider.dart';

part 'sim_slot_rule_filter_service.g.dart';

@riverpod
SimSlotRuleService simSlotRuleService(Ref ref) {
  return SimSlotRuleService(
    ruleRepository: ref.watch(ruleRepositoryProvider),
    ref: ref,
  );
}

/// SIM卡槽位规则服务 (无状态)
class SimSlotRuleService implements CallFilterInterface {
  final RuleRepository _ruleRepository;
  final Ref _ref;

  SimSlotRuleService({required RuleRepository ruleRepository, required Ref ref})
    : _ruleRepository = ruleRepository,
      _ref = ref;

  @override
  Future<bool> shouldAcceptCall(String phoneNumber) async {
    return true; // 默认接受，因为没有SIM卡信息
  }
/// 判断是否应该接受来电（带SIM卡信息）
  Future<bool> shouldAcceptCallWithSim(
    String phoneNumber, {
    SimInfo? simInfo,
  }) async {
    if (simInfo == null || simInfo.simSlotIndex == null) return true;

    final config = await _ref.read(simSlotConfigProvider.future);
    final isEnabled =
        config.simSlotFilterEnabled[simInfo.simSlotIndex!] ?? false;
// 检查该SIM卡槽位的过滤器是否启用
    if (!isEnabled) return true;
  // 获取该SIM卡槽位的所有规则
    final rules = await getSimSlotRules(simInfo.simSlotIndex!);
   // 检查号码是否匹配任何规则
    for (var rule in rules) {
      if (rule.matches(phoneNumber)) {
         // 如果匹配规则且规则动作为阻止，则拒绝来电
        if (rule.action == RuleAction.block) return false;
  // 如果匹配规则且规则动作为允许，则接受来电
        if (rule.action == RuleAction.allow) return true;
      }
    }

    // 默认接受来电
    return true;
  }

  /// 初始化服务
  @override
  Future<void> initialize() async {
    // 配置由Notifier自动加载，此方法可留空
    return;
  }

  // --- 其他方法保持不变 ---

  Future<SimSlotRule> addSimSlotRule(
    String phoneNumber,
    int simSlotIndex, {
    String name = '',
    String labelId = '',
    RuleAction action = RuleAction.block,
  }) async {
    final rule = SimSlotRule(
      id: const Uuid().v4(),
      name: name.isEmpty ? 'SIM slot$simSlotIndex' : name,
      priority: const RulePriority(10), // 默认优先级
      action: action,
      phoneNumber: PhoneNumber.fromString(phoneNumber),
      simSlotIndex: simSlotIndex,
      labelId: labelId,
    );
    
    // 保存规则
    final model = SimSlotRuleModel.fromEntity(rule);
    await _ruleRepository.saveRule(model);
    return rule;
  }

  /// 移除SIM卡槽位规则
  Future<void> removeSimSlotRule(String ruleId) async {
    await _ruleRepository.deleteRule(ruleId);
  }

  /// 获取指定SIM卡槽位的所有规则
  Future<List<SimSlotRule>> getSimSlotRules(int simSlotIndex) async {
    // 获取所有SIM卡槽位规则
    final allRules = await _ruleRepository.getRulesByType('sim_slot');
    
    // 过滤出指定SIM卡槽位的规则
    final simSlotRules = allRules
        .whereType<SimSlotRuleModel>()
        .where((rule) => rule.simSlotIndex == simSlotIndex)
        .map((model) => model.toEntity())
        .toList();
    
    return simSlotRules;
  }

  /// 获取所有SIM卡槽位规则
  Future<List<SimSlotRule>> getAllSimSlotRules() async {
    // 获取所有SIM卡槽位规则
    final allRules = await _ruleRepository.getRulesByType('sim_slot');
    
    // 转换为实体
    final simSlotRules = allRules
        .whereType<SimSlotRuleModel>()
        .map((model) => model.toEntity())
        .toList();
    
    return simSlotRules;
  }

  /// 清除指定SIM卡槽位的所有规则
  Future<void> clearSimSlotRules(int simSlotIndex) async {
    final rules = await getSimSlotRules(simSlotIndex);
    for (var rule in rules) {
      await removeSimSlotRule(rule.id);
    }
  }

  Future<void> clearAllSimSlotRules() async {
    final rules = await getAllSimSlotRules();
    for (var rule in rules) {
      await removeSimSlotRule(rule.id);
    }
  }
}
