import '../entities/rule/rule_base.dart';
import '../value_objects/rule_priority.dart';

/// 规则优先级服务
/// 负责处理规则的优先级逻辑
class RulePriorityService {
  /// 根据优先级对规则列表进行排序
  /// 返回按优先级从高到低排序的规则列表
  List<RuleBase> sortByPriority(List<RuleBase> rules) {
    return List.from(rules)..sort((a, b) => a.priority.compareTo(b.priority));
  }
  
  /// 获取最高优先级的规则
  /// 如果列表为空，返回null
  RuleBase? getHighestPriority(List<RuleBase> rules) {
    if (rules.isEmpty) return null;
    return sortByPriority(rules).first;
  }
  
  /// 根据规则类型获取对应的优先级
  RulePriority getPriorityByRuleType(String ruleType) {
    switch (ruleType) {
      case 'allowed':
        return RulePriority.allowed;
      case 'blocked':
        return RulePriority.blocked;
      case 'whitelist':
        return RulePriority.whitelist;
      case 'blacklist':
        return RulePriority.blacklist;
      case 'regex':
        return RulePriority.regex;
      default:
        return RulePriority.unknown;
    }
  }
}