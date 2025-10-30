import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';
import 'package:yourcallyourrule/core/repositories/base_repository.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';

/// SMS规则仓库的Provider
/// 提供一个类型安全的RuleRepository实例，专门用于SmsRegexRule
final smsRuleRepositoryProvider = Provider<BaseRepository<SmsRegexRule, String>>((ref) {
  // 使用现有的ruleRepositoryProvider，但进行类型转换
  // 这里我们假设RuleRepository可以处理SmsRegexRule类型
  // 如果实际实现不兼容，可能需要创建一个适配器或包装类
  return ref.watch(ruleRepositoryProvider) as BaseRepository<SmsRegexRule, String>;
});