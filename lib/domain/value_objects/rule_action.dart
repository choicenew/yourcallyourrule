/// 规则动作值对象
/// 定义规则匹配后应该执行的操作
class RuleAction {
  final String value;
  
  const RuleAction._({required this.value});
  
  /// 预定义的规则动作
  static const RuleAction allow = RuleAction._(value: 'ALLOW'); // 允许通过
  static const RuleAction block = RuleAction._(value: 'BLOCK'); // 阻止
  static const RuleAction silent = RuleAction._(value: 'SILENT'); // 静音
  static const RuleAction notify = RuleAction._(value: 'NOTIFY'); // 通知
  static const RuleAction unknown = RuleAction._(value: 'UNKNOWN'); // 未知动作
  
  /// 获取所有预定义的规则动作
  static List<RuleAction> get values => [
    allow,
    block,
    silent,
    notify,
  ];
  
  /// 根据值获取规则动作
  static RuleAction fromValue(String value) {
    return values.firstWhere(
      (action) => action.value == value.toUpperCase(),
      orElse: () => unknown,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RuleAction && other.value == value;
  }
  
  @override
  int get hashCode => value.hashCode;
  
  @override
  String toString() => value;
}