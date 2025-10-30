// SIM卡槽位规则实体，用于表示特定SIM卡槽位的规则

import '../../value_objects/phone_number.dart';
import '../../value_objects/rule_action.dart';
import '../../value_objects/rule_priority.dart';
import 'rule_base.dart';

/// SIM卡槽位规则实体
/// 用于表示特定SIM卡槽位的规则，继承自RuleBase
class SimSlotRule extends RuleBase {
  // 电话号码
  final PhoneNumber phoneNumber;
  
  // SIM卡槽位索引
  final int simSlotIndex;
  
  // 标签ID
  final String labelId;
  
  // 头像（可选）
  final String? avatar;

  // [新增]: 添加 ruleType 字段以供仓库层识别
  final String ruleType;

  // 构造函数
  const SimSlotRule({
    required super.id,
    required super.name,
    required super.priority,
    required this.phoneNumber,
    required this.simSlotIndex,
    this.labelId = '',
    this.avatar,
        // [新增]: 为 ruleType 提供默认值
    this.ruleType = 'sim_slot', 
    super.action = RuleAction.block,
    super.isEnabled = true,
  });

  // 实现规则匹配方法
  @override
  bool matches(String input) {
    // 检查输入是否与电话号码匹配
    return isEnabled && phoneNumber.value == input;
  }

  // 重写toMap方法，添加SIM卡槽位规则特有的字段
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber.value,
      'simSlotIndex': simSlotIndex,
      'labelId': labelId,
      'avatar': avatar,
      'isEnabled': isEnabled ? 1 : 0,
      'ruleType': ruleType,
    });
    return map;
  }

  // 实现copyWith方法
  @override
  SimSlotRule copyWith({
    String? id,
    String? name,
    RulePriority? priority,
    RuleAction? action,
    bool? isEnabled,
    PhoneNumber? phoneNumber,
    int? simSlotIndex,
    String? labelId,
    String? avatar,
    String? ruleType,
  }) {
    return SimSlotRule(
      id: id ?? this.id,
      name: name ?? this.name,
      priority: priority ?? this.priority,
      action: action ?? this.action,
      isEnabled: isEnabled ?? this.isEnabled,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      simSlotIndex: simSlotIndex ?? this.simSlotIndex,
      labelId: labelId ?? this.labelId,
      avatar: avatar ?? this.avatar,
      ruleType: ruleType ?? this.ruleType,
    );
  }
  
  // 从Map创建SimSlotRule实例
  factory SimSlotRule.fromMap(Map<String, dynamic> map) {
    return SimSlotRule(
      id: map['id'],
      name: map['name'],
      priority: RulePriority.fromInt(map['priority']),
      action: RuleAction.fromString(map['action']),
      phoneNumber: PhoneNumber.fromString(map['phoneNumber']),
      simSlotIndex: map['simSlotIndex'],
      labelId: map['labelId'] ?? '',
      avatar: map['avatar'],
      isEnabled: (map['isEnabled'] ?? 1) == 1,
      ruleType: map['ruleType'] ?? 'sim_slot',
    );
  }
}