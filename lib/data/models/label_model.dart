// 标签数据模型，用于数据层与领域层之间的转换

import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

import '../../core/entities/label/label_entry.dart';
import 'base_model.dart';

// 标签模型类
class LabelModel extends BaseModel<LabelEntry> {
  // 标签名称
  final String name;
  // 标签颜色（已注释）
  // final String color;
  // 标签图标（可选）
  final String? icon;
  // 电话号码
  final String phoneNumber;
  // 标签文本内容
  final String label;
  // 头像（可选）
  final String? avatar;
  // 优先级
  final int priority;
  // 动作
  final String action;
  // 是否启用
  final bool isEnabled;

  // 构造函数
  const LabelModel({
    required super.id,
    required this.name,
    // required this.color,
    this.icon,
    required this.phoneNumber,
    required this.label,
    this.avatar,
    this.priority = 0, // 默认优先级为0，与LabelEntry.defaultPriority一致
    this.action = 'none', // 默认动作为none，与LabelEntry.defaultAction一致
    this.isEnabled = true,
  });

  // 从Map创建模型
  factory LabelModel.fromMap(Map<String, dynamic> map) {
    return LabelModel(
      id: map['id'],
      name: map['name'] ?? '',
      // color: map['color'],
      icon: map['icon'],
      phoneNumber: map['phoneNumber'],
      label: map['label'],
      avatar: map['avatar'],
      priority: map['priority'] ?? 0,
      action: map['action'] ?? 'none',
      isEnabled: map['isEnabled'] ?? true,
    );
  }

  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'name': name,
      // 'color': color,
      'icon': icon,
      'phoneNumber': phoneNumber,
      'label': label,
      'avatar': avatar,
      'priority': priority,
      'action': action,
      'isEnabled': isEnabled,
    });
    return map;
  }

  // 将模型转换为实体
  @override
  LabelEntry toEntity() {
    return LabelEntry(
      id: id,
      phoneNumber: PhoneNumber.fromString(phoneNumber),
      label: label,
      name: name,
      // color: color,
      icon: icon,
      avatar: avatar,
      priority: RulePriority.fromInt(priority),
      action: RuleAction.fromString(action),
      isEnabled: isEnabled,
    );
  }

  // 从实体创建模型
  static LabelModel fromEntity(LabelEntry entity) {
    return LabelModel(
      id: entity.id,
      phoneNumber: entity.phoneNumber.value,
      label: entity.label,
      name: entity.name ?? '',
      // color: entity.color ?? '',
      icon: entity.icon,
      avatar: entity.avatar,
      priority: entity.priority.value,
      action: entity.action.toString().split('.').last,
      isEnabled: entity.isEnabled,
    );
  }
}