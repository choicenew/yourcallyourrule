// 规则动作值对象，用于表示规则匹配后要执行的动作

enum RuleActionType {
  allow,    // 允许
  block,    // 阻止
  silence,  // 静音
  redirect, // 重定向
  label,    // 标记
  notify,   // 通知
  log,      // 记录
  custom,   // 自定义
  none,     // 无动作
}

class RuleAction {
  // 动作类型
  final RuleActionType type;
  
  // 动作参数（可选，用于自定义动作）
  final Map<String, dynamic>? parameters;
  
  // 构造函数
  const RuleAction({
    required this.type,
    this.parameters,
  });
  
  // 预定义的动作常量
  static const RuleAction allow = RuleAction(type: RuleActionType.allow);
  static const RuleAction block = RuleAction(type: RuleActionType.block);
  static const RuleAction silence = RuleAction(type: RuleActionType.silence);
  static const RuleAction none = RuleAction(type: RuleActionType.none);
  
  // 创建带参数的动作
  factory RuleAction.withParams(RuleActionType type, Map<String, dynamic> params) {
    return RuleAction(type: type, parameters: params);
  }
  
  // 相等性比较
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RuleAction && 
           other.type == type && 
           _mapEquals(other.parameters, parameters);
  }
  
  // 辅助方法：比较两个Map是否相等
  bool _mapEquals(Map<String, dynamic>? map1, Map<String, dynamic>? map2) {
    if (map1 == null && map2 == null) return true;
    if (map1 == null || map2 == null) return false;
    if (map1.length != map2.length) return false;
    
    for (final key in map1.keys) {
      if (!map2.containsKey(key) || map1[key] != map2[key]) {
        return false;
      }
    }
    
    return true;
  }
  
  // 哈希码
  @override
  int get hashCode => Object.hash(type, parameters);
  
  // 字符串表示
  @override
  String toString() {
    if (parameters == null || parameters!.isEmpty) {
      return type.toString().split('.').last;
    }
    return '${type.toString().split('.').last}:$parameters';
  }
  
  // 从字符串解析动作
  factory RuleAction.fromString(String actionStr) {
    if (actionStr.contains(':')) {
      final parts = actionStr.split(':');
      final typeStr = parts[0];
      final paramsStr = parts[1];
      
      // 解析类型
      final type = RuleActionType.values.firstWhere(
        (t) => t.toString().split('.').last == typeStr,
        orElse: () => RuleActionType.custom,
      );
      
      // 解析参数（简化实现，实际应用中可能需要更复杂的解析）
      final params = <String, dynamic>{};
      // 这里应该有参数解析逻辑
      
      return RuleAction(type: type, parameters: params);
    } else {
      // 没有参数的情况
      final type = RuleActionType.values.firstWhere(
        (t) => t.toString().split('.').last == actionStr,
        orElse: () => RuleActionType.custom,
      );
      
      return RuleAction(type: type);
    }
  }
}