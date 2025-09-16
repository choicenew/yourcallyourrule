// 规则数据模型，用于数据层与领域层之间的转换

import '../../core/entities/rule/allowed_blocked_rule.dart';
import '../../core/entities/rule/phone_rule.dart';
import '../../core/entities/rule/regex_rule.dart';
import '../../core/entities/rule/rule_base.dart';
import 'allow_block_rule_model.dart';
import 'base_model.dart';
import 'phone_rule_model.dart';
import 'regex_rule_model.dart';

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
      'isEnabled': isEnabled ? 1 : 0,
      'ruleType': ruleType,
    });
    return map;
  }
  
  // 工厂方法，根据实体类型创建对应的模型
  static RuleModel fromEntity(RuleBase entity) {
    if (entity is PhoneRule) {
      return PhoneRuleModel.fromEntity(entity);
    }
    if (entity is AllowedBlockedRule) {
      return AllowedBlockedRuleModel.fromEntity(entity);
    }
    if (entity is RegexRule) {
      return RegexRuleModel.fromEntity(entity);
    }
    
    // 如果传入不支持的类型，抛出异常
    throw ArgumentError('不支持的规则实体类型: ${entity.runtimeType}');
  }
}

// 基于电话号码的规则模型基类
abstract class PhoneBasedRuleModel extends RuleModel {
  final String phoneNumber;
  final String labelId;
  final int count;
  final String? avatar;
  final String? subscriptionId;

  const PhoneBasedRuleModel({
    required super.id,
    required super.name,
    required super.priority,
    required super.action,
    required super.ruleType,
    required this.phoneNumber,
    required this.labelId,
    required this.count,
    this.avatar,
    this.subscriptionId,
    super.isEnabled,
  });

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber,
      'labelId': labelId,
      'count': count,
      'avatar': avatar,
      'subscriptionId': subscriptionId,
    });
    return map;
  }
}











































































































































