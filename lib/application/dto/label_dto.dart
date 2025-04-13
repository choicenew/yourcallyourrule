import '../../domain/entities/label/label_entry.dart';
import 'base_dto.dart';

/// 标签数据传输对象
/// 用于应用层和表现层之间的数据传输
class LabelDto extends BaseDto {
  final String id;
  final String name;
  final String description;
  final String color;
  final String icon;
  final bool isSystem;
  final int order;
  
  LabelDto({
    required this.id,
    required this.name,
    this.description = '',
    required this.color,
    required this.icon,
    this.isSystem = false,
    this.order = 0,
  });
  
  /// 从实体创建DTO
  factory LabelDto.fromEntity(LabelEntry label) {
    return LabelDto(
      id: label.id,
      name: label.name,
      description: label.description,
      color: label.color,
      icon: label.icon,
      isSystem: label.isSystem,
      order: label.order,
    );
  }
  
  /// 转换为实体
  LabelEntry toEntity() {
    return LabelEntry(
      id: id,
      name: name,
      description: description,
      color: color,
      icon: icon,
      isSystem: isSystem,
      order: order,
    );
  }
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'color': color,
      'icon': icon,
      'isSystem': isSystem,
      'order': order,
    };
  }
  
  /// 从Map创建DTO
  factory LabelDto.fromMap(Map<String, dynamic> map) {
    return LabelDto(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String? ?? '',
      color: map['color'] as String,
      icon: map['icon'] as String,
      isSystem: map['isSystem'] as bool? ?? false,
      order: map['order'] as int? ?? 0,
    );
  }
}