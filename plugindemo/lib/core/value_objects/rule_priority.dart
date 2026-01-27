// 规则优先级值对象，用于表示规则的优先级

class RulePriority {
  // 优先级数值，数值越大优先级越高
  final int value;
  
  // 构造函数，要求提供有效的优先级数值
  const RulePriority(this.value);
  
  // 预定义的优先级常量
  static const RulePriority veryLow = RulePriority(0);
  static const RulePriority low = RulePriority(1);
  static const RulePriority belowMedium = RulePriority(3);
  static const RulePriority medium = RulePriority(5);
  static const RulePriority aboveMedium = RulePriority(7);
  static const RulePriority high = RulePriority(10);
  static const RulePriority veryHigh = RulePriority(50);
  static const RulePriority highest = RulePriority(100);
  
  // 规则动作优先级常量
  static const RulePriority blockAction = RulePriority(2);
  static const RulePriority silenceAction = RulePriority(1);
  static const RulePriority noneAction = RulePriority(0);
  
  // 相等性比较
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RulePriority && other.value == value;
  }
  
  // 哈希码
  @override
  int get hashCode => value.hashCode;
  
  // 比较运算符，用于优先级比较
  bool operator >(RulePriority other) => value > other.value;
  bool operator <(RulePriority other) => value < other.value;
  bool operator >=(RulePriority other) => value >= other.value;
  bool operator <=(RulePriority other) => value <= other.value;
  
  // 字符串表示
  @override
  String toString() => 'Priority($value)';
  
  // 从整数创建优先级
  factory RulePriority.fromInt(int value) => RulePriority(value);
}