// SIM卡槽位规则模型，用于管理与SIM卡槽位相关的规则

import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

/// SIM卡槽位规则模型
/// 用于管理特定SIM卡槽位的规则，实现RuleBase接口
class SimSlotRuleModel extends RuleBase {
  // 电话号码
  final String phoneNumber;
  
  // SIM卡槽位索引
  final int simSlotIndex;
  
  // 标签（可选）
  final String label;
  
  // 头像（可选）
  final String? avatar;

  const SimSlotRuleModel({
    required super.id,
    required super.name,
    required super.priority,
    required super.action,
    required this.phoneNumber,
    required this.simSlotIndex,
    this.label = '',
    this.avatar,
    super.isEnabled = true,
  });

  factory SimSlotRuleModel.fromMap(Map<String, dynamic> map) {
    return SimSlotRuleModel(
      id: map['id'],
      name: map['name'],
      priority: RulePriority(map['priority']),
      action: RuleAction.fromString(map['action']),
      phoneNumber: map['phoneNumber'],
      simSlotIndex: map['simSlotIndex'],
      label: map['label'] ?? '',
      avatar: map['avatar'],
      isEnabled: map['isEnabled'] ?? true,
    );
  }
  
  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber,
      'simSlotIndex': simSlotIndex,
      'label': label,
      'avatar': avatar,
      'ruleType': 'sim_slot', // 添加规则类型标识
    });
    return map;
  }
  
  // 实现规则匹配方法
  @override
  bool matches(String input) {
    // 检查输入是否与电话号码匹配
    return isEnabled && phoneNumber == input;
  }
  
  // 实现copyWith方法
  @override
  SimSlotRuleModel copyWith({
    String? id,
    String? name,
    RulePriority? priority,
    RuleAction? action,
    bool? isEnabled,
    String? phoneNumber,
    int? simSlotIndex,
    String? label,
    String? avatar,
  }) {
    return SimSlotRuleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      priority: priority ?? this.priority,
      action: action ?? this.action,
      isEnabled: isEnabled ?? this.isEnabled,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      simSlotIndex: simSlotIndex ?? this.simSlotIndex,
      label: label ?? this.label,
      avatar: avatar ?? this.avatar,
    );
  }
  
  // 将模型转换为实体
  SimSlotRule toEntity() {
    return SimSlotRule(
      id: id,
      name: name,
      priority: priority,
      action: action,
      phoneNumber: PhoneNumber.fromString(phoneNumber),
      simSlotIndex: simSlotIndex,
      label: label,
      avatar: avatar,
      isEnabled: isEnabled,
    );
  }
  
  // 从实体创建模型
  static SimSlotRuleModel fromEntity(SimSlotRule entity) {
    return SimSlotRuleModel(
      id: entity.id,
      name: entity.name,
      priority: entity.priority,
      action: entity.action,
      phoneNumber: entity.phoneNumber.value,
      simSlotIndex: entity.simSlotIndex,
      label: entity.label,
      avatar: entity.avatar,
      isEnabled: entity.isEnabled,
    );
  }
}