// 规则数据模型，用于数据层与领域层之间的转换

import 'package:yourcallyourrule/core/value_objects/phone_number.dart';

import '../../core/entities/rule/rule_base.dart';
import '../../core/entities/rule/blacklist_rule.dart';
import '../../core/entities/rule/whitelist_rule.dart';
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

// 黑名单规则模型
// BlacklistRuleModel 修改
class BlacklistRuleModel extends RuleModel {
  final String phoneNumber;
  final String label;
  final String? avatar; // 新增avatar字段

  const BlacklistRuleModel({
    required super.id,
    required super.name,
    required super.priority,
    required super.action,
    required this.phoneNumber,
    required this.label,
    this.avatar, // 新增可选参数
    super.isEnabled,
  }) : super(ruleType: 'blacklist');

  factory BlacklistRuleModel.fromMap(Map<String, dynamic> map) {
    return BlacklistRuleModel(
      id: map['id'],
      name: map['name'],
      priority: map['priority'],
      action: map['action'],
      phoneNumber: map['phoneNumber'],
      label: map['label'] ?? '', // 读取label字段
      isEnabled: map['isEnabled'] ?? true,
    );
  }
  
  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber,
      'label': label,
      'avatar': avatar, // 序列化avatar
    });
    return map;
  }
  
  // 将模型转换为实体
  @override
  BlacklistRule toEntity() {
    return BlacklistRule(
      id: id,
      name: name,
      priority: RulePriority(priority),
      action: RuleAction.fromString(action),
      phoneNumber: PhoneNumber.fromString(phoneNumber),
      label: label, // 传递label
      isEnabled: isEnabled,
    );
  }
  
  // 从实体创建模型
  static BlacklistRuleModel fromEntity(BlacklistRule entity) {
    return BlacklistRuleModel(
      id: entity.id,
      name: entity.name,
      priority: entity.priority.value,
      action: entity.action.toString(),
      phoneNumber: entity.phoneNumber.value,
      label: entity.label, // 获取实体label
      isEnabled: entity.isEnabled,
      avatar: entity.avatar, // 获取实体avatar
    );
  }
}

// 白名单规则模型
class WhitelistRuleModel extends RuleModel {
  // 电话号码
  final String phoneNumber;
  final String label;
  final String? avatar; // 新增avatar字段

  const WhitelistRuleModel({
    required super.id,
    required super.name,
    required super.priority,
    required super.action,
    required this.phoneNumber,
    required this.label,
    this.avatar, // 新增可选参数
    super.isEnabled,
  }) : super(ruleType: 'whitelist');

  factory WhitelistRuleModel.fromMap(Map<String, dynamic> map) {
    return WhitelistRuleModel(
      id: map['id'],
      name: map['name'],
      priority: map['priority'],
      action: map['action'],
      phoneNumber: map['phoneNumber'],
      label: map['label'] ?? '', // 读取label字段
      isEnabled: map['isEnabled'] ?? true,
    );
  }
  
  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber,
      'label': label,
      'avatar': avatar, // 序列化avatar
    });
    return map;
  }

  @override
  WhitelistRule toEntity() {
    return WhitelistRule(
      id: id,
      name: name,
      priority: RulePriority(priority),
      action: RuleAction.fromString(action),
      phoneNumber: PhoneNumber.fromString(phoneNumber),
      label: label, // 传递label
      isEnabled: isEnabled,
    );
  }

  static WhitelistRuleModel fromEntity(WhitelistRule entity) {
    return WhitelistRuleModel(
      id: entity.id,
      name: entity.name,
      priority: entity.priority.value,
      action: entity.action.toString(),
      phoneNumber: entity.phoneNumber.value,
      label: entity.label, // 获取实体label
      isEnabled: entity.isEnabled,
      avatar: entity.avatar, // 获取实体avatar
    );
  }
}

// 正则规则模型
class RegexRuleModel extends RuleModel {
  // 正则表达式
  final String pattern;
  
  // 构造函数
  const RegexRuleModel({
    required super.id,
    required super.name,
    required super.priority,
    required super.action,
    required this.pattern,
    super.isEnabled,
  }) : super(
    ruleType: 'regex',
  );
  
  // 从Map创建模型
  factory RegexRuleModel.fromMap(Map<String, dynamic> map) {
    return RegexRuleModel(
      id: map['id'],
      name: map['name'],
      priority: map['priority'],
      action: map['action'],
      pattern: map['pattern'],
      isEnabled: map['isEnabled'] ?? true,
    );
  }
  
  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'pattern': pattern,
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
    );
  }
}