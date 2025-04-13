import 'base_dto.dart';

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