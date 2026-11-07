import 'package:flutter/widgets.dart';

enum CloudConfigFieldType { text, password, url, number, boolean }

class CloudConfigField {
  final String key;
  final String label;
  final String? hint;
  final CloudConfigFieldType type;
  final bool required;
  final String? defaultValue;

  const CloudConfigField({
    required this.key,
    required this.label,
    this.hint,
    this.type = CloudConfigFieldType.text,
    this.required = true,
    this.defaultValue,
  });
}

class CloudServiceUIConfig {
  /// 🌟 强类型 Class Token，擦除 providerId 魔鬼字符串
  final Type driverToken;

  /// 默认非多态回退标题
  final String? defaultDisplayName;

  /// 动态多态标题获取器
  final String Function(BuildContext context)? titleBuilder;

  final IconData icon;
  final Color themeColor;
  final bool usesOAuth;
  final List<CloudConfigField> fields;

  const CloudServiceUIConfig({
    required this.driverToken,
    this.defaultDisplayName,
    this.titleBuilder,
    required this.icon,
    this.themeColor = const Color(0xFF2196F3),
    this.usesOAuth = false,
    this.fields = const [],
  });

  String getTitle(BuildContext context) {
    if (titleBuilder != null) {
      return titleBuilder!(context);
    }
    return defaultDisplayName ?? driverToken.toString();
  }
}
