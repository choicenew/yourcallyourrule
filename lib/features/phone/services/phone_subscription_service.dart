// 电话规则订阅服务，用于处理电话规则订阅

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';

import '../../../core/entities/rule/rule_base.dart';
import '../../../core/entities/rule/phone_rule.dart';
import '../../../core/entities/rule/allowed_blocked_rule.dart';
import '../../../core/entities/rule/rule_type.dart';
import '../../../core/entities/subscription/subscription.dart';
import '../../../core/entities/subscription/subscription_table_type.dart';
import '../../../core/repositories/rule_repository.dart';
import '../../../core/repositories/subscription_repository.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/data/repositories/subscription_repository_impl.dart';
import '../../../core/services/rule_import_export_service.dart';
import '../../../core/services/subscription_service_base.dart';
import '../../../core/value_objects/rule_action.dart';
import '../../../core/value_objects/url.dart';

part 'phone_subscription_service.g.dart';

/// PhoneSubscriptionService 的 @Riverpod Provider
@Riverpod(keepAlive: true)
PhoneSubscriptionService phoneSubscriptionService(Ref ref) {
  final subscriptionRepository = ref.watch(subscriptionRepositoryProvider);
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  return PhoneSubscriptionService(subscriptionRepository, ruleRepository);
}

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
      tableType: SubscriptionTableKeys.phone, // 明确设置表类型为phone
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
        } else if (rule is AllowedBlockedRule && rule.subscriptionId == subscription.id) {
          return true;
        }
        return false;
      }).toList();
      
      // 批量删除关联规则
      if (subscribedRules.isNotEmpty) {
        await _ruleRepository.deleteAll(subscribedRules);
      }
      
      debugPrint('[PhoneSubscriptionService] Deleted ${subscribedRules.length} rules associated with subscription: ${subscription.name}');
      return subscribedRules.length;
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

  List<RuleBase> _processRulesWithOverride(List<RuleBase> rules, Subscription subscription, dynamic ruleTypeOverride) {
    final overrideType = ruleTypeOverride != null ? RuleType.fromString(ruleTypeOverride) : null;
    final mapped = <RuleBase>[];
    for (final rule in rules) {
      if (rule is PhoneRule) {
        final PhoneRule phoneRule = rule;
        if (overrideType == RuleType.allowBlock) {
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
              ruleType: RuleTypeKeys.allowBlock,
            ),
          );
        } else {
          // 默认处理为电话规则
          final updated = phoneRule.copyWith(
            action: subscription.action,
            subscriptionId: subscription.id,
            ruleType: RuleTypeKeys.phone,
          );
          mapped.add(updated);
        }
      } else if (rule is RegexRule) {
        // 如果选择regex，仅保留regex规则
        if (overrideType == null || overrideType == RuleType.regex) {
          mapped.add(
            rule.copyWith(
              action: subscription.action,
              subscriptionId: subscription.id,
              ruleType: RuleTypeKeys.regex,
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
    final rules = await _updateRulesCore(subscription, ruleTypeOverride: ruleTypeOverride);
    await updateLastUpdated(subscription.id, DateTime.now());
    debugPrint('[PhoneSubscriptionService] <<< Finished import for subscription: ${subscription.name}');
    return rules;
  }

  String _getRuleUniqueKey(RuleBase rule) {
    if (rule is PhoneRule) {
      return 'phone_${rule.phoneNumber.value}_${rule.action.toString()}';
    } else if (rule is RegexRule) {
      return 'regex_${rule.pattern}_${rule.action.toString()}';
    } else if (rule is AllowedBlockedRule) {
      return 'allowblock_${rule.phoneNumber.value}_${rule.action.toString()}';
    }
    return rule.id;
  }

  /// 核心规则增量更新方法（智能内存 Diff 对比，绝不盲目擦除）
  Future<List<RuleBase>> _updateRulesCore(Subscription subscription, {String? ruleTypeOverride}) async {
    // 1. 从网络拉取最新规则列表
    final remoteRules = await fetchRulesFromSubscription(subscription, ruleTypeOverride: ruleTypeOverride);
    
    // 2. 读取本地已有的该订阅关联规则
    final allLocalRules = await _ruleRepository.getAll();
    final localRules = allLocalRules.where((rule) {
      if (rule is PhoneRule && rule.subscriptionId == subscription.id) return true;
      if (rule is RegexRule && rule.subscriptionId == subscription.id) return true;
      if (rule is AllowedBlockedRule && rule.subscriptionId == subscription.id) return true;
      return false;
    }).toList();

    // 3. 构建索引进行内存 Diff 对比
    final localMap = <String, RuleBase>{};
    for (final rule in localRules) {
      localMap[_getRuleUniqueKey(rule)] = rule;
    }

    final remoteMap = <String, RuleBase>{};
    for (final rule in remoteRules) {
      remoteMap[_getRuleUniqueKey(rule)] = rule;
    }

    final rulesToAdd = <RuleBase>[];
    for (final entry in remoteMap.entries) {
      if (!localMap.containsKey(entry.key)) {
        rulesToAdd.add(entry.value);
      }
    }

    final rulesToDelete = <RuleBase>[];
    for (final entry in localMap.entries) {
      if (!remoteMap.containsKey(entry.key)) {
        rulesToDelete.add(entry.value);
      }
    }

    // 4. 增量提交差异，0 无关变动不操作数据库
    if (rulesToDelete.isNotEmpty) {
      await _ruleRepository.deleteAll(rulesToDelete);
    }
    if (rulesToAdd.isNotEmpty) {
      await _ruleRepository.saveAll(rulesToAdd);
    }

    debugPrint('[PhoneSubscriptionService] Incremental Diff Sync for "${subscription.name}": Added ${rulesToAdd.length}, Deleted ${rulesToDelete.length}, Total Remote ${remoteRules.length}');

    return remoteRules;
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