import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

class BlockedRule extends RuleBase {
  // 添加字段
  final String? avatar;
  
  final PhoneNumber phoneNumber;
  final String label;
  final bool isSubscribed;
  final int count;

  const BlockedRule({
    required super.id,
    required super.name,
    required super.priority,
    required this.phoneNumber,
    required this.label,  // 新增必填字段
    super.action = RuleAction.block,
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
        'label': label,  // 添加序列化
        'isSubscribed': isSubscribed,
        'count': count,
      });
  }

  factory BlockedRule.fromMap(Map<String, dynamic> map) {
    return BlockedRule(
      id: map['id'],
      name: map['name'],
      priority: RulePriority.fromInt(map['priority']),
      phoneNumber: PhoneNumber.fromString(map['phoneNumber']),
            label: map['label'] ?? '',  // 添加反序列化
      action: RuleAction.fromString(map['action']),
      isEnabled: map['isEnabled'] ?? true,
      isSubscribed: map['isSubscribed'] ?? false,
      count: map['count'] ?? 0,

    );
  }

  BlockedRule incrementCount() {
    return copyWith(count: count + 1);
  }

  @override
  BlockedRule copyWith({
    String? id,
    String? name,
    RulePriority? priority,
    RuleAction? action,
    bool? isEnabled,
    String? label,
    int? count,
    bool? isSubscribed,
  }) {
    return BlockedRule(
      id: id ?? this.id,
      name: name ?? this.name,
      priority: priority ?? this.priority,
      phoneNumber: phoneNumber,
      label: label ?? this.label,
      action: action ?? this.action,
      isEnabled: isEnabled ?? this.isEnabled,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      count: count ?? this.count,
      avatar: avatar,
    );
  }
}