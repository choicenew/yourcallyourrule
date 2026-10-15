import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 删除提议风险等级强类型枚举（全链路 4 级精确对齐，100% 遵从原生 Theme.of(context).colorScheme）
enum RiskLevel {
  /// 已验证所有者（SIM 卡与设备一致，最低风险）
  verified,

  /// 低风险
  low,

  /// 中风险
  medium,

  /// 高风险
  high;

  /// 从数据库/后端传输的原始字符串或数字安全创建枚举
  factory RiskLevel.fromString(dynamic raw) {
    if (raw == null) return RiskLevel.high;
    final str = raw.toString().trim().toLowerCase();
    switch (str) {
      case 'verified':
      case '1':
        return RiskLevel.verified;
      case 'low':
      case '2':
        return RiskLevel.low;
      case 'medium':
      case '3':
        return RiskLevel.medium;
      case 'high':
      case '4':
      case 'critical':
      default:
        return RiskLevel.high;
    }
  }

  /// 转换为数据库/后端传输的标准字符串 ('Verified', 'Low', 'Medium', 'High')
  String toRawString() {
    switch (this) {
      case RiskLevel.verified:
        return 'Verified';
      case RiskLevel.low:
        return 'Low';
      case RiskLevel.medium:
        return 'Medium';
      case RiskLevel.high:
        return 'High';
    }
  }

  /// 获取对应主题调色盘颜色（原生 ColorScheme 对齐）
  Color getColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (this) {
      case RiskLevel.verified:
        return colorScheme.tertiary;
      case RiskLevel.low:
        return colorScheme.secondary;
      case RiskLevel.medium:
        return colorScheme.primary;
      case RiskLevel.high:
        return colorScheme.error;
    }
  }

  /// 获取对应的多语言文本
  String getLocalizedLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case RiskLevel.verified:
        return l10n.riskLevelVeryLow;
      case RiskLevel.low:
        return l10n.riskLevelLow;
      case RiskLevel.medium:
        return l10n.riskLevelMedium;
      case RiskLevel.high:
        return l10n.riskLevelHigh;
    }
  }
}
