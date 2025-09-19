// 标签数据模型，用于数据层与领域层之间的转换

import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

import 'rule_model.dart';

// 标签模型类
class LabelModel extends RuleModel {
  // 标签图标（可选）
  final String? icon;
  // 电话号码
  final String phoneNumber;
  // 标签ID，引用PredefinedLabel
  final String labelId;
  // 头像（可选）
  final String? avatar;

  // 构造函数
  const LabelModel({
    required super.id,
    required super.name,
    required super.priority,
    required super.action,
    this.icon,
    required this.phoneNumber,
    required this.labelId,
    this.avatar,
    super.isEnabled = true,
  }) : super(ruleType: 'label');

  // 从Map创建模型
  factory LabelModel.fromMap(Map<String, dynamic> map) {
    return LabelModel(
      id: map['id'],
      name: map['name'] ?? '',
      icon: map['icon'],
      phoneNumber: map['phoneNumber'],
      labelId: map['labelId'], // 只使用labelId，不再兼容旧数据
      avatar: map['avatar'],
      priority: map['priority'] ?? 0,
      action: map['action'] ?? 'none',
      isEnabled: (map['isEnabled'] ?? 1) == 1,
    );
  }

  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'icon': icon,
      'phoneNumber': phoneNumber,
      'labelId': labelId,
      'avatar': avatar,
    });
    return map;
  }

  // 将模型转换为实体
  @override
  LabelPhoneEntry toEntity() {
    return LabelPhoneEntry(
      id: id,
      phoneNumber: PhoneNumber.fromString(phoneNumber),
      labelId: labelId,
      name: name,
      icon: icon,
      avatar: avatar,
      priority: RulePriority.fromInt(priority),
      action: RuleAction.fromString(action),
      isEnabled: isEnabled,
    );
  }

  // 从实体创建模型
  static LabelModel fromEntity(LabelPhoneEntry entity) {
    return LabelModel(
      id: entity.id,
      phoneNumber: entity.phoneNumber.value,
      labelId: entity.labelId,
      name: entity.name ?? '',
      icon: entity.icon,
      avatar: entity.avatar,
      priority: entity.priority.value,
      action: entity.action.toString(),
      isEnabled: entity.isEnabled,
    );
  }
}