/// 规则优先级值对象
/// 用于定义规则的优先级顺序
class RulePriority implements Comparable<RulePriority> {
  final int value;
  final String name;
  
  const RulePriority._({required this.value, required this.name});
  
  /// 预定义的规则优先级（从高到低）
  static const RulePriority allowed = RulePriority._(value: 100, name: 'Allowed');
  static const RulePriority blocked = RulePriority._(value: 90, name: 'Blocked');
  static const RulePriority whitelist = RulePriority._(value: 80, name: 'Whitelist');
  static const RulePriority blacklist = RulePriority._(value: 70, name: 'Blacklist');
  static const RulePriority regex = RulePriority._(value: 60, name: 'Regex');
  static const RulePriority unknown = RulePriority._(value: 10, name: 'Unknown');
  static const RulePriority defaultRule = RulePriority._(value: 0, name: 'Default');
  
  /// 获取所有预定义的规则优先级
  static List<RulePriority> get values => [
    allowed,
    blocked,
    whitelist,
    blacklist,
    regex,
    unknown,
    defaultRule,
  ];
  
  /// 根据名称获取规则优先级
  static RulePriority fromName(String name) {
    return values.firstWhere(
      (priority) => priority.name.toLowerCase() == name.toLowerCase(),
      orElse: () => defaultRule,
    );
  }
  
  /// 根据数值获取规则优先级
  static RulePriority fromValue(int value) {
    return values.firstWhere(
      (priority) => priority.value == value,
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
  
  /// 实现Comparable接口的compareTo方法
  /// 用于比较两个规则优先级的大小
  /// 返回负数表示当前优先级高于other
  /// 返回正数表示当前优先级低于other
  /// 返回0表示两个优先级相等
  @override
  int compareTo(RulePriority other) {
    // 值越大，优先级越高，所以这里用other.value - value
    return other.value - value;
  }
}