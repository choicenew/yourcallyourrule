import '../models/risk_types.dart';
import '../calculators/user_risk_calculator.dart';

/// 基于历史标签分析的用户画像风控评估器
class UserProfilingEvaluator {
  final Set<String> sensitiveKeywords;

  UserProfilingEvaluator({required this.sensitiveKeywords});

  /// 从近期浏览的历史标签列表中评估用户敏感度等级
  UserSensitivityLevel evaluateHistory(
    List<String> recentTags, {
    String? shadowId,
  }) {
    if (recentTags.isEmpty) {
      return UserSensitivityLevel.level0_pure;
    }

    int dirtyCount = 0;
    final totalCount = recentTags.length;

    // 统计敏感标签命中数
    for (final tag in recentTags) {
      if (UserRiskCalculator.checkSensitiveTags([tag], sensitiveKeywords)) {
        dirtyCount++;
      }
    }

    final double dirtyRatio = dirtyCount / totalCount;

    // 判定等级
    if (dirtyRatio > 0.50 || dirtyCount > 100) {
      return UserSensitivityLevel.level5_extreme;
    }
    if (dirtyRatio > 0.30 || dirtyCount > 50) {
      return UserSensitivityLevel.level4_high;
    }
    if (dirtyRatio > 0.15 || dirtyCount > 20) {
      return UserSensitivityLevel.level3_medium;
    }
    if (dirtyRatio > 0.05 || dirtyCount > 5) {
      return UserSensitivityLevel.level2_low;
    }
    if (dirtyCount > 0) {
      return UserSensitivityLevel.level1_light;
    }

    return UserSensitivityLevel.level0_pure;
  }
}
