// 预定义标签实体，用于统一管理标签定义

import 'package:uuid/uuid.dart';

/// 预定义标签类
/// 负责定义标签的基本结构，包含有意义的ID和标签文本等信息
class PredefinedLabel {
  /// 唯一标识符（使用有意义的ID，如英文名称的小写形式）
  final String id;
  
  /// 标签文本内容（显示给用户的文本）
  final String text;
  
  /// 可选的头像
  final String? avatar;
  
  /// 可选的图标
  final String? icon;

  /// 构造函数
  const PredefinedLabel({
    required this.id,
    required this.text,
    this.avatar,
    this.icon,
  });

  /// 序列化方法
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'avatar': avatar,
      'icon': icon,
    };
  }

  /// 反序列化方法
  factory PredefinedLabel.fromMap(Map<String, dynamic> map) {
    return PredefinedLabel(
      id: map['id'],
      text: map['text'],
      avatar: map['avatar'],
      icon: map['icon'],
    );
  }
  
  /// 创建新标签的工厂方法（使用有意义的ID）
  factory PredefinedLabel.create(String text, {String? avatar, String? icon}) {
    // 生成有意义的ID：将文本转换为小写并替换空格为下划线
    final id = text.toLowerCase().replaceAll(' ', '_').replaceAll(RegExp(r'[^a-z0-9_]'), '');
    return PredefinedLabel(
      id: id.isEmpty ? const Uuid().v4() : id, // 如果生成的ID为空，则使用UUID作为后备
      text: text,
      avatar: avatar,
      icon: icon,
    );
  }
  
  /// 从英文名创建标签的工厂方法
  factory PredefinedLabel.fromEnglishName(
    String englishName, {
    String? displayText,
    String? avatar,
    String? icon,
  }) {
    // 将英文名转换为小写并去除空格，确保ID的规范性
    final normalizedId = englishName.toLowerCase().replaceAll(' ', '_').replaceAll(RegExp(r'[^a-z0-9_]'), '');
    
    return PredefinedLabel(
      id: normalizedId,
      // 如果没有提供显示文本，就使用英文名
      text: displayText ?? englishName,
      avatar: avatar,
      icon: icon,
    );
  }
  
  /// 复制方法
  PredefinedLabel copyWith({
    String? text,
    String? avatar,
    String? icon,
  }) {
    return PredefinedLabel(
      id: id,
      text: text ?? this.text,
      avatar: avatar ?? this.avatar,
      icon: icon ?? this.icon,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PredefinedLabel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}