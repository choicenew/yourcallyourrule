/// 通话过滤配置类，用于控制过滤规则的应用逻辑
class CallFilterConfig {
  // 定义所有属性的 Key 为静态常量
  static const String keyRejectAllNumbers = 'rejectAllNumbers';
  static const String keyAllowAllAllowedNumbers = 'allowAllAllowedNumbers';
  static const String keyAllowRegexAllowRules = 'allowRegexAllowRules';
  static const String keyAllowBlockedNumbers = 'allowBlockedNumbers';
  static const String keyAllowAllAllowRules = 'allowAllAllowRules';
  static const String keyAllowRegexBlockRules = 'allowRegexBlockRules';
  static const String keyAllowAllBlockRules = 'allowAllBlockRules';
  static const String keyAllowSilenceRules = 'allowSilenceRules';
  static const String keyAllowNoneRules = 'allowNoneRules';

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
      rejectAllNumbers: map[keyRejectAllNumbers] ?? false,
      allowAllAllowedNumbers: map[keyAllowAllAllowedNumbers] ?? true,
      allowRegexAllowRules: map[keyAllowRegexAllowRules] ?? true,
      allowBlockedNumbers: map[keyAllowBlockedNumbers] ?? false,
      allowAllAllowRules: map[keyAllowAllAllowRules] ?? true,
      allowRegexBlockRules: map[keyAllowRegexBlockRules] ?? true,
      allowAllBlockRules: map[keyAllowAllBlockRules] ?? false,
      allowSilenceRules: map[keyAllowSilenceRules] ?? true,
      allowNoneRules: map[keyAllowNoneRules] ?? true,
    );
  }

  /// 转换为Map
  Map<String, dynamic> toMap() {
    return {
      keyRejectAllNumbers: rejectAllNumbers,
      keyAllowAllAllowedNumbers: allowAllAllowedNumbers,
      keyAllowRegexAllowRules: allowRegexAllowRules,
      keyAllowBlockedNumbers: allowBlockedNumbers,
      keyAllowAllAllowRules: allowAllAllowRules,
      keyAllowRegexBlockRules: allowRegexBlockRules,
      keyAllowAllBlockRules: allowAllBlockRules,
      keyAllowSilenceRules: allowSilenceRules,
      keyAllowNoneRules: allowNoneRules,
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
