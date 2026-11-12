import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/sms/domain/sms_regex_rule.dart';
import 'package:yourcallyourrule/features/sms/repositories/sms_subscription_repository.dart';

part 'sms_service.g.dart';

@Riverpod(keepAlive: true)
SmsService smsService(Ref ref) {
  final smsSubscriptionRepository = ref.watch(smsSubscriptionRepositoryProvider);
  return SmsService(smsSubscriptionRepository);
}

class SmsService {
  final SmsSubscriptionRepository _subscriptionRepository;
  final List<SmsRegexRule> _rules = [];

  SmsService(this._subscriptionRepository);

  bool validateRegexPattern(String pattern) {
    try {
      RegExp(pattern);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<SmsRegexRule>> getAllRules() async {
    return List.from(_rules);
  }

  Future<void> addRule(SmsRegexRule rule) async {
    _rules.add(rule);
  }

  Future<void> updateRule(SmsRegexRule rule) async {
    final index = _rules.indexWhere((r) => r.id == rule.id);
    if (index != -1) {
      _rules[index] = rule;
    }
  }

  Future<void> deleteRule(String ruleId) async {
    _rules.removeWhere((r) => r.id == ruleId);
  }

  Future<bool> importRulesFromFile(String filePath) async {
    return true;
  }

  Future<String?> exportRulesToFile(String directoryPath) async {
    return null;
  }
}
