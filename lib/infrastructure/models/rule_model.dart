import '../../domain/entities/rule/rule_base.dart';
import '../../domain/entities/rule/allowed_rule.dart';
import '../../domain/entities/rule/blocked_rule.dart';
import '../../domain/entities/rule/whitelist_rule.dart';
import '../../domain/entities/rule/blacklist_rule.dart';
import '../../domain/entities/rule/regex_rule.dart';
import '../../domain/value_objects/phone_number.dart';
import '../../domain/value_objects/rule_action.dart';
import '../../domain/value_objects/rule_priority.dart';
import 'base_model.dart';

/// 规则模型
/// 用于将规则实体转换为数据库可存储的格式
class RuleModel extends BaseModel<RuleModel> {
  final String id;
  final String name;
  final String description;
  final bool isEnabled;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String priorityName;
  final int priorityValue;
  final String actionValue;
  final String ruleType; // allowed, blocked, whitelist, blacklist, regex
  final String? phoneNumber; // 用于电话号码类型的规则
  final String? pattern; // 用于正则表达式规则
  final bool? caseSensitive; // 用于正则表达式规则
  final String source; // 用户添加/订阅
  
  RuleModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isEnabled,
    required this.createdAt,
    this.updatedAt,
    required this.priorityName,
    required this.priorityValue,
    required this.actionValue,
    required this.ruleType,
    this.phoneNumber,
    this.pattern,
    this.caseSensitive,
    required this.source,
  });
  
  /// 从规则实体创建模型
  factory RuleModel.fromEntity(RuleBase rule) {
    // 基本属性
    final model = RuleModel(
      id: rule.id,
      name: rule.name,
      description: rule.description,
      isEnabled: rule.isEnabled,
      createdAt: rule.createdAt,
      updatedAt: rule.updatedAt,
      priorityName: rule.priority.name,
      priorityValue: rule.priority.value,
      actionValue: rule.action.value,
      source: rule.source,
      ruleType: '',
    );
    
    // 根据规则类型设置特定属性
    if (rule is AllowedRule) {
      return model.copyWith(
        ruleType: 'allowed',
        phoneNumber: rule.phoneNumber.value,
      );
    } else if (rule is BlockedRule) {
      return model.copyWith(
        ruleType: 'blocked',
        phoneNumber: rule.phoneNumber.value,
      );
    } else if (rule is WhitelistRule) {
      return model.copyWith(
        ruleType: 'whitelist',
        phoneNumber: rule.phoneNumber.value,
      );
    } else if (rule is BlacklistRule) {
      return model.copyWith(
        ruleType: 'blacklist',
        phoneNumber: rule.phoneNumber.value,
      );
    } else if (rule is RegexRule) {
      return model.copyWith(
        ruleType: 'regex',
        pattern: rule.pattern,
        caseSensitive: rule.caseSensitive,
      );
    }
    
    return model;
  }
  
  /// 将模型转换为规则实体
  RuleBase toEntity() {
    final priority = RulePriority.fromName(priorityName);
    final action = RuleAction.fromValue(actionValue);
    
    switch (ruleType) {
      case 'allowed':
        return AllowedRule(
          id: id,
          name: name,
          description: description,
          isEnabled: isEnabled,
          createdAt: createdAt,
          updatedAt: updatedAt,
          phoneNumber: PhoneNumber(phoneNumber!),
          source: source,
        );
      case 'blocked':
        return BlockedRule(
          id: id,
          name: name,
          description: description,
          isEnabled: isEnabled,
          createdAt: createdAt,
          updatedAt: updatedAt,
          phoneNumber: PhoneNumber(phoneNumber!),
          source: source,
        );
      case 'whitelist':
        return WhitelistRule(
          id: id,
          name: name,
          description: description,
          isEnabled: isEnabled,
          createdAt: createdAt,
          updatedAt: updatedAt,
          phoneNumber: PhoneNumber(phoneNumber!),
          source: source,
        );
      case 'blacklist':
        return BlacklistRule(
          id: id,
          name: name,
          description: description,
          isEnabled: isEnabled,
          createdAt: createdAt,
          updatedAt: updatedAt,
          phoneNumber: PhoneNumber(phoneNumber!),
          source: source,
        );
      case 'regex':
        return RegexRule(
          id: id,
          name: name,
          description: description,
          isEnabled: isEnabled,
          createdAt: createdAt,
          updatedAt: updatedAt,
          pattern: pattern!,
          caseSensitive: caseSensitive ?? false,
          action: action,
          source: source,
        );
      default:
        throw ArgumentError('Unknown rule type: $ruleType');
    }
  }
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'is_enabled': isEnabled ? 1 : 0,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
      'priority_name': priorityName,
      'priority_value': priorityValue,
      'action_value': actionValue,
      'rule_type': ruleType,
      'phone_number': phoneNumber,
      'pattern': pattern,
      'case_sensitive': caseSensitive != null ? (caseSensitive! ? 1 : 0) : null,
      'source': source,
    };
  }
  
  /// 从Map创建模型
  factory RuleModel.fromMap(Map<String, dynamic> map) {
    return RuleModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      isEnabled: map['is_enabled'] == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: map['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updated_at'])
          : null,
      priorityName: map['priority_name'],
      priorityValue: map['priority_value'],
      actionValue: map['action_value'],
      ruleType: map['rule_type'],
      phoneNumber: map['phone_number'],
      pattern: map['pattern'],
      caseSensitive: map['case_sensitive'] != null ? map['case_sensitive'] == 1 : null,
      source: map['source'],
    );
  }
  
  /// 创建模型的副本并更新指定字段
  RuleModel copyWith({
    String? id,
    String? name,
    String? description,
    bool? isEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? priorityName,
    int? priorityValue,
    String? actionValue,
    String? ruleType,
    String? phoneNumber,
    String? pattern,
    bool? caseSensitive,
    String? source,
  }) {
    return RuleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isEnabled: isEnabled ?? this.isEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      priorityName: priorityName ?? this.priorityName,
      priorityValue: priorityValue ?? this.priorityValue,
      actionValue: actionValue ?? this.actionValue,
      ruleType: ruleType ?? this.ruleType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      pattern: pattern ?? this.pattern,
      caseSensitive: caseSensitive ?? this.caseSensitive,
      source: source ?? this.source,
    );
  }
}