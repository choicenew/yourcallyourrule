import '../entities/rule/rule_base.dart';

/// 规则匹配服务
/// 负责匹配输入与规则
class RuleMatcherService {
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