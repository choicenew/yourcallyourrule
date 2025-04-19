import 'base_dto.dart';
import '../../domain/entities/rule/rule_base.dart';
import '../../domain/entities/rule/regex_rule.dart';
import '../../domain/entities/rule/allowed_rule.dart';
import '../../domain/entities/rule/blocked_rule.dart';
import '../../domain/entities/rule/whitelist_rule.dart';
import '../../domain/entities/rule/blacklist_rule.dart';
import '../../domain/value_objects/rule_priority.dart';
import '../../domain/value_objects/rule_action.dart';
import '../../domain/value_objects/phone_number.dart';

/// 规则数据传输对象
/// 用于在应用层和领域层之间传递规则数据
class RuleDto extends BaseDto {
  final String id;
  final String name;
  final String description;
  final bool isEnabled;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String priority; // 优先级名称
  final String action; // 动作值
  final String source; // 来源
  final String? pattern; // 匹配模式，用于正则规则
  final String? phoneNumber; // 电话号码，用于电话号码规则
  final String? label; // 标签
  final String? avatar; // 头像
  
  RuleDto({
    required this.id,
    required this.name,
    this.description = '',
    required this.isEnabled,
    required this.createdAt,
    this.updatedAt,
    required this.priority,
    required this.action,
    required this.source,
    this.pattern,
    this.phoneNumber,
    this.label,
    this.avatar,
  });
  
  /// 从实体创建DTO
  static RuleDto fromEntity(RuleBase rule) {
    String? phoneNumber;
    String? label;
    String? avatar;
    String? pattern;
    
    if (rule is RegexRule) {
      pattern = rule.pattern;
    } else {
      // 处理带有电话号码的规则类型
      if (rule is AllowedRule || rule is BlockedRule || 
          rule is WhitelistRule || rule is BlacklistRule) {
        phoneNumber = (rule as dynamic).phoneNumber.value;
        label = (rule as dynamic).label;
        avatar = (rule as dynamic).avatar;
      }
    }
    
    return RuleDto(
      id: rule.id,
      name: rule.name,
      description: rule.description,
      isEnabled: rule.isEnabled,
      createdAt: rule.createdAt,
      updatedAt: rule.updatedAt,
      priority: rule.priority.name,
      action: rule.action.value,
      source: rule.source,
      pattern: pattern,
      phoneNumber: phoneNumber,
      label: label,
      avatar: avatar,
    );
  }
  
  /// 从JSON创建DTO
  static RuleDto fromJson(Map<String, dynamic> json) {
    return RuleDto(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      isEnabled: json['isEnabled'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      priority: json['priority'],
      action: json['action'],
      source: json['source'],
      pattern: json['pattern'],
      phoneNumber: json['phoneNumber'],
      label: json['label'],
      avatar: json['avatar'],
    );
  }
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isEnabled': isEnabled,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'priority': priority,
      'action': action,
      'source': source,
      'pattern': pattern,
      'phoneNumber': phoneNumber,
      'label': label,
      'avatar': avatar,
    };
  }
  
  /// 从Map创建DTO
  factory RuleDto.fromMap(Map<String, dynamic> map) {
    return RuleDto(
      id: map['id'],
      name: map['name'],
      description: map['description'] ?? '',
      isEnabled: map['isEnabled'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      priority: map['priority'],
      action: map['action'],
      source: map['source'],
      pattern: map['pattern'],
      phoneNumber: map['phoneNumber'],
      label: map['label'],
      avatar: map['avatar'],
    );
  }
}