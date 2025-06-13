import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';
import 'package:yourcallyourrule/core/repositories/base_repository.dart';
import 'package:yourcallyourrule/core/repositories/base_repository.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/repositories/sms_subscription_repository.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';

class SmsService extends ListService<SmsRegexRule, String> {
  final BaseRepository<SmsRegexRule, String> _smsRegexRuleRepository;
  final SmsSubscriptionRepository _subscriptionRepository;
  final RuleImportExportService _importExportService;

  RuleImportExportService get importExportService => _importExportService;

  SmsService(
    this._smsRegexRuleRepository,
    this._subscriptionRepository,
    RuleRepository ruleRepository,
  ) : _importExportService = RuleImportExportService(ruleRepository),
       super(_smsRegexRuleRepository);

  bool validateRegexPattern(String pattern) {
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
    final rules = await _smsRegexRuleRepository.getAll();
      
    if (checkSubscription) {
      final subscriptions = await _subscriptionRepository.getAll();
      final enabledSubscriptions = subscriptions.where((s) => s.isEnabled).toList();
      final subscriptionRules = await Future.wait(
        enabledSubscriptions.map((s) => _importExportService.parseImportData(s.url.toString()))
      );
      rules.addAll(subscriptionRules.expand((i) => i).whereType<SmsRegexRule>());
    }
    
    return rules.where((r) => r.isEnabled).toList();
  }

  Future<void> syncSubscriptionRules() async {
    final subscriptions = await _subscriptionRepository.getAll();
    final enabledSubscriptions = subscriptions.where((s) => s.isEnabled).toList();
    for (final sub in enabledSubscriptions) {
      final rules = await _importExportService.parseImportData(sub.url.toString());
      await _smsRegexRuleRepository.saveAll(rules.whereType<SmsRegexRule>().toList());
    }
  }

  @override
  Future<SmsRegexRule> update(SmsRegexRule entity) async {
    if (!validateRegexPattern(entity.contentPattern.pattern)) {
      throw FormatException('无效的正则表达式: ${entity.contentPattern.pattern}');
    }
    return super.update(entity);
  }

  @override
  Future<SmsRegexRule> save(SmsRegexRule entity) async {
    if (!validateRegexPattern(entity.contentPattern.pattern)) {
      throw FormatException('无效的正则表达式: ${entity.contentPattern.pattern}');
    }
    return super.save(entity);
  }

  @override
  Future<bool> delete(SmsRegexRule entity) async {
    return _smsRegexRuleRepository.delete(entity);
  }
}