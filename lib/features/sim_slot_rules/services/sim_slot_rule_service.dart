import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';

import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/services/import_export_service.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

part 'sim_slot_rule_service.g.dart';

// [重构]: Provider 现在正确地注入了它所需要的所有 Repository 依赖。
@Riverpod(keepAlive: true)
SimSlotRuleService simSlotRuleService(Ref ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final configRepository = ref.watch(configRepositoryProvider);
  return SimSlotRuleService(ruleRepository, configRepository);
}

/// [重构]: SIM卡槽位规则服务，现在是一个独立的业务逻辑服务，架构与 RuleManagementService 对齐。
/// [修正]: 彻底移除 `extends ListService`。
class SimSlotRuleService {
  final RuleRepository _ruleRepository;
  final ConfigRepository _configRepository;
  final RuleImportExportService _importExportService;

  static const String _configKey = 'config_sim_slot_filter_enabled';

  // [重构]: 构造函数接收所有必需的 Repository。
  SimSlotRuleService(this._ruleRepository, this._configRepository)
      : _importExportService = RuleImportExportService(_ruleRepository);

  /// 获取导入导出服务
  RuleImportExportService get importExportService => _importExportService;

  // [注释]: 检查、启用、禁用过滤器的逻辑。
  Future<bool> isSimSlotFilterEnabled(int simSlotIndex) async {
    final configMap = await _configRepository.getConfig(_configKey);
    return configMap?[simSlotIndex.toString()] as bool? ?? false;
  }

  Future<void> enableSimSlotFilter(int simSlotIndex) async {
    final configMap = await _configRepository.getConfig(_configKey) ?? {};
    final newConfig = Map<String, dynamic>.from(configMap);
    newConfig[simSlotIndex.toString()] = true;
    await _configRepository.saveConfig(_configKey, newConfig);
  }

  Future<void> disableSimSlotFilter(int simSlotIndex) async {
    final configMap = await _configRepository.getConfig(_configKey) ?? {};
    final newConfig = Map<String, dynamic>.from(configMap);
    newConfig[simSlotIndex.toString()] = false;
    await _configRepository.saveConfig(_configKey, newConfig);
  }

  /// [恢复]: 添加 SIM 卡槽位规则
  Future<void> addSimSlotRule(
    ListEntry entry,
    int simSlotIndex, {
    RuleAction action = RuleAction.block,
  }) async {
    final rule = SimSlotRule(
      id: const Uuid().v4(),
      name: entry.name,
      action: action,
      phoneNumber: entry.phoneNumber,
      labelId: entry.labelId,
      avatar: entry.avatar,
      simSlotIndex: simSlotIndex,
      priority: _defaultPriority(action),
      isEnabled: true,
    );
    await _ruleRepository.saveRule(rule);
  }

  /// [恢复]: 根据 SIM 卡槽位索引获取规则
  Future<List<SimSlotRule>> getSimSlotRules(int simSlotIndex) async {
    final rules = await _ruleRepository.getAll();
    return rules
        .whereType<SimSlotRule>()
        .where((r) => r.simSlotIndex == simSlotIndex)
        .toList();
  }
  
  /// [恢复]: 获取所有 SIM 卡槽位规则
  Future<List<SimSlotRule>> getAllSimSlotRules() async {
    final rules = await _ruleRepository.getAll();
    return rules.whereType<SimSlotRule>().toList();
  }

  /// [恢复]: 获取所有规则（按动作类型分类）
  Future<List<SimSlotRule>> getAllRulesByActionType(RuleActionType? actionType) async {
    final rules = await getAllSimSlotRules();
    if (actionType == null) return rules;
    return rules.where((r) => r.action.type == actionType).toList();
  }
  
  /// [恢复]: 切换规则状态
  Future<void> toggleRuleStatus(String ruleId, bool isEnabled) async {
    final rule = await _ruleRepository.getRuleById(ruleId);
    if (rule != null && rule is SimSlotRule) {
      final updatedRule = rule.copyWith(isEnabled: isEnabled);
      await _ruleRepository.updateRule(updatedRule);
    }
  }

  /// [恢复]: 删除规则
  Future<void> removeSimSlotRule(String ruleId) async {
    await _ruleRepository.deleteRule(ruleId);
  }

  /// [恢复]: 更新规则
  Future<void> updateSimSlotRule(SimSlotRule rule) async {
    await _ruleRepository.updateRule(rule);
  }

  /// [恢复]: 根据动作类型筛选规则
  Future<List<SimSlotRule>> getRulesByAction(RuleAction action) async {
    final rules = await getAllSimSlotRules();
    return rules.where((r) => r.action == action).toList();
  }

  /// [恢复]: 导出所有 SIM 卡槽位规则到文件
  Future<bool> exportSimSlotRulesToFile(String filePath) async {
    final rules = await getAllSimSlotRules();
    return await _importExportService.exportToFile(filePath, entities: rules);
  }

  /// [恢复]: 从文件导入 SIM 卡槽位规则
  Future<List<SimSlotRule>> importSimSlotRulesFromFile(
    String filePath, {
    bool overwrite = false,
  }) async {
    final imported = await _importExportService.importFromFile(
      filePath,
      mode: overwrite ? ImportMode.overwrite : ImportMode.merge,
    );
    return imported.whereType<SimSlotRule>().toList();
  }
  
  /// [恢复]: 从 URL 导入 SIM 卡槽位规则
  Future<List<SimSlotRule>> importSimSlotRulesFromUrl(String url) async {
    final imported = await _importExportService.importFromUrl(url);
    return imported.whereType<SimSlotRule>().toList();
  }
  
  /// [恢复]: 获取所有标签
  Future<List<String>> getAllLabels() async {
    final rules = await getAllSimSlotRules();
    final labels = <String>{};
    for (final rule in rules) {
      if (rule.labelId.isNotEmpty) {
        labels.add(rule.labelId);
      }
    }
    return labels.toList();
  }

  /// [恢复]: 清除指定 SIM 卡槽位的所有规则
  Future<void> clearSimSlotRules(int simSlotIndex) async {
    final rules = await getSimSlotRules(simSlotIndex);
for (final rule in rules) {
      await removeSimSlotRule(rule.id);
    }
  }

  /// [恢复]: 清除所有 SIM 卡槽位规则
  Future<void> clearAllSimSlotRules() async {
    final rules = await getAllSimSlotRules();
    for (final rule in rules) {
      await removeSimSlotRule(rule.id);
    }
  }

  RulePriority _defaultPriority(RuleAction action) {
    switch (action.type) {
      case RuleActionType.allow: return RulePriority.aboveMedium;
      case RuleActionType.block: return RulePriority.belowMedium;
      case RuleActionType.silence: return RulePriority.silenceAction;
      default: return RulePriority.noneAction;
    }
  }
}