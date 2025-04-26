import '../../domain/entities/label/label_entry.dart';
import 'base_model.dart';

/// 标签模型
/// 用于数据库操作的标签数据模型
class LabelModel extends BaseModel<LabelEntry> {
  final String id;
  final String name;
  final String description;
  final String color;
  final String icon;
  final bool isSystem;
  final int order;
  
  LabelModel({
    required this.id,
    required this.name,
    this.description = '',
    required this.color,
    required this.icon,
    this.isSystem = false,
    this.order = 0,
  });
  
  /// 从实体创建模型
  factory LabelModel.fromEntity(LabelEntry label) {
    return LabelModel(
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
  
  /// 创建一个新的标签模型，但更新某些属性
  LabelModel copyWith({
    String? id,
    String? name,
    String? description,
    String? color,
    String? icon,
    bool? isSystem,
    int? order,
  }) {
    return LabelModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      isSystem: isSystem ?? this.isSystem,
      order: order ?? this.order,
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
      'is_system': isSystem ? 1 : 0,
      'order': order,
    };
  }
  
  /// 从Map创建模型
  factory LabelModel.fromMap(Map<String, dynamic> map) {
    return LabelModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String? ?? '',
      color: map['color'] as String,
      icon: map['icon'] as String,
      isSystem: (map['is_system'] as int?) == 1,
      order: map['order'] as int? ?? 0,
    );
  }
}