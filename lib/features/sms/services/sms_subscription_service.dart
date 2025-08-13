import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_subscription.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';
import 'package:yourcallyourrule/core/repositories/sms_subscription_repository.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/services/subscription_service_base.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';

class SmsSubscriptionService
    extends SubscriptionServiceBase<SmsSubscription, String> {
  final SmsSubscriptionRepository _repository; // 修正_repository声明
  final RuleImportExportService _importExportService;
  final RuleRepository _ruleRepository;

  SmsSubscriptionService(
    this._repository, // 修正构造函数参数
    this._ruleRepository,
  ) : _importExportService = RuleImportExportService(_ruleRepository),
       super(_repository);

  Future<List<RuleBase>> _updateRulesCore(SmsSubscription subscription) async {
    final data = await downloadFromUrl(subscription.url.toString());
    final rules = await _importExportService.parseImportData(data);

    final processedRules = rules
        .map((rule) => rule is SmsRegexRule 
            ? rule.copyWith(
                action: subscription.action,
                contentRegex: rule.contentPattern.pattern, // 保留原始正则表达式
                senderRegex: rule.senderPattern?.pattern
              ) 
            : rule)
        .toList();

    await _ruleRepository.saveAll(processedRules);
    return processedRules;
  }

  @override
  Future<SmsSubscription> addSubscription(String name, String url,
      {bool isEnabled = true}) { // 移除多余的action参数
    return _repository.save(SmsSubscription(
          id: const Uuid().v4(),
          name: name,
          url: Url(url),
          isEnabled: isEnabled,
          action: RuleAction.block, // 使用默认值或从其他位置获取
          lastUpdated: DateTime.now(),
        ));
  }

  // 新增自动更新方法
  Future<List<RuleBase>> updateRulesFromSubscription(SmsSubscription subscription) async {
    try {
      final result = await _updateRulesCore(subscription);
      await updateLastUpdated(subscription.id, DateTime.now());
      return result;
    } catch (e) {
      throw Exception('更新订阅规则失败: $e');
    }
  }

  // 新增手动更新方法
  Future<List<RuleBase>> manualUpdateRulesFromSubscription(SmsSubscription subscription) async {
    return await _updateRulesCore(subscription);
  }

  // 移除黑白名单相关方法，新增按action查询
  Future<List<SmsSubscription>> getSubscriptionsByAction(
      RuleAction action) async {
    final all = await _repository.getAll(); // 使用已定义的_repository
    return all.where((s) => s.action == action).toList();
  }

  @override
  Future<void> enableSubscription(SmsSubscription subscription) async {
    await _repository.save(subscription.copyWith(
        isEnabled: true,
        // 保留原始action
        action: subscription.action));
  }

  @override
  Future<void> updateLastUpdated(String id, DateTime time) {
    return (repository as SmsSubscriptionRepository)
        .updateLastUpdated(id, time);
  }

  @override
  Future<List<SmsSubscription>> getPendingUpdateSubscriptions() {
    return (repository as SmsSubscriptionRepository)
        .getPendingUpdateSubscriptions();
  }

  @override
  Future<int> clearExpiredSubscriptions() {
    return (repository as SmsSubscriptionRepository)
        .clearExpiredSubscriptions();
  }

  @override
  Future<void> disableSubscription(SmsSubscription subscription) async {
    await _repository.save(subscription.copyWith(isEnabled: false));
  }

  @override
  Future<bool> deleteSubscription(String id) async {
    return await _repository.deleteById(id);
  }

  @override
  Future<SmsSubscription> updateSubscription(
      SmsSubscription subscription) async {
    return await _repository.update(subscription);
  }

  @override
  Future<List<SmsSubscription>> getEnabledSubscriptions() async {
    final all = await _repository.getAll();
    return all.where((s) => s.isEnabled).toList();
  }
  
  /// 保存订阅
  @override
  Future<SmsSubscription> save(SmsSubscription subscription) async {
    return await _repository.save(subscription);
  }
}
