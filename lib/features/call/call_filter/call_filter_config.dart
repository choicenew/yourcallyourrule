/// 通话过滤配置类，用于控制过滤规则的应用逻辑
class CallFilterConfig {
  bool rejectAllNumbers;
  bool allowAllAllowedNumbers;
  bool allowRegexAllowRules;
  bool allowBlockedNumbers;
  bool allowAllAllowRules; // 替换allowAllWhitelistedNumbers
  bool allowRegexBlockRules;
  bool allowAllBlockRules; // 替换allowAllBlacklistedNumbers
  bool allowSilenceRules;
  bool allowNoneRules;

  CallFilterConfig({
    this.rejectAllNumbers = false,
    this.allowAllAllowedNumbers = true,
    this.allowRegexAllowRules = true,
    this.allowBlockedNumbers = false,
    this.allowAllAllowRules = true, // 替换allowAllWhitelistedNumbers
    this.allowRegexBlockRules = true,
    this.allowAllBlockRules = false, // 替换allowAllBlacklistedNumbers
    this.allowSilenceRules = true,
    this.allowNoneRules = true,
  });

  /// 从Map创建配置对象
  factory CallFilterConfig.fromMap(Map<String, dynamic> map) {
    return CallFilterConfig(
      rejectAllNumbers: map['rejectAllNumbers'] ?? false,
      allowAllAllowedNumbers: map['allowAllAllowedNumbers'] ?? true,
      allowRegexAllowRules: map['allowRegexAllowRules'] ?? true,
      allowBlockedNumbers: map['allowBlockedNumbers'] ?? false,
      allowAllAllowRules: map['allowAllAllowRules'] ?? true,
      allowRegexBlockRules: map['allowRegexBlockRules'] ?? true,
      allowAllBlockRules: map['allowAllBlockRules'] ?? false,
      allowSilenceRules: map['allowSilenceRules'] ?? true,
      allowNoneRules: map['allowNoneRules'] ?? true,
    );
  }

  /// 转换为Map
  Map<String, dynamic> toMap() {
    return {
      'rejectAllNumbers': rejectAllNumbers,
      'allowAllAllowedNumbers': allowAllAllowedNumbers,
      'allowRegexAllowRules': allowRegexAllowRules,
      'allowBlockedNumbers': allowBlockedNumbers,
      'allowAllAllowRules': allowAllAllowRules,
      'allowRegexBlockRules': allowRegexBlockRules,
      'allowAllBlockRules': allowAllBlockRules,
      'allowSilenceRules': allowSilenceRules,
      'allowNoneRules': allowNoneRules,
    };
  }

  /// 创建配置副本
  CallFilterConfig copyWith({
    bool? rejectAllNumbers,
    bool? allowAllAllowedNumbers,
    bool? allowRegexAllowRules,
    bool? allowBlockedNumbers,
    bool? allowAllAllowRules,
    bool? allowRegexBlockRules,
    bool? allowAllBlockRules,
    bool? allowSilenceRules,
    bool? allowNoneRules,
  }) {
    return CallFilterConfig(
      rejectAllNumbers: rejectAllNumbers ?? this.rejectAllNumbers,
      allowAllAllowedNumbers:
          allowAllAllowedNumbers ?? this.allowAllAllowedNumbers,
      allowRegexAllowRules: allowRegexAllowRules ?? this.allowRegexAllowRules,
      allowBlockedNumbers: allowBlockedNumbers ?? this.allowBlockedNumbers,
      allowAllAllowRules: allowAllAllowRules ?? this.allowAllAllowRules,
      allowRegexBlockRules: allowRegexBlockRules ?? this.allowRegexBlockRules,
      allowAllBlockRules: allowAllBlockRules ?? this.allowAllBlockRules,
      allowSilenceRules: allowSilenceRules ?? this.allowSilenceRules,
      allowNoneRules: allowNoneRules ?? this.allowNoneRules,
    );
  }
}
