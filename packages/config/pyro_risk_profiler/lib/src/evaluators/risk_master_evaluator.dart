import '../models/risk_types.dart';

/// 统一风控决策中枢评估器
class RiskMasterEvaluator {
  const RiskMasterEvaluator();

  /// 综合判定广告/环境安全风控 Profile
  RiskProfile determineRiskProfile({
    required UserSensitivityLevel userLevel,
    SourceRiskLevel sourceLevel = SourceRiskLevel.safe,
  }) {
    // 1. 高敏感用户直接禁止商业广告 / 全局风控
    if (userLevel == UserSensitivityLevel.level5_extreme ||
        userLevel == UserSensitivityLevel.level4_high) {
      return RiskProfile.ban;
    }

    // 2. 不安全的数据源/插件环境 -> Risky
    if (sourceLevel == SourceRiskLevel.unsafe ||
        sourceLevel == SourceRiskLevel.neutral) {
      return RiskProfile.risky;
    }

    // 3. 中等敏感用户在安全源下也是 Risky
    if (userLevel == UserSensitivityLevel.level3_medium) {
      return RiskProfile.risky;
    }

    // 4. 其余为 Safe
    return RiskProfile.safe;
  }

  /// 用户等级映射商业化流量层级
  AdTrafficTier determineAdTier({required UserSensitivityLevel userLevel}) {
    switch (userLevel) {
      case UserSensitivityLevel.level0_pure:
      case UserSensitivityLevel.level1_light:
        return AdTrafficTier.tier1;
      case UserSensitivityLevel.level2_low:
        return AdTrafficTier.tier2;
      case UserSensitivityLevel.level3_medium:
        return AdTrafficTier.tier3;
      case UserSensitivityLevel.level4_high:
        return AdTrafficTier.tier4;
      case UserSensitivityLevel.level5_extreme:
        return AdTrafficTier.tier5;
    }
  }
}
