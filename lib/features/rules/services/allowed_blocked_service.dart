import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/allowed_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/blocked_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/services/import_export_service.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

// 重构后的允许/阻止规则服务
class AllowedBlockedService extends ListService {
  final RuleRepository _ruleRepository;
  final RuleImportExportService _importExportService;

  AllowedBlockedService(this._ruleRepository) : 
    _importExportService = RuleImportExportService(_ruleRepository),
    super(_ruleRepository);

  // 添加允许规则
  Future<void> addAllowedRule(ListEntry entry) async {
    final rule = AllowedRule(
      id: '',
      name: entry.name, // 使用entry中的name
      priority: const RulePriority(100),
      phoneNumber: entry.phoneNumber,
      label: entry.label, // 使用entry中的label
      avatar: entry.avatar, // 添加avatar参数
    );
    await _ruleRepository.saveRule(rule);
  }

  // 添加阻止规则
  Future<void> addBlockedRule(ListEntry entry) async {
    final rule = BlockedRule(
      id: '',
      name: entry.name,
      priority: const RulePriority(50),
      phoneNumber: entry.phoneNumber,
      label: entry.label, // 使用entry中的label
      avatar: entry.avatar, // 添加avatar参数
    );
    await _ruleRepository.saveRule(rule);
  }

  // 获取所有允许规则
  Future<List<AllowedRule>> getAllAllowedRules() async {
    final rules = await _ruleRepository.getRulesByType('allowed');
    return rules.whereType<AllowedRule>().toList();
  }

  // 获取所有阻止规则
  Future<List<BlockedRule>> getAllBlockedRules() async {
    final rules = await _ruleRepository.getRulesByType('blocked');
    return rules.whereType<BlockedRule>().toList();
  }

  // 切换允许规则状态
  Future<void> toggleAllowedRule(String ruleId, bool isEnabled) async {
    final rule = await _ruleRepository.getRuleById(ruleId) as AllowedRule?;
    if (rule != null) {
      final updatedRule = rule.copyWith(isEnabled: isEnabled);
      await _ruleRepository.updateRule(updatedRule);
    }
  }

  // 切换阻止规则状态
  Future<void> toggleBlockedRule(String ruleId, bool isEnabled) async {
    final rule = await _ruleRepository.getRuleById(ruleId) as BlockedRule?;
    if (rule != null) {
      final updatedRule = rule.copyWith(isEnabled: isEnabled);
      await _ruleRepository.updateRule(updatedRule);
    }
  }

  // 删除允许规则
  Future<void> removeAllowedRule(String ruleId) async {
    await _ruleRepository.deleteRule(ruleId);
  }

  // 删除阻止规则
  Future<void> removeBlockedRule(String ruleId) async {
    await _ruleRepository.deleteRule(ruleId);
  }

  // 检查号码是否被允许
  Future<bool> isInAllowed(PhoneNumber phoneNumber) async {
    final rules = await getAllAllowedRules();
    return rules.any((r) => r.phoneNumber.value == phoneNumber.value && r.isEnabled);
  }

  // 检查号码是否被阻止
  Future<bool> isInBlocked(PhoneNumber phoneNumber) async {
    final rules = await getAllBlockedRules();
    return rules.any((r) => r.phoneNumber.value == phoneNumber.value && r.isEnabled);
  }

  // 更新允许规则
  Future<void> updateAllowedRule(AllowedRule rule) async {
    await _ruleRepository.updateRule(rule);
  }

  // 更新阻止规则
  Future<void> updateBlockedRule(BlockedRule rule) async {
    await _ruleRepository.updateRule(rule);
  }

  // 根据动作类型筛选规则
  Future<List<RuleBase>> getRulesByAction(RuleAction action) async {
    final allowed = await getAllAllowedRules();
    final blocked = await getAllBlockedRules();
    return [
      ...allowed.where((r) => r.action == action),
      ...blocked.where((r) => r.action == action)
    ];
  }

  // 导出允许规则到文件
  Future<bool> exportAllowedRulesToFile(String filePath) async {
    final rules = await getAllAllowedRules();
    return await _importExportService.exportToFile(filePath, entities: rules);
  }

  // 导出阻止规则到文件
  Future<bool> exportBlockedRulesToFile(String filePath) async {
    final rules = await getAllBlockedRules();
    return await _importExportService.exportToFile(filePath, entities: rules);
  }

  // 从文件导入允许规则
  Future<List<RuleBase>> importAllowedRulesFromFile(String filePath, {bool overwrite = false}) async {
    final rules = await _importExportService.importFromFile(filePath, mode: overwrite ? ImportMode.overwrite : ImportMode.merge);
    // 过滤出允许规则
    return rules.whereType<AllowedRule>().toList();
  }

  // 从文件导入阻止规则
  Future<List<RuleBase>> importBlockedRulesFromFile(String filePath, {bool overwrite = false}) async {
    final rules = await _importExportService.importFromFile(filePath, mode: overwrite ? ImportMode.overwrite : ImportMode.merge);
    // 过滤出阻止规则
    return rules.whereType<BlockedRule>().toList();
  }

  // 从URL导入允许规则
  Future<List<RuleBase>> importAllowedRulesFromUrl(String url) async {
    final rules = await _importExportService.importFromUrl(url);
    return rules.whereType<AllowedRule>().toList();
  }

  // 从URL导入阻止规则
  Future<List<RuleBase>> importBlockedRulesFromUrl(String url) async {
    final rules = await _importExportService.importFromUrl(url);
    return rules.whereType<BlockedRule>().toList();
  }

  // 获取所有标签
  Future<List<String>> getAllLabels() async {
    final allowedRules = await getAllAllowedRules();
    final blockedRules = await getAllBlockedRules();
    
    final labels = <String>{};
    for (final rule in [...allowedRules, ...blockedRules]) {
      if (rule is AllowedRule) {
        labels.add(rule.label);
      } else if (rule is BlockedRule) {
        labels.add(rule.label);
      }
    }
    
    return labels.toList();
  }
}