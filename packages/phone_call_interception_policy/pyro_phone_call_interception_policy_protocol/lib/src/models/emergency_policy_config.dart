/// 紧急呼叫后全局拦截豁免策略配置 (EmergencyPolicyConfig)
class EmergencyPolicyConfig {
  final bool enabled;
  final int durationMinutes;
  final List<String> customNumbers;

  const EmergencyPolicyConfig({
    this.enabled = true,
    this.durationMinutes = 30,
    this.customNumbers = const [],
  });

  EmergencyPolicyConfig copyWith({
    bool? enabled,
    int? durationMinutes,
    List<String>? customNumbers,
  }) {
    return EmergencyPolicyConfig(
      enabled: enabled ?? this.enabled,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      customNumbers: customNumbers ?? this.customNumbers,
    );
  }

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'durationMinutes': durationMinutes,
    'customNumbers': customNumbers,
  };

  factory EmergencyPolicyConfig.fromJson(Map<String, dynamic> json) {
    return EmergencyPolicyConfig(
      enabled: json['enabled'] as bool? ?? true,
      durationMinutes: json['durationMinutes'] as int? ?? 30,
      customNumbers: (json['customNumbers'] as List<dynamic>?)
              ?.map((e) => e.toString().trim())
              .where((e) => e.isNotEmpty)
              .toList() ??
          const [],
    );
  }
}

