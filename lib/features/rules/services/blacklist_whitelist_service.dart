import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/rule/white_black_rule.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/services/import_export_service.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

/// 黑白名单服务类，继承自ListService，提供黑白名单规则的管理功能
/// 包括添加、删除、查询黑白名单规则等操作
class BlacklistWhitelistService extends ListService {
  final RuleRepository _ruleRepository;
  final RuleImportExportService _importExportService;
  
  BlacklistWhitelistService(this._ruleRepository) : 
    _importExportService = RuleImportExportService(_ruleRepository),
    super(_ruleRepository);

  /// 获取导入导出服务
  RuleImportExportService get importExportService => _importExportService;
  
  // 添加黑白名单规则
  Future<void> addWhiteBlackRule(ListEntry entry, RuleAction action) async {
    final rule = WhiteBlackRule(
      id: '', // ID 将由 repository 或 datasource 生成
      name: entry.name,
      action: action,
      phoneNumber: entry.phoneNumber,
      labelId: entry.labelId,
      avatar: entry.avatar,
      // isSubscribed 和 count 会使用默认值
    );
    await _ruleRepository.saveRule(rule);
  }
  
  // 添加到黑名单 (保留兼容性)
  Future<void> addToBlacklist(ListEntry entry) async {
    await addWhiteBlackRule(entry, RuleAction.block);
  }

  // 添加到白名单 (保留兼容性)
  Future<void> addToWhitelist(ListEntry entry) async {
    await addWhiteBlackRule(entry, RuleAction.allow);
  }

  // 删除规则
  Future<void> removeRule(String ruleId) async {
    await _ruleRepository.deleteRule(ruleId);
  }
  
  // 从黑名单中移除 (保留兼容性)
  Future<void> removeFromBlacklist(String ruleId) async {
    await removeRule(ruleId);
  }

  // 从白名单中移除 (保留兼容性)
  Future<void> removeFromWhitelist(String ruleId) async {
    await removeRule(ruleId);
  }

