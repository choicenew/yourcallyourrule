// 预定义标签数据模型，用于数据层与领域层之间的转换

import 'package:yourcallyourrule/core/entities/label/predefined_label_entry.dart';
import 'base_model.dart';

/// 预定义标签模型类
class PredefinedLabelModel extends BaseModel<PredefinedLabel> {
  /// 标签文本内容
  final String text;
  
  /// 头像（可选）
  final String? avatar;
  
  /// 图标（可选）
  final String? icon;

  /// 构造函数
  const PredefinedLabelModel({
    required super.id,
    required this.text,
    this.avatar,
    this.icon,
  });

  /// 从Map创建模型
  factory PredefinedLabelModel.fromMap(Map<String, dynamic> map) {
    return PredefinedLabelModel(
      id: map['id'],
      text: map['text'],
      avatar: map['avatar'],
      icon: map['icon'],
    );
  }

  /// 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'text': text,
      'avatar': avatar,
      'icon': icon,
    });
    return map;
  }

  /// 将模型转换为实体
  @override
  PredefinedLabel toEntity() {
    return PredefinedLabel(
      id: id,
      text: text,
      avatar: avatar,
      icon: icon,
    );
  }

  /// 从实体创建模型
  static PredefinedLabelModel fromEntity(PredefinedLabel entity) {
    return PredefinedLabelModel(
      id: entity.id,
      text: entity.text,
      avatar: entity.avatar,
      icon: entity.icon,
    );
  }
}