import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/common/entities/list_entry.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/rules/repositories/rule_repository.dart';
import 'package:yourcallyourrule/features/rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/common/services/list_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:uuid/uuid.dart';

part 'rule_management_service.g.dart';

/// RuleManagementService Riverpod Provider
@Riverpod(keepAlive: true)
RuleManagementService ruleManagementService(Ref ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  return RuleManagementService(ruleRepository);
}

/// 规则管理服务类，继承自ListService，提供各种动作类型规则的管理功能
/// 包括添加、删除、查询不同动作类型（允许、阻止、静音、无动作等）的规则操作
class RuleManagementService extends ListService {
  /// 统一日志标识 Tag
  static const String tag = '[RuleManagementService]';

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
    );
    await _ruleRepository.saveRule(rule);
  }

  // 删除规则
  Future<void> removeRule(String ruleId) async {
    await _ruleRepository.deleteRule(ruleId);
  }
  
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
      final rules = await _ruleRepository.getAll();
      return rules.whereType<PhoneRule>().toList();
    } else {
      final rules = await _ruleRepository.getRulesByType(RuleAction(type: actionType).toString());
      return rules.whereType<PhoneRule>().toList();
    }
  }

  // 获取匹配指定号码的指定动作类型的规则
  // 如果action为null，则返回所有匹配的规则，不考虑动作类型
  Future<List<PhoneRule>> getRulesByActionType(PhoneNumber phoneNumber, RuleAction? action) async {
    if (action == null) {
      final rules = await _ruleRepository.getAll();
      return rules
          .whereType<PhoneRule>()
          .where((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled)
          .toList();
    } else {
      final rules = await _ruleRepository.getRulesByType(action.toString());
      return rules
          .whereType<PhoneRule>()
          .where((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled)
          .toList();
    }
  }

  /// 根据电话号码精准定位匹配的 PhoneRule 规则
  Future<List<PhoneRule>> getRulesByPhoneNumber(PhoneNumber phoneNumber) async {
    final rules = await _ruleRepository.getAll();
    return rules
        .whereType<PhoneRule>()
        .where((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled)
        .toList();
  }

  // 更新电话规则
  Future<void> updatePhoneNumberRule(PhoneRule rule) async {
    await _ruleRepository.updateRule(rule);
  }
  
  // 保存规则
  Future<void> saveRule(RuleBase rule) async {
    await _ruleRepository.saveRule(rule);
  }

  // 切换规则状态
  Future<void> toggleRuleStatus(String ruleId, bool isEnabled) async {
    final rule = await _ruleRepository.getRuleById(ruleId) as PhoneRule?;
    if (rule != null) {
      final updatedRule = rule.copyWith(isEnabled: isEnabled);
      await _ruleRepository.updateRule(updatedRule);
    }
  }

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

  // 获取所有标签
  Future<List<String>> getAllLabels() async {
    final rules = await _ruleRepository.getAll();
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
          final existingRules = await getRulesByActionType(rule.phoneNumber, null);
          final isExisting = existingRules.any((r) => r.phoneNumber.value == rule.phoneNumber.value);
          
          if (isExisting && !overwrite) {
            continue;
          }
          
          final finalAction = action ?? rule.action;
          final finalRule = rule.copyWith(action: finalAction, subscriptionId: subscriptionId);
          
          if (isExisting) {
            await _ruleRepository.updateRule(finalRule);
          } else {
            await _ruleRepository.saveRule(finalRule);
          }
          
          successCount++;
        } catch (e) {
          debugPrint('$tag 导入规则失败: ${rule.name}, 错误: $e');
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