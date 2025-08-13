// 电话规则订阅服务，用于处理电话规则订阅

import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/services/import_export_service.dart';

import '../../../core/entities/rule/rule_base.dart';
import '../../../core/entities/rule/phone_rule.dart';
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
    return await deleteById(id);
  }

  /// 切换订阅状态
  Future<void> toggleSubscriptionStatus(Subscription subscription, bool isEnabled) async {
    if (isEnabled) {
      await enableSubscription(subscription);
    } else {
      await disableSubscription(subscription);
    }
  }

  /// 从URL更新订阅规则
  /// 核心规则更新方法（不更新时间戳）
  Future<List<RuleBase>> _updateRulesCore(Subscription subscription) async {
    final data = await downloadFromUrl(subscription.url.toString());
    final rules = await _ruleImportExportService.parseImportData(data);
    
    final processedRules = rules.map((rule) {
      if (rule is PhoneRule) {
        // 如果规则的动作类型与订阅的动作类型不一致，则使用订阅的动作类型
        if (rule.action.type != subscription.action.type) {
          return rule.copyWith(
            action: subscription.action,
            isSubscribed: true
          );
        } else {
          // 如果动作类型一致，只需标记为已订阅
          return rule.copyWith(
            isSubscribed: true
          );
        }
      }
      return rule;
    }).toList();
    
    await _ruleRepository.saveAll(processedRules);
    return processedRules;
  }

  /// 自动更新（带时间戳更新）
  Future<List<RuleBase>> updateRulesFromSubscription(Subscription subscription) async {
    try {
      final result = await _updateRulesCore(subscription);
      await updateLastUpdated(subscription.id, DateTime.now());
      return result;
    } catch (e) {
      throw Exception('更新订阅规则失败: $e');
    }
  }

  /// 手动更新（不带时间戳更新）
  Future<List<RuleBase>> manualUpdateRulesFromSubscription(Subscription subscription) async {
    try {
      return await _updateRulesCore(subscription);
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