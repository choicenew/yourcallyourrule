import 'package:uuid/uuid.dart';

/// 预定义标签类
class PredefinedLabel {
  final String id;
  final String text;
  final String? avatar;
  final String? icon;

  const PredefinedLabel({
    required this.id,
    required this.text,
    this.avatar,
    this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'avatar': avatar,
      'icon': icon,
    };
  }

  factory PredefinedLabel.fromMap(Map<String, dynamic> map) {
    return PredefinedLabel(
      id: map['id'] as String,
      text: map['text'] as String,
      avatar: map['avatar'] as String?,
      icon: map['icon'] as String?,
    );
  }
  
  factory PredefinedLabel.create(String text, {String? avatar, String? icon}) {
    final id = text.toLowerCase().replaceAll(' ', '_').replaceAll(RegExp(r'[^a-z0-9_]'), '');
    return PredefinedLabel(
      id: id.isEmpty ? const Uuid().v4() : id,
      text: text,
      avatar: avatar,
      icon: icon,
    );
  }
  
  factory PredefinedLabel.fromEnglishName(
    String englishName, {
    String? displayText,
    String? avatar,
    String? icon,
  }) {
    final normalizedId = englishName.toLowerCase().replaceAll(' ', '_').replaceAll(RegExp(r'[^a-z0-9_]'), '');
    return PredefinedLabel(
      id: normalizedId,
      text: displayText ?? englishName,
      avatar: avatar,
      icon: icon,
    );
  }
  
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
