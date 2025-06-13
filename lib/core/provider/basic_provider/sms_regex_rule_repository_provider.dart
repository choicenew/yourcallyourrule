import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';
import 'package:yourcallyourrule/features/sms/repositories/sms_regex_rule_repository.dart';

/// SMS正则规则仓库提供者
final smsRegexRuleRepositoryProvider = Provider<SmsRegexRuleRepository>((ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  return SmsRegexRuleRepository(ruleRepository);
});