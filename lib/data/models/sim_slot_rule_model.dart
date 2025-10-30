import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
// [修正]: 导入 RuleModel 以便正确继承
import 'package:yourcallyourrule/data/models/rule_model.dart';

/// [修正]: SIM卡槽位规则模型，现在正确地继承自 RuleModel。
class SimSlotRuleModel extends RuleModel {
  final String phoneNumber;
  final int simSlotIndex;
  final String labelId;
  final String? avatar;
  final bool isEnabled;

  const SimSlotRuleModel({
    required super.id,
    required super.name,
    required super.priority,
    required super.action,
    required super.ruleType, // 确保从父类接收
    required this.phoneNumber,
    required this.simSlotIndex,
    required this.labelId,
    this.avatar,
    required this.isEnabled,
  });

  /// 从实体创建模型
  factory SimSlotRuleModel.fromEntity(SimSlotRule entity) {
    return SimSlotRuleModel(
      id: entity.id,
      name: entity.name,
      priority: entity.priority.value,
      action: entity.action.toString(),
      ruleType: 'sim_slot', // 明确指定 ruleType
      phoneNumber: entity.phoneNumber.value,
      simSlotIndex: entity.simSlotIndex,
      labelId: entity.labelId,
      avatar: entity.avatar,
      isEnabled: entity.isEnabled,
    );
  }

  /// 转换为实体
  @override
  SimSlotRule toEntity() {
    return SimSlotRule(
      id: id,
      name: name,
      priority: RulePriority.fromInt(priority),
      action: RuleAction.fromString(action),
      ruleType: ruleType,
      phoneNumber: PhoneNumber.fromString(phoneNumber),
      simSlotIndex: simSlotIndex,
      labelId: labelId,
      avatar: avatar,
      isEnabled: isEnabled,
    );
  }

  /// 从 Map 创建模型
  factory SimSlotRuleModel.fromMap(Map<String, dynamic> map) {
    return SimSlotRuleModel(
      id: map['id'],
      name: map['name'],
      priority: map['priority'],
      action: map['action'],
      ruleType: map['ruleType'] ?? 'sim_slot',
      phoneNumber: map['phoneNumber'],
      simSlotIndex: map['simSlotIndex'],
      labelId: map['labelId'] ?? '',
      avatar: map['avatar'],
      isEnabled: (map['isEnabled'] ?? 1) == 1,
    );
  }

  /// 转换为 Map
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'priority': priority,
      'action': action,
      'ruleType': ruleType,
      'phoneNumber': phoneNumber,
      'simSlotIndex': simSlotIndex,
      'labelId': labelId,
      'avatar': avatar,
      'isEnabled': isEnabled ? 1 : 0,
    };
  }
}