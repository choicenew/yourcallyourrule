import '../models/risk_types.dart';
import '../models/user_risk_interaction.dart';

/// 用户敏感度/风控计分器
class UserRiskCalculator {
  /// 敏感度阈值配置
  final double level1Threshold;
  final double level2Threshold;
  final double level3Threshold;
  final double level4Threshold;
  final double level5Threshold;

  const UserRiskCalculator({
    this.level1Threshold = 10.0,
    this.level2Threshold = 50.0,
    this.level3Threshold = 200.0,
    this.level4Threshold = 500.0,
    this.level5Threshold = 1000.0,
  });

  /// 默认单例/静态常量
  static const UserRiskCalculator defaultCalculator = UserRiskCalculator();

  /// 计算单次行为交互增量得分
  double calculateInteractionScore(
    UserRiskInteraction interaction, {
    Set<String> sensitiveKeywords = const {},
  }) {
    // 1. 内容敏感词匹配检测
    final hasSensitiveTags =
        checkSensitiveTags(interaction.tags, sensitiveKeywords);
    if (!hasSensitiveTags) return 0.0;

    double flowScore = 0.0;

    // 基础命中分
    flowScore += 1.0;

    // 时长深度加权
    if (interaction.viewDurationMillis > 5000) {
      flowScore += 2.0;
    }
    if (interaction.viewDurationMillis > 10000) {
      flowScore += 3.0;
    }

    // 意图加权 (如放大、细看等强意图)
    if (interaction.intent == RiskInteractionIntent.inspect) {
      flowScore += 5.0;
    }

    // 转化/强行为加权 (如保存、下载、关注作者)
    if (interaction.isDownloaded ||
        interaction.isFollowedAuthor ||
        interaction.intent == RiskInteractionIntent.save ||
        interaction.intent == RiskInteractionIntent.setWallpaper) {
      flowScore += 10.0;
    }

    return flowScore;
  }

  /// 根据总分判定对应等级 (0 ~ 5)
  int determineLevel(int currentLevel, double totalScore) {
    if (totalScore >= level5Threshold) return 5;
    if (totalScore >= level4Threshold) return 4;
    if (totalScore >= level3Threshold) return 3;
    if (totalScore >= level2Threshold) return 2;
    if (totalScore >= level1Threshold) return 1;
    return currentLevel > 0 ? currentLevel : 0;
  }

  /// 转换为枚举等级
  UserSensitivityLevel determineSensitivityLevel(
      int currentLevel, double totalScore) {
    final level = determineLevel(currentLevel, totalScore);
    return UserSensitivityLevel.fromLevel(level);
  }

  /// 检查标签中是否包含敏感词
  static bool checkSensitiveTags(
    List<String> tags,
    Set<String> sensitiveKeywords,
  ) {
    if (sensitiveKeywords.isEmpty || tags.isEmpty) return false;
    for (final tag in tags) {
      final lowerTag = tag.toLowerCase();
      for (final keyword in sensitiveKeywords) {
        if (lowerTag.contains(keyword.toLowerCase())) {
          return true;
        }
      }
    }
    return false;
  }
}
