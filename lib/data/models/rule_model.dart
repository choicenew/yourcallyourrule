// 规则数据模型，用于数据层与领域层之间的转换


import '../../core/entities/rule/rule_base.dart';


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











































































































































