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
  final String providerId;
  final String displayName;
  final IconData icon;
  final Color themeColor;
  final bool usesOAuth;
  final List<CloudConfigField> fields;

  const CloudServiceUIConfig({
    required this.providerId,
    required this.displayName,
    required this.icon,
    this.themeColor = const Color(0xFF2196F3),
    this.usesOAuth = false,
    this.fields = const [],
  });
}
