class SmsRegexRule {
  final String id;
  final String pattern;
  final String action;
  final bool isEnabled;
  final String? description;

  const SmsRegexRule({
    required this.id,
    required this.pattern,
    required this.action,
    this.isEnabled = true,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pattern': pattern,
      'action': action,
      'isEnabled': isEnabled,
      'description': description,
    };
  }

  factory SmsRegexRule.fromMap(Map<String, dynamic> map) {
    return SmsRegexRule(
      id: map['id'] as String? ?? '',
      pattern: map['pattern'] as String? ?? '',
      action: map['action'] as String? ?? 'block',
      isEnabled: map['isEnabled'] as bool? ?? true,
      description: map['description'] as String?,
    );
  }

  SmsRegexRule copyWith({
    String? id,
    String? pattern,
    String? action,
    bool? isEnabled,
    String? description,
  }) {
    return SmsRegexRule(
      id: id ?? this.id,
      pattern: pattern ?? this.pattern,
      action: action ?? this.action,
      isEnabled: isEnabled ?? this.isEnabled,
      description: description ?? this.description,
    );
  }
}
