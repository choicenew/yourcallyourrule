import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/services/import_export_service.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:uuid/uuid.dart';

/// 规则管理服务类，继承自ListService，提供各种动作类型规则的管理功能
/// 包括添加、删除、查询不同动作类型（允许、阻止、静音、无动作等）的规则操作
class RuleManagementService extends ListService {
  final RuleRepository _ruleRepository;
  final RuleImportExportService _importExportService;
  
  RuleManagementService(this._ruleRepository) : 
    _importExportService = RuleImportExportService(_ruleRepository),
    super(_ruleRepository);

  /// 获取导入导出服务
  RuleImportExportService get importExportService => _importExportService;
  
  // 添加电话规则
  Future<void> addPhoneRule(ListEntry entry, RuleAction action) async {
    final rule = PhoneRule(
      id: const Uuid().v4(), // ID 将由 repository 或 datasource 生成
      name: entry.name,
      action: action,
      phoneNumber: entry.phoneNumber,
      labelId: entry.labelId,
      avatar: entry.avatar,
      // isSubscribed 和 count 会使用默认值
    );
    await _ruleRepository.saveRule(rule);
  }
  
  /* 兼容性代码 - 暂时注释保留
  // 添加到黑名单 (遗留保留兼容性)
  Future<void> addToBlacklist(ListEntry entry) async {
    await addPhoneRule(entry, RuleAction.block);
  }

  // 添加到白名单 (遗留保留兼容性)
  Future<void> addToWhitelist(ListEntry entry) async {
    await addPhoneRule(entry, RuleAction.allow);
  }
  */

  // 删除规则
  Future<void> removeRule(String ruleId) async {
    await _ruleRepository.deleteRule(ruleId);
  }
  
  /* 兼容性代码 - 暂时注释保留
  // 从黑名单中移除 (保留兼容性)
  Future<void> removeFromBlacklist(String ruleId) async {
    await removeRule(ruleId);
  }

  // 从白名单中移除 (保留兼容性)
  Future<void> removeFromWhitelist(String ruleId) async {
    await removeRule(ruleId);
  }
  */

  /* 兼容性代码 - 暂时注释保留
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
  */
  
