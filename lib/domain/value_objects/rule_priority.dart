/// 规则优先级值对象
/// 用于定义规则的优先级顺序
class RulePriority {
  final int value;
  final String name;
  
  const RulePriority._({required this.value, required this.name});
  
  /// 预定义的规则优先级（从高到低）
  static const RulePriority allowed = RulePriority._(value: 100, name: 'Allowed');
  static const RulePriority blocked = RulePriority._(value: 90, name: 'Blocked');
  static const RulePriority whitelist = RulePriority._(value: 80, name: 'Whitelist');
  static const RulePriority blacklist = RulePriority._(value: 70, name: 'Blacklist');
  static const RulePriority regex = RulePriority._(value: 60, name: 'Regex');
  static const RulePriority defaultRule = RulePriority._(value: 0, name: 'Default');
  
  /// 获取所有预定义的规则优先级
  static List<RulePriority> get values => [
    allowed,
    blocked,
    whitelist,
    blacklist,
    regex,
    defaultRule,
  ];
  
  /// 根据名称获取规则优先级
  static RulePriority fromName(String name) {
    return values.firstWhere(
      (priority) => priority.name.toLowerCase() == name.toLowerCase(),
      orElse: () => defaultRule,
    );
  }
  
  /// 比较两个规则优先级
  bool isHigherThan(RulePriority other) {
    return value > other.value;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RulePriority && other.value == value;
  }
  
  @override
  int get hashCode => value.hashCode;
  
  @override
  String toString() => name;
}