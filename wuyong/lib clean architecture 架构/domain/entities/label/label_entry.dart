import '../base/entity.dart';

/// 标签条目实体
/// 用于定义电话号码的标签分类
class LabelEntry extends Entity {
  final String name;        // 标签名称
  final String description; // 标签描述
  final String color;       // 标签颜色（十六进制颜色代码）
  final String icon;        // 标签图标
  final bool isSystem;      // 是否为系统标签
  final int order;          // 排序顺序
  
  const LabelEntry({
    required super.id,
    required this.name,
    this.description = '',
    required this.color,
    required this.icon,
    this.isSystem = false,
    this.order = 0,
  });
  
  /// 创建一个新的标签条目，但更新某些属性
  LabelEntry copyWith({
    String? id,
    String? name,
    String? description,
    String? color,
    String? icon,
    bool? isSystem,
    int? order,
  }) {
    return LabelEntry(
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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LabelEntry &&
        other.id == id &&
        other.name == name &&
        other.color == color &&
        other.icon == icon;
  }
  
  @override
  int get hashCode => Object.hash(id, name, color, icon);
}