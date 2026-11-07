// ignore_for_file: constant_identifier_names

/// 用户风控与敏感度等级枚举
enum UserSensitivityLevel {
  level0_pure(0, 'pure'),
  level1_light(1, 'light'),
  level2_low(2, 'low'),
  level3_medium(3, 'medium'),
  level4_high(4, 'high'),
  level5_extreme(5, 'extreme');

  final int level;
  final String label;

  const UserSensitivityLevel(this.level, this.label);

  static UserSensitivityLevel fromLevel(int level) {
    if (level <= 0) return UserSensitivityLevel.level0_pure;
    if (level == 1) return UserSensitivityLevel.level1_light;
    if (level == 2) return UserSensitivityLevel.level2_low;
    if (level == 3) return UserSensitivityLevel.level3_medium;
    if (level == 4) return UserSensitivityLevel.level4_high;
    return UserSensitivityLevel.level5_extreme;
  }
}

/// 综合风控决策配置
enum RiskProfile {
  safe,
  risky,
  ban,
}

/// 商业化流量分层
enum AdTrafficTier {
  tier1, // 全量高价值广告 (Safe & Light)
  tier2, // 普通广告
  tier3, // 谨慎投放 / 限制频次
  tier4, // 严格限制 / 低敏感广告
  tier5, // 禁投 / 纯净模式
}

/// 数据源/插件信誉风险
enum SourceRiskLevel {
  safe,
  neutral,
  unsafe,
}
