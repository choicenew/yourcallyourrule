// 规则数据模型，用于数据层与领域层之间的转换

import 'package:yourcallyourrule/data/models/rule_model.dart';


import '../../core/entities/rule/regex_rule.dart';
import '../../core/value_objects/rule_priority.dart';
import '../../core/value_objects/rule_action.dart';

// 正则规则模型
class RegexRuleModel extends RuleModel {
  // 正则表达式
  final String pattern;
  // 订阅ID
  final String? subscriptionId;

  // 是否订阅的计算属性
  bool get isSubscribed => subscriptionId != null;

  // 构造函数
  const RegexRuleModel({
    required super.id,
    required super.name,
    required super.priority,
    required super.action,
    required this.pattern,
    super.isEnabled,
    this.subscriptionId,
    String? ruleType, // Make ruleType optional
  }) : super(
          ruleType: ruleType ?? 'regex',
        );

  // 从Map创建模型
  factory RegexRuleModel.fromMap(Map<String, dynamic> map) {
    return RegexRuleModel(
      id: map['id'],
      name: map['name'],
      priority: map['priority'],
      action: map['action'],
      pattern: map['pattern'],
      isEnabled: (map['isEnabled'] ?? 1) == 1,
      subscriptionId: map['subscriptionId'],
      ruleType: map['ruleType'], // Read ruleType from map
    );
  }

  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'pattern': pattern,
      'subscriptionId': subscriptionId,
    });
    return map;
  }

  // 将模型转换为实体
  @override
  RegexRule toEntity() {
    return RegexRule(
      id: id,
      name: name,
      priority: RulePriority(priority),
      action: RuleAction.fromString(action),
      pattern: pattern,
      isEnabled: isEnabled,
      subscriptionId: subscriptionId,
    );
  }

  // 从实体创建模型
  static RegexRuleModel fromEntity(RegexRule entity) {
    return RegexRuleModel(
      id: entity.id,
      name: entity.name,
      priority: entity.priority.value,
      action: entity.action.toString(),
      pattern: entity.pattern,
      isEnabled: entity.isEnabled,
      subscriptionId: entity.subscriptionId,
    );
  }
}
