import 'package:yourcallyourrule/core/base/base_service.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/%E5%A4%87%E4%BB%BD/blacklist_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/rule/whitelist_rule.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/services/import_export_service.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

/// 黑白名单服务类，继承自ListService，提供黑白名单规则的管理功能
/// 包括添加、删除、查询黑白名单规则等操作
// 在类定义处添加父类初始化
class BlacklistWhitelistService extends ListService {
  final RuleRepository _ruleRepository;
  final RuleImportExportService _importExportService;
  
  BlacklistWhitelistService(this._ruleRepository) : 
    _importExportService = RuleImportExportService(_ruleRepository),
    super(_ruleRepository);

  // 添加到黑名单
  Future<void> addToBlacklist(ListEntry entry) async {
    final rule = BlacklistRule(
      id: '',
      name: entry.name,
      priority: const RulePriority(3),
      phoneNumber: entry.phoneNumber,
      label: entry.label, // 使用entry中的label
      avatar: entry.avatar,
    );
    await _ruleRepository.saveRule(rule);
  }

  // 添加到白名单
  Future<void> addToWhitelist(ListEntry entry) async {
    final rule = WhitelistRule(
      id: '',
      name: entry.name,
      priority: const RulePriority(7),
      phoneNumber: entry.phoneNumber,
      label: entry.label,
      avatar: entry.avatar,
    );
    await _ruleRepository.saveRule(rule);
  }

  // 从黑名单中移除
  Future<void> removeFromBlacklist(String ruleId) async {
    await _ruleRepository.deleteRule(ruleId);
  }

  // 从白名单中移除
  Future<void> removeFromWhitelist(String ruleId) async {
    await _ruleRepository.deleteRule(ruleId);
  }

  // 获取所有黑名单规则
  Future<List<BlacklistRule>> getAllBlacklistRules() async {
    final rules = await _ruleRepository.getRulesByType('blacklist');
    return rules.whereType<BlacklistRule>().toList();
  }

  // 获取所有白名单规则
  Future<List<WhitelistRule>> getAllWhitelistRules() async {
    final rules = await _ruleRepository.getRulesByType('whitelist');
    return rules.whereType<WhitelistRule>().toList();
  }

  // 检查是否在黑名单中
  Future<bool> isInBlacklist(PhoneNumber phoneNumber) async {
    final rules = await getAllBlacklistRules();
    return rules.any((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled);
  }

  // 检查是否在白名单中
  Future<bool> isInWhitelist(PhoneNumber phoneNumber) async {
    final rules = await getAllWhitelistRules();
    return rules.any((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled);
  }

  // 更新黑名单规则
  Future<void> updateBlacklistRule(BlacklistRule rule) async {
    await _ruleRepository.updateRule(rule);
  }

  // 更新白名单规则
  Future<void> updateWhitelistRule(WhitelistRule rule) async {
    await _ruleRepository.updateRule(rule);
  }

  // 切换黑名单规则状态
  Future<void> toggleBlacklistRule(String ruleId, bool isEnabled) async {
    final rule = await _ruleRepository.getRuleById(ruleId) as BlacklistRule?;
    if (rule != null) {
      final updatedRule = rule.copyWith(isEnabled: isEnabled);
      await _ruleRepository.updateRule(updatedRule);
    }
  }

  // 切换白名单规则状态
  Future<void> toggleWhitelistRule(String ruleId, bool isEnabled) async {
    final rule = await _ruleRepository.getRuleById(ruleId) as WhitelistRule?;
    if (rule != null) {
      final updatedRule = rule.copyWith(isEnabled: isEnabled);
      await _ruleRepository.updateRule(updatedRule);
    }
  }

  // 根据动作类型筛选规则
  Future<List<RuleBase>> getRulesByAction(RuleAction action) async {
    final blacklist = await getAllBlacklistRules();
    final whitelist = await getAllWhitelistRules();
    return [
      ...blacklist.where((r) => r.action == action),
      ...whitelist.where((r) => r.action == action)
    ];
  }

  // 导出黑名单规则到文件
  Future<bool> exportBlacklistToFile(String filePath) async {
    final rules = await getAllBlacklistRules();
    return await _importExportService.exportToFile(filePath, entities: rules);
  }

  // 导出白名单规则到文件
  Future<bool> exportWhitelistToFile(String filePath) async {
    final rules = await getAllWhitelistRules();
    return await _importExportService.exportToFile(filePath, entities: rules);
  }

  // 从文件导入黑名单规则
  Future<List<RuleBase>> importBlacklistFromFile(String filePath, {bool overwrite = false}) async {
    final rules = await _importExportService.importFromFile(filePath, mode: overwrite ? ImportMode.overwrite : ImportMode.merge);
    // 过滤出黑名单规则
    return rules.whereType<BlacklistRule>().toList();
  }

  // 从文件导入白名单规则
  Future<List<RuleBase>> importWhitelistFromFile(String filePath, {bool overwrite = false}) async {
    final rules = await _importExportService.importFromFile(filePath, mode: overwrite ? ImportMode.overwrite : ImportMode.merge);
    // 过滤出白名单规则
    return rules.whereType<WhitelistRule>().toList();
  }

  // 从URL导入黑名单规则
  Future<List<RuleBase>> importBlacklistFromUrl(String url) async {
    final rules = await _importExportService.importFromUrl(url);
    return rules.whereType<BlacklistRule>().toList();
  }

  // 从URL导入白名单规则
  Future<List<RuleBase>> importWhitelistFromUrl(String url) async {
    final rules = await _importExportService.importFromUrl(url);
    return rules.whereType<WhitelistRule>().toList();
  }

  // 获取所有标签
  Future<List<String>> getAllLabels() async {
    final blacklistRules = await getAllBlacklistRules();
    final whitelistRules = await getAllWhitelistRules();
    
    final labels = <String>{};
    for (final rule in [...blacklistRules, ...whitelistRules]) {
      // 添加类型检查
      if (rule is BlacklistRule) {
        labels.add(rule.label);
      } else if (rule is WhitelistRule) {
        labels.add(rule.label);
      }
    }
    
    return labels.toList();
  }
}