  // 获取所有静音规则
  Future<List<PhoneRule>> getAllSilenceRules() async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.silence.toString());
    return rules.whereType<PhoneRule>().toList();
  }
  
  // 获取所有无动作规则
  Future<List<PhoneRule>> getAllNoneRules() async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.none.toString());
    return rules.whereType<PhoneRule>().toList();
  }
  
  // 获取所有规则（按动作类型分类）
  Future<List<PhoneRule>> getAllRulesByActionType(RuleActionType? actionType) async {
    if (actionType == null) {
      // 获取所有规则
      final rules = await _ruleRepository.getAll();
      return rules.whereType<PhoneRule>().toList();
    } else {
      // 获取特定动作类型的规则
      final rules = await _ruleRepository.getRulesByType(RuleAction(type: actionType).toString());
      return rules.whereType<PhoneRule>().toList();
    }
  }

  /* 兼容性代码 - 暂时注释保留
  // 检查是否在黑名单中
  Future<bool> isInBlacklist(PhoneNumber phoneNumber) async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.block.toString());
    return rules.whereType<PhoneRule>().any((r) => r.phoneNumber.value == phoneNumber.value && r.isEnabled);
  }

  // 检查是否在白名单中
  Future<bool> isInWhitelist(PhoneNumber phoneNumber) async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.allow.toString());
    return rules.whereType<PhoneRule>().any((r) => r.phoneNumber.value == phoneNumber.value && r.isEnabled);
  }
  */
  
  /* 兼容性代码 - 暂时注释保留
  // 获取匹配指定号码的黑名单规则
  Future<List<PhoneRule>> getBlacklistRules(PhoneNumber phoneNumber) async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.block.toString());
    return rules
        .whereType<PhoneRule>()
        .where((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled)
        .toList();
  }

  // 获取匹配指定号码的白名单规则
  Future<List<PhoneRule>> getWhitelistRules(PhoneNumber phoneNumber) async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.allow.toString());
    return rules
        .whereType<PhoneRule>()
        .where((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled)
        .toList();
  }
  */
  
  // 获取匹配指定号码的指定动作类型的规则
  // 如果action为null，则返回所有匹配的规则，不考虑动作类型
  Future<List<PhoneRule>> getRulesByActionType(PhoneNumber phoneNumber, RuleAction? action) async {
    if (action == null) {
      // 获取所有规则
      final rules = await _ruleRepository.getAll();
      return rules
          .whereType<PhoneRule>()
          .where((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled)
          .toList();
    } else {
      // 获取特定动作类型的规则
      final rules = await _ruleRepository.getRulesByType(action.toString());
      return rules
          .whereType<PhoneRule>()
          .where((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled)
          .toList();
    }
  }


  // 更新电话规则
  Future<void> updatePhoneNumberRule(PhoneRule rule) async {
    await _ruleRepository.updateRule(rule);
  }
  
  /* 兼容性代码 - 暂时注释保留
  // 更新黑名单规则 (保留兼容性)
  Future<void> updateBlacklistRule(PhoneRule rule) async {
    if (rule.action != RuleAction.block) {
      throw ArgumentError('Rule must be a blacklist rule');
    }
    await updatePhoneNumberRule(rule);
  }

  // 更新白名单规则 (保留兼容性)
  Future<void> updateWhitelistRule(PhoneRule rule) async {
    if (rule.action != RuleAction.allow) {
      throw ArgumentError('Rule must be a whitelist rule');
    }
    await updatePhoneNumberRule(rule);
  }
  */

  // 切换规则状态
  Future<void> toggleRuleStatus(String ruleId, bool isEnabled) async {
    final rule = await _ruleRepository.getRuleById(ruleId) as PhoneRule?;
    if (rule != null) {
      final updatedRule = rule.copyWith(isEnabled: isEnabled);
      await _ruleRepository.updateRule(updatedRule);
    }
  }
  
  
  /* 兼容性代码 - 暂时注释保留
  // 切换黑名单规则状态 (保留兼容性)
  Future<void> toggleBlacklistRule(String ruleId, bool isEnabled) async {
    final rule = await _ruleRepository.getRuleById(ruleId) as PhoneRule?;
    if (rule != null && rule.action == RuleAction.block) {
      await toggleRuleStatus(ruleId, isEnabled);
    }
  }

  // 切换白名单规则状态 (保留兼容性)
  Future<void> toggleWhitelistRule(String ruleId, bool isEnabled) async {
    final rule = await _ruleRepository.getRuleById(ruleId) as PhoneRule?;
    if (rule != null && rule.action == RuleAction.allow) {
      await toggleRuleStatus(ruleId, isEnabled);
    }
  }
  */


  // 获取所有电话规则
  Future<List<PhoneRule>> getAllRules() async {
    final rules = await _ruleRepository.getAll();
    return rules.whereType<PhoneRule>().toList();
  }
  
  // 根据动作类型筛选规则
  Future<List<RuleBase>> getRulesByAction(RuleAction action) async {
    final allRules = await getAllRules();
    return allRules.where((r) => r.action == action).toList();
  }

  /* 兼容性代码 - 暂时注释保留
  // 导出黑名单规则到文件
  Future<bool> exportBlacklistToFile(String filePath) async {
    final rules = await getAllRulesByActionType(RuleActionType.block);
    return await _importExportService.exportToFile(filePath, entities: rules);
  }

  // 导出白名单规则到文件
  Future<bool> exportWhitelistToFile(String filePath) async {
    final rules = await getAllRulesByActionType(RuleActionType.allow);
    return await _importExportService.exportToFile(filePath, entities: rules);
  }
  */

  /* 兼容性代码 - 暂时注释保留
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
  */

  /* 兼容性代码 - 暂时注释保留
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
  */

  // 获取所有标签
  Future<List<String>> getAllLabels() async {
    final rules = await _ruleRepository.getAll(); // 使用BaseRepository中定义的getAll方法
    final labels = <String>{};
    for (final rule in rules) {
      if (rule is PhoneRule) {
        labels.add(rule.labelId);
      }
    }
    
    return labels.toList();
  }
  
  /// 批量导入规则
  /// [rules] 要导入的规则列表
  /// [action] 规则动作类型，如果为null则保持原规则动作
  /// [overwrite] 是否覆盖已存在的规则
  /// [subscriptionId] 订阅ID，用于关联规则与订阅
  /// 返回成功导入的规则数量
  Future<int> importRulesBatch(List<RuleBase> rules, {RuleAction? action, bool overwrite = false, String? subscriptionId}) async {
    int successCount = 0;
    
    for (final rule in rules) {
      if (rule is PhoneRule) {
        try {
          // 检查规则是否已存在
          final existingRules = await getRulesByActionType(rule.phoneNumber, null);
          final isExisting = existingRules.any((r) => r.phoneNumber.value == rule.phoneNumber.value);
          
          if (isExisting && !overwrite) {
            // 如果规则已存在且不覆盖，则跳过
            continue;
          }
          
          // 设置规则动作
          final finalAction = action ?? rule.action;
          final finalRule = rule.copyWith(action: finalAction, subscriptionId: subscriptionId);
          
          if (isExisting) {
            // 更新现有规则
            await _ruleRepository.updateRule(finalRule);
          } else {
            // 添加新规则
            await _ruleRepository.saveRule(finalRule);
          }
          
          successCount++;
        } catch (e) {
          // 处理导入单个规则时的错误，继续处理下一个规则
          debugPrint('导入规则失败: ${rule.name}, 错误: $e');
        }
      }
    }
    
    return successCount;
  }
  
  /// 从订阅导入规则到管理页面
  /// [rules] 从订阅获取的规则列表
  /// [action] 导入的规则动作类型
  /// [subscriptionId] 订阅ID，用于关联规则与订阅
  /// 返回成功导入的规则数量
  Future<int> importRulesFromSubscription(List<RuleBase> rules, RuleAction action, {String? subscriptionId}) async {
    return await importRulesBatch(rules, action: action, overwrite: true, subscriptionId: subscriptionId);
  }
}