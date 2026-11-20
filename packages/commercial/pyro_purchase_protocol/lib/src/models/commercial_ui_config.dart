import 'package:material_ui/material_ui.dart';

/// 商业特权亮点模型
class FeaturePoint {
  final String title;
  final String? subtitle;
  final IconData icon;
  final bool isHighlighted;

  const FeaturePoint({
    required this.title,
    this.subtitle,
    this.icon = Icons.check_circle,
    this.isHighlighted = false,
  });
}

/// 单个商业商品展示卡片的 UI 配置模型 (配置驱动 UI)
class CommercialItemUIConfig {
  final String productId;
  final String title;
  final String? subtitle;
  final String? badge;
  final IconData icon;
  final Color primaryColor;
  final List<Color> gradientColors;
  final List<FeaturePoint> featurePoints;
  final bool isDefaultSelected;

  const CommercialItemUIConfig({
    required this.productId,
    required this.title,
    this.subtitle,
    this.badge,
    this.icon = Icons.workspace_premium,
    this.primaryColor = Colors.amber,
    this.gradientColors = const [Color(0xFFFFD54F), Color(0xFFFFB300)],
    this.featurePoints = const [],
    this.isDefaultSelected = false,
  });
}

/// 全局商业特权面板 UI 配置
class CommercialUIConfig {
  final String sheetTitle;
  final String? sheetSubtitle;
  final List<CommercialItemUIConfig> itemConfigs;
  final List<FeaturePoint> commonFeatures;
  final String buyButtonText;
  final String watchAdButtonText;
  final String restoreButtonText;

  const CommercialUIConfig({
    this.sheetTitle = '解锁 VIP 尊享特权',
    this.sheetSubtitle = '无限端侧大模型翻译 · 全纯净无广告 · 云端高臻同步',
    this.itemConfigs = const [],
    this.commonFeatures = const [],
    this.buyButtonText = '立即开通',
    this.watchAdButtonText = '看广告兑换 1 天 VIP',
    this.restoreButtonText = '恢复购买',
  });
}
