import '../value_objects/phone_number.dart';
import '../entities/rule/rule_base.dart';

/// 规则匹配服务接口
abstract class RuleMatcherService {
  /// 加载规则
  Future<void> loadRules();

  /// 检查号码是否匹配规则
  Future<bool> matchesRule(PhoneNumber phoneNumber, String ruleType);

  /// 获取匹配的规则ID
  Future<String?> getMatchedRuleId(PhoneNumber phoneNumber);

  /// 获取匹配的规则类型
  Future<String?> getMatchedRuleType(PhoneNumber phoneNumber);

  /// 获取匹配的规则
  Future<RuleBase?> findMatchingRule(PhoneNumber phoneNumber);

  /// 检查号码是否应该被阻止
  Future<bool> shouldBlockNumber(PhoneNumber phoneNumber);

  /// 检查输入是否匹配规则
  bool matches(RuleBase rule, String input) {
    if (!rule.isEnabled) {
      return false;
    }

    return rule.matches(input);
  }

  /// 从规则列表中找出所有匹配的规则
  List<RuleBase> findMatches(List<RuleBase> rules, String input) {
    return rules
        .where((rule) => rule.isEnabled && rule.matches(input))
        .toList();
  }

  /// 从规则列表中找出第一个匹配的规则
  RuleBase? findFirstMatch(List<RuleBase> rules, String input) {
    for (final rule in rules) {
      if (rule.isEnabled && rule.matches(input)) {
        return rule;
      }
    }
    return null;
  }
}