  // 获取所有黑名单规则
  Future<List<WhiteBlackRule>> getAllBlacklistRules() async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.block.toString());
    return rules.whereType<WhiteBlackRule>().toList();
  }

  // 获取所有白名单规则
  Future<List<WhiteBlackRule>> getAllWhitelistRules() async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.allow.toString());
    return rules.whereType<WhiteBlackRule>().toList();
  }
  
  // 获取所有静音规则
  Future<List<WhiteBlackRule>> getAllSilenceRules() async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.silence.toString());
    return rules.whereType<WhiteBlackRule>().toList();
  }
  
  // 获取所有无动作规则
  Future<List<WhiteBlackRule>> getAllNoneRules() async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.none.toString());
    return rules.whereType<WhiteBlackRule>().toList();
  }
  
  // 获取所有规则（按动作类型分类）
  Future<List<WhiteBlackRule>> getAllRulesByActionType(RuleActionType? actionType) async {
    if (actionType == null) {
      // 获取所有规则
      final rules = await _ruleRepository.getAll();
      return rules.whereType<WhiteBlackRule>().toList();
    } else {
      // 获取特定动作类型的规则
      final rules = await _ruleRepository.getRulesByType(RuleAction(type: actionType).toString());
      return rules.whereType<WhiteBlackRule>().toList();
    }
  }

  // 检查是否在黑名单中
  Future<bool> isInBlacklist(PhoneNumber phoneNumber) async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.block.toString());
    return rules.whereType<WhiteBlackRule>().any((r) => r.phoneNumber.value == phoneNumber.value && r.isEnabled);
  }

  // 检查是否在白名单中
  Future<bool> isInWhitelist(PhoneNumber phoneNumber) async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.allow.toString());
    return rules.whereType<WhiteBlackRule>().any((r) => r.phoneNumber.value == phoneNumber.value && r.isEnabled);
  }
  
  // 获取匹配指定号码的黑名单规则
  Future<List<WhiteBlackRule>> getBlacklistRules(PhoneNumber phoneNumber) async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.block.toString());
    return rules
        .whereType<WhiteBlackRule>()
        .where((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled)
        .toList();
  }

  // 获取匹配指定号码的白名单规则
  Future<List<WhiteBlackRule>> getWhitelistRules(PhoneNumber phoneNumber) async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.allow.toString());
    return rules
        .whereType<WhiteBlackRule>()
        .where((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled)
        .toList();
  }
  
  // 获取匹配指定号码的指定动作类型的规则
  // 如果action为null，则返回所有匹配的规则，不考虑动作类型
  Future<List<WhiteBlackRule>> getRulesByActionType(PhoneNumber phoneNumber, RuleAction? action) async {
    if (action == null) {
      // 获取所有规则
      final rules = await _ruleRepository.getAll();
      return rules
          .whereType<WhiteBlackRule>()
          .where((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled)
          .toList();
    } else {
      // 获取特定动作类型的规则
      final rules = await _ruleRepository.getRulesByType(action.toString());
      return rules
          .whereType<WhiteBlackRule>()
          .where((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled)
          .toList();
    }
  }

  // 更新黑白名单规则
  Future<void> updateWhiteBlackRule(WhiteBlackRule rule) async {
    await _ruleRepository.updateRule(rule);
  }
  
  // 更新黑名单规则 (保留兼容性)
  Future<void> updateBlacklistRule(WhiteBlackRule rule) async {
    if (rule.action != RuleAction.block) {
      throw ArgumentError('Rule must be a blacklist rule');
    }
    await updateWhiteBlackRule(rule);
  }

  // 更新白名单规则 (保留兼容性)
  Future<void> updateWhitelistRule(WhiteBlackRule rule) async {
    if (rule.action != RuleAction.allow) {
      throw ArgumentError('Rule must be a whitelist rule');
    }
    await updateWhiteBlackRule(rule);
  }

  // 切换规则状态
  Future<void> toggleRuleStatus(String ruleId, bool isEnabled) async {
    final rule = await _ruleRepository.getRuleById(ruleId) as WhiteBlackRule?;
    if (rule != null) {
      final updatedRule = rule.copyWith(isEnabled: isEnabled);
      await _ruleRepository.updateRule(updatedRule);
    }
  }
  
  // 切换黑名单规则状态 (保留兼容性)
  Future<void> toggleBlacklistRule(String ruleId, bool isEnabled) async {
    final rule = await _ruleRepository.getRuleById(ruleId) as WhiteBlackRule?;
    if (rule != null && rule.action == RuleAction.block) {
      await toggleRuleStatus(ruleId, isEnabled);
    }
  }

  // 切换白名单规则状态 (保留兼容性)
  Future<void> toggleWhitelistRule(String ruleId, bool isEnabled) async {
    final rule = await _ruleRepository.getRuleById(ruleId) as WhiteBlackRule?;
    if (rule != null && rule.action == RuleAction.allow) {
      await toggleRuleStatus(ruleId, isEnabled);
    }
  }

  // 获取所有黑白名单规则
  Future<List<WhiteBlackRule>> getAllRules() async {
    final rules = await _ruleRepository.getAll();
    return rules.whereType<WhiteBlackRule>().toList();
  }
  
  // 根据动作类型筛选规则
  Future<List<RuleBase>> getRulesByAction(RuleAction action) async {
    final allRules = await getAllRules();
    return allRules.where((r) => r.action == action).toList();
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
    return rules.whereType<WhiteBlackRule>().where((r) => r.action == RuleAction.block).toList();
  }

  // 从文件导入白名单规则
  Future<List<RuleBase>> importWhitelistFromFile(String filePath, {bool overwrite = false}) async {
    final rules = await _importExportService.importFromFile(filePath, mode: overwrite ? ImportMode.overwrite : ImportMode.merge);
    // 过滤出白名单规则
    return rules.whereType<WhiteBlackRule>().where((r) => r.action == RuleAction.allow).toList();
  }

  // 从URL导入黑名单规则
  Future<List<RuleBase>> importBlacklistFromUrl(String url) async {
    final rules = await _importExportService.importFromUrl(url);
    return rules.whereType<WhiteBlackRule>().where((r) => r.action == RuleAction.block).toList();
  }

  // 从URL导入白名单规则
  Future<List<RuleBase>> importWhitelistFromUrl(String url) async {
    final rules = await _importExportService.importFromUrl(url);
    return rules.whereType<WhiteBlackRule>().where((r) => r.action == RuleAction.allow).toList();
  }

  // 获取所有标签
  Future<List<String>> getAllLabels() async {
    final rules = await _ruleRepository.getAll(); // 使用BaseRepository中定义的getAll方法
    final labels = <String>{};
    for (final rule in rules) {
      if (rule is WhiteBlackRule) {
        labels.add(rule.labelId);
      }
    }
    
    return labels.toList();
  }
}