import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';
import 'package:yourcallyourrule/core/repositories/base_repository.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/repositories/sms_subscription_repository.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';

class SmsService extends ListService<SmsRegexRule, String> {
  final RuleRepository _ruleRepository;
  final SmsSubscriptionRepository _subscriptionRepository;
  final RuleImportExportService _importExportService;

  SmsService(
    this._ruleRepository,
    this._subscriptionRepository,
  ) : _importExportService = RuleImportExportService(_ruleRepository),
       super(_ruleRepository as BaseRepository<SmsRegexRule, String>);

  bool isValidRegex(String pattern) {
    try {
      RegExp(pattern);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<RuleAction> checkSms({
    required String sender,
    required String content,
    bool checkSubscription = true,
  }) async {
    final rules = await _getEffectiveRules(checkSubscription);
    
    for (final rule in rules) {
      final senderMatch = rule.senderPattern?.hasMatch(sender) ?? true;
      final contentMatch = rule.contentPattern.hasMatch(content);
      
      if (senderMatch && contentMatch) {
        return rule.action;
      }
    }
    return RuleAction.allow;
  }

  Future<List<SmsRegexRule>> _getEffectiveRules(bool checkSubscription) async {
    final rules = await _ruleRepository.getRulesByType(SmsRegexRule.ruleType)
      as List<SmsRegexRule>; // 显式类型转换
      
    if (checkSubscription) {
      final subscriptions = await _subscriptionRepository.getEnabledSubscriptions();
      final subscriptionRules = await Future.wait(
        subscriptions.map((s) => _importExportService.parseImportData(s.url))
      );
      rules.addAll(subscriptionRules.expand((i) => i).whereType<SmsRegexRule>());
    }
    
    return rules.where((r) => r.isEnabled).toList();
  }

  Future<void> syncSubscriptionRules() async {
    final subscriptions = await _subscriptionRepository.getEnabledSubscriptions();
    for (final sub in subscriptions) {
      final rules = await _importExportService.parseImportData(sub.url);
      await _ruleRepository.saveAll(rules.whereType<SmsRegexRule>());
    }
  }

  @override
  Future<SmsRegexRule> update(SmsRegexRule entity) async {
    isValidRegex(entity.contentPattern.pattern);
    return super.update(entity);
  }

  Future<SmsRegexRule> add(SmsRegexRule entity) async {
    if (!isValidRegex(entity.contentPattern.pattern)) {
      throw const FormatException('Invalid regex pattern');
    }
    return super.add(entity);
  }
}