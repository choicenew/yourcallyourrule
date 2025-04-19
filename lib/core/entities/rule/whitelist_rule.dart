// 白名单规则实体，用于表示白名单规则

import '../../value_objects/phone_number.dart';
import '../../value_objects/rule_action.dart';
import '../../value_objects/rule_priority.dart';
import 'rule_base.dart';

class WhitelistRule extends RuleBase {
  // 白名单电话号码
  final PhoneNumber phoneNumber;
  
  // 是否为订阅的白名单
  final bool isSubscribed;
  
  // 计数（可选，用于记录匹配次数）
  final int count;
  
  // 构造函数
  const WhitelistRule({
    required String id,
    required String name,
    required this.phoneNumber,
    required RulePriority priority,
    RuleAction action = RuleAction.allow,
    bool isEnabled = true,
    this.isSubscribed = false,
    this.count = 0,
  }) : super(
          id: id,
          name: name,
          priority: priority,
          action: action,
          isEnabled: isEnabled,
        );
  
  // 实现规则匹配方法
  @override
  bool matches(String input) {
    // 简单实现，检查输入是否与白名单电话号码匹配
    return isEnabled && phoneNumber.value == input;
  }
  
  // 重写toMap方法，添加白名单规则特有的字段
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber.value,
      'isSubscribed': isSubscribed,
      'count': count,
    });
    return map;
  }
  
  // 从Map创建实例的工厂构造函数
  factory WhitelistRule.fromMap(Map<String, dynamic> map) {
    return WhitelistRule(
      id: map['id'],
      name: map['name'],
      phoneNumber: PhoneNumber.fromString(map['phoneNumber']),
      priority: RulePriority.fromInt(map['priority']),
      action: RuleAction.fromString(map['action']),
      isEnabled: map['isEnabled'] ?? true,
      isSubscribed: map['isSubscribed'] ?? false,
      count: map['count'] ?? 0,
    );
  }
  
  // 创建带有递增计数的新实例
  WhitelistRule incrementCount() {
    return WhitelistRule(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      priority: priority,
      action: action,
      isEnabled: isEnabled,
      isSubscribed: isSubscribed,
      count: count + 1,
    );
  }
}