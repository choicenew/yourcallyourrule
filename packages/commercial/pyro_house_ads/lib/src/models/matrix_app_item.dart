import 'package:material_ui/material_ui.dart';

/// 矩阵 App 或产品实体配置模型
class MatrixAppItem {
  /// 应用包名 (如 'com.pyro.wallpaper', 'com.pyro.novel')
  final String packageName;

  /// 对应官方 ARB 的标题多语言 Key
  final String titleKey;

  /// 对应官方 ARB 的副标题/描述多语言 Key
  final String descKey;

  /// 对应官方 ARB 的 CTA 按钮多语言 Key (默认 'open' 或 'get')
  final String? ctaKey;

  /// 回退/默认展示标题 (当 ARB 未匹配时使用)
  final String? defaultTitle;

  /// 回退/默认展示副标题 (当 ARB 未匹配时使用)
  final String? defaultDesc;

  /// 矢量图标 (如 Icons.wallpaper_rounded)
  final IconData? icon;

  /// 本地资源图片路径 (可选)
  final String? iconAsset;

  /// 视觉渐变背景色彩配置
  final List<Color> gradientColors;

  /// 当此条目为当前主 App 时，点击跳转的内部 VIP / 内购页面路由
  final String? vipRoute;

  /// 导流/促销轮播权重 (权重越高，被抽中展示的概率越大)
  final int weight;

  /// 促销角标文案 Key (如 'PRO', 'HOT', 'NEW')
  final String? badgeText;

  /// 额外参数
  final Map<String, dynamic> extras;

  const MatrixAppItem({
    required this.packageName,
    required this.titleKey,
    required this.descKey,
    this.ctaKey,
    this.defaultTitle,
    this.defaultDesc,
    this.icon,
    this.iconAsset,
    this.gradientColors = const [Color(0xFF212121), Color(0xFF424242)],
    this.vipRoute,
    this.weight = 50,
    this.badgeText,
    this.extras = const {},
  });
}
