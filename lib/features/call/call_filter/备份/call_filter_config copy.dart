// 移除该行 ↓

/// 通话过滤配置类，用于控制过滤规则的应用逻辑
class CallFilterConfig {
  bool rejectAllNumbers;
  bool allowAllAllowedNumbers;
  bool allowRegexAllowRules;
  bool allowBlockedNumbers;
  bool allowAllWhitelistedNumbers;
  bool allowRegexBlockRules;
  bool allowAllBlacklistedNumbers;

  CallFilterConfig({
    this.rejectAllNumbers = false,
    this.allowAllAllowedNumbers = true,
    this.allowRegexAllowRules = true,
    this.allowBlockedNumbers = false,
    this.allowAllWhitelistedNumbers = true,
    this.allowRegexBlockRules = true,
    this.allowAllBlacklistedNumbers = false,
  });

  /// 从Map创建配置对象
  factory CallFilterConfig.fromMap(Map<String, dynamic> map) {
    return CallFilterConfig(
      rejectAllNumbers: map['rejectAllNumbers'] ?? false,
      allowAllAllowedNumbers: map['allowAllAllowedNumbers'] ?? true,
      allowRegexAllowRules: map['allowRegexAllowRules'] ?? true,
      allowBlockedNumbers: map['allowBlockedNumbers'] ?? false,
      allowAllWhitelistedNumbers: map['allowAllWhitelistedNumbers'] ?? true,
      allowRegexBlockRules: map['allowRegexBlockRules'] ?? true,
      allowAllBlacklistedNumbers: map['allowAllBlacklistedNumbers'] ?? false,
    );
  }

  /// 转换为Map
  Map<String, dynamic> toMap() {
    return {
      'rejectAllNumbers': rejectAllNumbers,
      'allowAllAllowedNumbers': allowAllAllowedNumbers,
      'allowRegexAllowRules': allowRegexAllowRules,
      'allowBlockedNumbers': allowBlockedNumbers,
      'allowAllWhitelistedNumbers': allowAllWhitelistedNumbers,
      'allowRegexBlockRules': allowRegexBlockRules,
      'allowAllBlacklistedNumbers': allowAllBlacklistedNumbers,
    };
  }

  /// 创建配置副本
  CallFilterConfig copyWith({
    bool? rejectAllNumbers,
    bool? allowAllAllowedNumbers,
    bool? allowRegexAllowRules,
    bool? allowBlockedNumbers,
    bool? allowAllWhitelistedNumbers,
    bool? allowRegexBlockRules,
    bool? allowAllBlacklistedNumbers,
  }) {
    return CallFilterConfig(
      rejectAllNumbers: rejectAllNumbers ?? this.rejectAllNumbers,
      allowAllAllowedNumbers:
          allowAllAllowedNumbers ?? this.allowAllAllowedNumbers,
      allowRegexAllowRules: allowRegexAllowRules ?? this.allowRegexAllowRules,
      allowBlockedNumbers: allowBlockedNumbers ?? this.allowBlockedNumbers,
      allowAllWhitelistedNumbers:
          allowAllWhitelistedNumbers ?? this.allowAllWhitelistedNumbers,
      allowRegexBlockRules: allowRegexBlockRules ?? this.allowRegexBlockRules,
      allowAllBlacklistedNumbers:
          allowAllBlacklistedNumbers ?? this.allowAllBlacklistedNumbers,
    );
  }
}
