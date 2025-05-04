import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

class AllowedRule extends RuleBase {
  final PhoneNumber phoneNumber;
  final String label; // 新增标签字段
  final bool isSubscribed;
  final int count;
  final String? avatar; // 新增avatar字段

  const AllowedRule({
    required super.id,
    required super.name,
    required super.priority,
    required this.phoneNumber,
    required this.label, // 必填参数
    super.action = RuleAction.allow,
    super.isEnabled = true,
    this.isSubscribed = false,
    this.count = 0,
    this.avatar, // 新增可选参数
  });

  @override
  bool matches(String input) {
    return isEnabled && phoneNumber.value == input;
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'phoneNumber': phoneNumber.value,
        'label': label, // 序列化标签
        'isSubscribed': isSubscribed,
        'count': count,
        'avatar': avatar, // 序列化avatar
      });
  }

  factory AllowedRule.fromMap(Map<String, dynamic> map) {
    return AllowedRule(
      id: map['id'],
      name: map['name'],
      priority: RulePriority.fromInt(map['priority']),
      phoneNumber: PhoneNumber.fromString(map['phoneNumber']),
      label: map['label'] ?? '', // 反序列化标签
      action: RuleAction.fromString(map['action']),
      isEnabled: map['isEnabled'] ?? true,
      isSubscribed: map['isSubscribed'] ?? false,
      count: map['count'] ?? 0,
      avatar: map['avatar'], // 反序列化avatar
    );
  }

  AllowedRule incrementCount() {
    return copyWith(count: count + 1);
  }

  @override
  AllowedRule copyWith({
    RuleAction? action,
    String? id,
    bool? isEnabled,
    String? name,
    RulePriority? priority,
    String? label,
    bool? isSubscribed,
    int? count,
    String? avatar,
  }) {
    return AllowedRule(
      id: id ?? this.id,
      name: name ?? this.name,
      priority: priority ?? this.priority,
      phoneNumber: phoneNumber,
      label: label ?? this.label,
      action: action ?? this.action,
      isEnabled: isEnabled ?? this.isEnabled,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      count: count ?? this.count,
      avatar: avatar ?? this.avatar,
    );
  }
}