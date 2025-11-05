// 电话规则订阅服务，用于处理电话规则订阅

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';

import '../../../core/entities/rule/rule_base.dart';
import '../../../core/entities/rule/phone_rule.dart';
import '../../../core/entities/rule/allowed_blocked_rule.dart';
import '../../../core/entities/subscription/subscription.dart';
import '../../../core/repositories/rule_repository.dart';
import '../../../core/repositories/subscription_repository.dart';
import '../../../core/services/rule_import_export_service.dart';
import '../../../core/services/subscription_service_base.dart';
import '../../../core/value_objects/rule_action.dart';
import '../../../core/value_objects/url.dart';

/// 电话规则订阅服务
/// 处理电话规则的订阅功能
class PhoneSubscriptionService extends SubscriptionServiceBase<Subscription, String> {
  final SubscriptionRepository _repository;
  final RuleRepository _ruleRepository;
  final RuleImportExportService _ruleImportExportService;

  PhoneSubscriptionService(
    this._repository, 
    this._ruleRepository
  ) : _ruleImportExportService = RuleImportExportService(_ruleRepository),
      super(_repository);

  @override
  Future<List<Subscription>> getEnabledSubscriptions() async {
    final allSubscriptions = await getAll();
    return allSubscriptions.where((subscription) => subscription.isEnabled).toList();
  }

  /// 获取指定动作类型的订阅
  Future<List<Subscription>> getSubscriptionsByAction(RuleAction action) async {
    final allSubscriptions = await getAll();
    return allSubscriptions.where((subscription) => subscription.action == action).toList();
  }

  @override
  Future<void> enableSubscription(Subscription subscription) async {
    subscription = subscription.copyWith(isEnabled: true);
    await save(subscription);
  }

  @override
  Future<void> disableSubscription(Subscription subscription) async {
    subscription = subscription.copyWith(isEnabled: false);
    await save(subscription);
  }

  @override
  Future<Subscription> addSubscription(String name, String url, {bool isEnabled = true, RuleAction action = RuleAction.block}) async {
    final subscription = Subscription(
      id: const Uuid().v4(),
      name: name,
      url: Url.fromString(url),
      isEnabled: isEnabled,
      action: action, // 使用传入的 action 参数
      lastUpdated: DateTime.now(),
      autoUpdate: false,
      tableType: 'phone', // 明确设置表类型为phone
    );
    return await save(subscription);
  }

  // 已移除addWhitelistSubscription和addBlacklistSubscription方法，统一使用addSubscription方法


  @override
  Future<Subscription> updateSubscription(Subscription subscription) async {
    return await update(subscription);
  }

  @override
  Future<bool> deleteSubscription(String id) async {
    // 先获取订阅信息
    final subscription = await getById(id);
    if (subscription != null) {
      // 删除与此订阅关联的规则
      await deleteRulesFromSubscription(subscription);
    }
    // 然后删除订阅本身
    return await deleteById(id);
  }

  /// 删除与订阅关联的规则
  Future<int> deleteRulesFromSubscription(Subscription subscription) async {
    try {
      // 获取所有已订阅的规则
      final allRules = await _ruleRepository.getAll();
      final subscribedRules = allRules.where((rule) {
        // 使用 subscriptionId 字段进行匹配
        if (rule is PhoneRule && rule.subscriptionId == subscription.id) {
          return true;
        } else if (rule is RegexRule && rule.subscriptionId == subscription.id) {
          return true;
        }
        return false;
      }).toList();
      
      // 删除这些规则
      int deletedCount = 0;
      for (var rule in subscribedRules) {
        final success = await _ruleRepository.deleteById(rule.id);
        if (success) deletedCount++;
      }
      
      debugPrint('[PhoneSubscriptionService] Deleted $deletedCount rules associated with subscription: ${subscription.name}');
      return deletedCount;
    } catch (e) {
      debugPrint('[PhoneSubscriptionService] Error deleting rules: $e');
      return 0;
    }
  }

  /// 切换订阅状态
  Future<void> toggleSubscriptionStatus(Subscription subscription, bool isEnabled) async {
    if (isEnabled) {
      await enableSubscription(subscription);
    } else {
      await disableSubscription(subscription);
    }
  }

  /// 从URL获取规则，但不保存
  Future<List<RuleBase>> fetchRulesFromSubscription(Subscription subscription, {String? ruleTypeOverride}) async {
    final data = await downloadFromUrl(subscription.url.toString());
    final rules = await _ruleImportExportService.parseImportData(data);
    
    final processedRules = _processRulesWithOverride(rules, subscription, ruleTypeOverride);
    
    return processedRules;
  }

