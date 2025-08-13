// SIM卡槽位规则服务，用于管理SIM卡槽位规则

import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/data/models/sim_slot_rule_model.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';

/// SIM卡槽位规则服务
/// 用于管理SIM卡槽位规则，实现CallFilterInterface接口
class SimSlotRuleService implements CallFilterInterface {
  final RuleRepository _ruleRepository;
  final ConfigRepository _configRepository;
  
  // 存储SIM卡槽位配置
  Map<int, bool> _simSlotFilterEnabled = {};

  SimSlotRuleService({
    required RuleRepository ruleRepository,
    required ConfigRepository configRepository,
  }) : _ruleRepository = ruleRepository,
       _configRepository = configRepository;

  @override
  Future<bool> shouldAcceptCall(String phoneNumber) async {
    // 默认接受来电，因为没有SIM卡信息
    return true;
  }
  
  /// 判断是否应该接受来电（带SIM卡信息）
  Future<bool> shouldAcceptCallWithSim(String phoneNumber, {SimInfo? simInfo}) async {
    // 如果没有SIM卡信息，则默认接受
    if (simInfo == null || simInfo.simSlotIndex == null) {
      return true;
    }
    
    // 检查该SIM卡槽位的过滤器是否启用
    if (!isSimSlotFilterEnabled(simInfo.simSlotIndex!)) {
      return true; // 如果未启用，则接受所有来电
    }
    
    // 获取该SIM卡槽位的所有规则
    final rules = await getSimSlotRules(simInfo.simSlotIndex!);
    
    // 检查号码是否匹配任何规则
    for (var rule in rules) {
      if (rule.matches(phoneNumber)) {
        // 如果匹配规则且规则动作为阻止，则拒绝来电
        if (rule.action == RuleAction.block) {
          return false;
        }
        // 如果匹配规则且规则动作为允许，则接受来电
        if (rule.action == RuleAction.allow) {
          return true;
        }
      }
    }
    
    // 默认接受来电
    return true;
  }

  /// 初始化服务
  @override
  Future<void> initialize() async {
    await loadSimSlotFilterConfig();
  }

  static const String _configKey = 'config_sim_slot_filter_enabled';

  /// 加载SIM卡槽位过滤器配置
  Future<void> loadSimSlotFilterConfig() async {
    final configMap = await _configRepository.getConfig(_configKey);
    if (configMap != null) {
      _simSlotFilterEnabled = Map<int, bool>.from(
        configMap.map((key, value) => MapEntry(
              int.parse(key),
              value as bool,
            )),
      );
    }
  }

  /// 保存SIM卡槽位过滤器配置
  Future<void> saveSimSlotFilterConfig() async {
    final configMap = _simSlotFilterEnabled.map(
      (key, value) => MapEntry(key.toString(), value),
    );
    await _configRepository.saveConfig(_configKey, configMap);
  }

  /// 启用指定SIM卡槽位的过滤器
  Future<void> enableSimSlotFilter(int simSlotIndex) async {
    _simSlotFilterEnabled[simSlotIndex] = true;
    await saveSimSlotFilterConfig();
  }

  /// 禁用指定SIM卡槽位的过滤器
  Future<void> disableSimSlotFilter(int simSlotIndex) async {
    _simSlotFilterEnabled[simSlotIndex] = false;
    await saveSimSlotFilterConfig();
  }

  /// 检查指定SIM卡槽位的过滤器是否启用
  bool isSimSlotFilterEnabled(int simSlotIndex) {
    return _simSlotFilterEnabled[simSlotIndex] ?? false;
  }

  /// 添加SIM卡槽位规则
  Future<SimSlotRule> addSimSlotRule(String phoneNumber, int simSlotIndex, {String name = '', String labelId = '', RuleAction action = RuleAction.block}) async {
    // 创建新规则
    final rule = SimSlotRule(
      id: const Uuid().v4(),
      name: name.isEmpty ? 'SIM槽位$simSlotIndex规则' : name,
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

  /// 清除所有SIM卡槽位规则
  Future<void> clearAllSimSlotRules() async {
    final rules = await getAllSimSlotRules();
    for (var rule in rules) {
      await removeSimSlotRule(rule.id);
    }
  }
}