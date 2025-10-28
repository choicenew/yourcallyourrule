import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';

import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/services/import_export_service.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
part 'sim_slot_rule_service.g.dart';
/// SIM卡槽位规则服务
/// 结构对齐 AllowedBlockedService：基于 RuleRepository 和 RuleImportExportService
class SimSlotRuleService extends ListService {
  final RuleRepository _ruleRepository;
  final RuleImportExportService _importExportService;
  final SharedPreferences _prefs;
  static const String _simSlotFilterEnabledPrefix = 'sim_slot_filter_enabled_';

  SimSlotRuleService(this._ruleRepository, this._prefs)
      : _importExportService = RuleImportExportService(_ruleRepository),
        super(_ruleRepository);

  /// 获取导入导出服务
  RuleImportExportService get importExportService => _importExportService;

  /// 添加 SIM 卡槽位规则
  Future<void> addSimSlotRule(
    ListEntry entry,
    int simSlotIndex, {
    RuleAction action = RuleAction.block,
  }) async {
    final rule = SimSlotRule(
      id: const Uuid().v4(),
      name: entry.name.isEmpty ? 'SIM ${simSlotIndex + 1}' : entry.name,
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

  Future<bool> isSimSlotFilterEnabled(int simSlotIndex) async {
    return _prefs.getBool('$_simSlotFilterEnabledPrefix$simSlotIndex') ?? false;
  }

  Future<void> enableSimSlotFilter(int simSlotIndex) async {
    await _prefs.setBool('$_simSlotFilterEnabledPrefix$simSlotIndex', true);
  }

  Future<void> disableSimSlotFilter(int simSlotIndex) async {
    await _prefs.setBool('$_simSlotFilterEnabledPrefix$simSlotIndex', false);
  }

  // Invalidate the provider to refetch the filter state
  void invalidateFilterProvider(WidgetRef ref, int simSlotIndex) {
    ref.invalidate(isSimSlotFilterEnabledProvider(simSlotIndex));
  }

  /// 根据 SIM 卡槽位索引获取规则
  Future<List<SimSlotRule>> getSimSlotRules(int simSlotIndex) async {
    final rules = await _ruleRepository.getAll();
    return rules
        .whereType<SimSlotRule>()
        .where((r) => r.simSlotIndex == simSlotIndex)
        .toList();
  }

  /// 获取所有 SIM 卡槽位规则
  Future<List<SimSlotRule>> getAllSimSlotRules() async {
    final rules = await _ruleRepository.getAll();
    return rules.whereType<SimSlotRule>().toList();
  }

  /// 获取所有规则（按动作类型分类）
  Future<List<SimSlotRule>> getAllRulesByActionType(
    RuleActionType? actionType,
  ) async {
    final rules = await getAllSimSlotRules();
    if (actionType == null) return rules;
    return rules.where((r) => r.action.type == actionType).toList();
  }

  /// 切换规则状态
  Future<void> toggleRuleStatus(String ruleId, bool isEnabled) async {
    final rule = await _ruleRepository.getRuleById(ruleId) as SimSlotRule?;
    if (rule != null) {
      final updatedRule = rule.copyWith(isEnabled: isEnabled);
      await _ruleRepository.updateRule(updatedRule);
    }
  }

  /// 删除规则
  Future<void> removeSimSlotRule(String ruleId) async {
    await _ruleRepository.deleteRule(ruleId);
  }

  /// 更新规则
  Future<void> updateSimSlotRule(SimSlotRule rule) async {
    await _ruleRepository.updateRule(rule);
  }

  /// 根据动作类型筛选规则（示例方法，便于页面复用）
  Future<List<SimSlotRule>> getRulesByActionType(RuleAction action) async {
    final rules = await getAllSimSlotRules();
    return rules.where((r) => r.action == action).toList();
  }

  /// 导出所有 SIM 卡槽位规则到文件
  Future<bool> exportSimSlotRulesToFile(String filePath) async {
    final rules = await getAllSimSlotRules();
    return await _importExportService.exportToFile(filePath, entities: rules);
  }

  /// 从文件导入 SIM 卡槽位规则
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

  /// 从 URL 导入 SIM 卡槽位规则
  Future<List<SimSlotRule>> importSimSlotRulesFromUrl(String url) async {
    final imported = await _importExportService.importFromUrl(url);
    return imported.whereType<SimSlotRule>().toList();
  }

  /// 获取所有标签
  Future<List<String>> getAllLabels() async {
    final rules = await getAllSimSlotRules();
    final labels = <String>{};
    for (final rule in rules) {
      labels.add(rule.labelId);
    }
    return labels.toList();
  }

  /// 清除指定 SIM 卡槽位的所有规则
  Future<void> clearSimSlotRules(int simSlotIndex) async {
    final rules = await getSimSlotRules(simSlotIndex);
    for (final rule in rules) {
      await removeSimSlotRule(rule.id);
    }
  }

  /// 清除所有 SIM 卡槽位规则
  Future<void> clearAllSimSlotRules() async {
    final rules = await getAllSimSlotRules();
    for (final rule in rules) {
      await removeSimSlotRule(rule.id);
    }
  }

  /// 根据动作类型定义默认优先级（与其他规则保持一致习惯）
  RulePriority _defaultPriority(RuleAction action) {
    switch (action.type) {
      case RuleActionType.allow:
        return RulePriority.aboveMedium;
      case RuleActionType.block:
        return RulePriority.belowMedium;
      case RuleActionType.silence:
        return RulePriority.silenceAction;
      case RuleActionType.none:
      default:
        return RulePriority.noneAction;
    }
  }
}

/// Riverpod 3 Provider：提供 SimSlotRuleService 实例
// 2. 使用 @riverpod 注解创建新的 provider
@Riverpod(keepAlive: true)
SimSlotRuleService simSlotRuleService(Ref ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final prefs = ref.watch(sharedPreferencesProvider);
  return SimSlotRuleService(ruleRepository, prefs);
}

@riverpod
Future<bool> isSimSlotFilterEnabled(Ref ref, int simSlotIndex) {
  final service = ref.watch(simSlotRuleServiceProvider);
  return service.isSimSlotFilterEnabled(simSlotIndex);
}