  List<RuleBase> _processRulesWithOverride(List<RuleBase> rules, Subscription subscription, String? ruleTypeOverride) {
    final mapped = <RuleBase>[];
    for (final rule in rules) {
      if (rule is PhoneRule) {
        final phoneRule = rule;
        if (ruleTypeOverride == 'allow_block') {
          // 转换为允许/阻止规则
          mapped.add(
            AllowedBlockedRule(
              id: phoneRule.id,
              name: phoneRule.name,
              action: subscription.action,
              phoneNumber: phoneRule.phoneNumber,
              labelId: phoneRule.labelId,
              isEnabled: phoneRule.isEnabled,
              count: phoneRule.count,
              avatar: phoneRule.avatar,
              subscriptionId: subscription.id,
              ruleType: 'allow_block',
            ),
          );
        } else {
          // 默认处理为电话规则
          final updated = phoneRule.copyWith(
            action: subscription.action,
            subscriptionId: subscription.id,
            ruleType: 'phone_rule',
          );
          mapped.add(updated);
        }
      } else if (rule is RegexRule) {
        // 如果选择regex，仅保留regex规则
        if (ruleTypeOverride == null || ruleTypeOverride == 'regex') {
          mapped.add(
            rule.copyWith(
              action: subscription.action,
              subscriptionId: subscription.id,
              ruleType: 'regex',
            ),
          );
        }
      } else {
        // 其他类型原样保留
        mapped.add(rule);
      }
    }
    return mapped;
  }

  /// 从订阅URL导入规则并保存
  Future<List<RuleBase>> importAndSaveRulesFromSubscription(Subscription subscription, {String? ruleTypeOverride}) async {
    debugPrint('[PhoneSubscriptionService] >>> Starting import for subscription: ${subscription.name}');
    // 1. 使用 importFromUrl 从URL获取规则
    final rules = await _ruleImportExportService.importFromUrl(subscription.url.toString());
    debugPrint('[PhoneSubscriptionService] ... Fetched ${rules.length} rules from URL.');

    // 2. 按选择的规则类型进行处理：覆盖action、设置订阅关联
    final processedRules = _processRulesWithOverride(rules, subscription, ruleTypeOverride);
    
    // 分离电话规则和正则规则
    final phoneRules = processedRules.whereType<PhoneRule>().toList();
    final regexRules = processedRules.whereType<RegexRule>().toList();
    final allowedBlockedRules = processedRules.whereType<AllowedBlockedRule>().toList();
    
    debugPrint('[PhoneSubscriptionService] ... Processed ${phoneRules.length} phone rules and ${regexRules.length} regex rules.');

    // 3. 保存处理后的规则
    if (phoneRules.isNotEmpty) {
      await _ruleRepository.saveAll(phoneRules);
      debugPrint('[PhoneSubscriptionService] ... Saved ${phoneRules.length} phone rules to the repository.');
    }
    
    if (regexRules.isNotEmpty) {
      await _ruleRepository.saveAll(regexRules);
      debugPrint('[PhoneSubscriptionService] ... Saved ${regexRules.length} regex rules to the repository.');
    }
    if (allowedBlockedRules.isNotEmpty) {
      await _ruleRepository.saveAll(allowedBlockedRules);
      debugPrint('[PhoneSubscriptionService] ... Saved ${allowedBlockedRules.length} allowed/blocked rules to the repository.');
    }
    
    // 4. 更新订阅的时间戳
    await updateLastUpdated(subscription.id, DateTime.now());
    debugPrint('[PhoneSubscriptionService] <<< Finished import for subscription: ${subscription.name}');

    return processedRules;
  }

  /// 核心规则更新方法（不更新时间戳）
  Future<List<RuleBase>> _updateRulesCore(Subscription subscription, {String? ruleTypeOverride}) async {
    final rules = await fetchRulesFromSubscription(subscription, ruleTypeOverride: ruleTypeOverride);
    
    // 分离电话规则和正则规则
    final phoneRules = rules.whereType<PhoneRule>().toList();
    final regexRules = rules.whereType<RegexRule>().toList();
    final allowedBlockedRules = rules.whereType<AllowedBlockedRule>().toList();
    
    // 分别保存不同类型的规则
    if (phoneRules.isNotEmpty) {
      await _ruleRepository.saveAll(phoneRules);
    }
    
    if (regexRules.isNotEmpty) {
      await _ruleRepository.saveAll(regexRules);
    }
    if (allowedBlockedRules.isNotEmpty) {
      await _ruleRepository.saveAll(allowedBlockedRules);
    }
    
    return rules;
  }

  /// 自动更新（带时间戳更新）
  Future<List<RuleBase>> updateRulesFromSubscription(Subscription subscription, {String? ruleTypeOverride}) async {
    try {
      final result = await _updateRulesCore(subscription, ruleTypeOverride: ruleTypeOverride);
      await updateLastUpdated(subscription.id, DateTime.now());
      return result;
    } catch (e) {
      throw Exception('更新订阅规则失败: $e');
    }
  }

  /// 手动更新（不带时间戳更新）
  Future<List<RuleBase>> manualUpdateRulesFromSubscription(Subscription subscription, {String? ruleTypeOverride}) async {
    try {
      return await _updateRulesCore(subscription, ruleTypeOverride: ruleTypeOverride);
    } catch (e) {
      throw Exception('手动更新规则失败: $e');
    }
  }

  @override
  Future<void> updateLastUpdated(String id, DateTime time) async {
    await _repository.updateLastUpdated(id, time);
  }

  @override
  Future<List<Subscription>> getPendingUpdateSubscriptions() async {
    return await _repository.getPendingUpdateSubscriptions();
  }

  @override
  Future<int> clearExpiredSubscriptions() async {
    return await _repository.clearExpiredSubscriptions();
  }

  // 新增导出功能

  // 新增文件导入功能- 基类已通过 _importExportService 处理具体逻辑
 //子类通过构造函数注入 RuleImportExportService 已满足依赖
 //无任何需要覆盖的特殊场景


}