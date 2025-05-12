// 黑名单规则实体，用于表示黑名单规则

import '../../value_objects/phone_number.dart';
import '../../value_objects/rule_action.dart';
import '../../value_objects/rule_priority.dart';
import 'rule_base.dart';

class BlacklistRule extends RuleBase {
  // 黑名单电话号码
  final PhoneNumber phoneNumber;
  final String labelId; // 使用labelId引用PredefinedLabel
  // 是否为订阅的黑名单
  final bool isSubscribed;

  // 计数（可选，用于记录匹配次数）
  final int count;
  final String? avatar;

  // 构造函数
  const BlacklistRule({
    required super.id,
    required super.name,
    required super.priority,
    required this.phoneNumber,
    required this.labelId, // 必填参数，使用labelId替代label
    super.action = RuleAction.block,
    super.isEnabled = true,
    this.isSubscribed = false,
    this.count = 0,
    this.avatar, // 可选参数
  });

  // 实现规则匹配方法
  @override
  bool matches(String input) {
    // 简单实现，检查输入是否与黑名单电话号码匹配
    return isEnabled && phoneNumber.value == input;
  }

  // 重写toMap方法，添加黑名单规则特有的字段
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber.value,
      'labelId': labelId,  // 序列化labelId
      'isSubscribed': isSubscribed,
      'count': count,
      'avatar': avatar, // 序列化avatar
    });
    return map;
  }

  // 从Map创建实例的工厂构造函数
  factory BlacklistRule.fromMap(Map<String, dynamic> map) {
    return BlacklistRule(
      id: map['id'],
      name: map['name'],
      phoneNumber: PhoneNumber.fromString(map['phoneNumber']),
      labelId: map['labelId'],  // 反序列化labelId
      priority: RulePriority.fromInt(map['priority']),
      action: RuleAction.fromString(map['action']),
      isEnabled: map['isEnabled'] ?? true,
      isSubscribed: map['isSubscribed'] ?? false,
      count: map['count'] ?? 0,
      avatar: map['avatar'], // 反序列化avatar
    );
  }

  // 创建带有递增计数的新实例
  BlacklistRule incrementCount() {
    return copyWith(count: count + 1); // 改为使用copyWith保持一致性
  }

  // 添加copyWith方法代替直接修改
  @override
  BlacklistRule copyWith({
    String? id,
    String? name,
    RulePriority? priority,
    RuleAction? action,
    bool? isEnabled,
    String? labelId,
    int? count,
    bool? isSubscribed,
    String? avatar,
  }) {
    return BlacklistRule(
      id: id ?? this.id,
      name: name ?? this.name,
      priority: priority ?? this.priority,
      phoneNumber: phoneNumber,
      labelId: labelId ?? this.labelId,
      action: action ?? this.action,
      isEnabled: isEnabled ?? this.isEnabled,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      count: count ?? this.count,
      avatar: avatar ?? this.avatar,
    );
  }
}
