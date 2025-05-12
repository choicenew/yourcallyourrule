// 规则数据模型，用于数据层与领域层之间的转换

import 'package:yourcallyourrule/core/entities/rule/white_black_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';

import '../../core/entities/rule/rule_base.dart';
import '../../core/entities/rule/blacklist_rule.dart';
import '../../core/entities/rule/whitelist_rule.dart';
import '../../core/entities/rule/allowed_blocked_rule.dart';
import '../../core/entities/rule/regex_rule.dart';
import '../../core/value_objects/rule_priority.dart';
import '../../core/value_objects/rule_action.dart';
import 'base_model.dart';

// 规则模型基类
abstract class RuleModel extends BaseModel<RuleBase> {
  // 规则名称
  final String name;

  // 规则优先级
  final int priority;

  // 规则动作
  final String action;

  // 规则是否启用
  final bool isEnabled;

  // 规则类型
  final String ruleType;

  // 构造函数
  const RuleModel({
    required super.id,
    required this.name,
    required this.priority,
    required this.action,
    required this.ruleType,
    this.isEnabled = true,
  });

  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'name': name,
      'priority': priority,
      'action': action,
      'isEnabled': isEnabled,
      'ruleType': ruleType,
    });
    return map;
  }
}











































































































































