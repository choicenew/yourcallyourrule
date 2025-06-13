import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/sms_regex_rule_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/sms_subscription_repository_provider.dart';
import 'package:yourcallyourrule/features/sms/services/sms_service.dart';

/// SmsService的Provider
final smsServiceProvider = Provider<SmsService>((ref) {
  final smsRegexRuleRepository = ref.watch(smsRegexRuleRepositoryProvider);
  final smsSubscriptionRepository = ref.watch(smsSubscriptionRepositoryProvider);
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  
  return SmsService(
    smsRegexRuleRepository,
    smsSubscriptionRepository,
    ruleRepository,
  );
});