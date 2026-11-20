import 'package:material_ui/material_ui.dart';

/// 广告渠道 UI 元数据描述配置
class AdServiceUIConfig {
  final String providerId;
  final String displayName;
  final IconData icon;
  final Color themeColor;
  final List<String> supportedSlots;

  const AdServiceUIConfig({
    required this.providerId,
    required this.displayName,
    required this.icon,
    this.themeColor = Colors.blue,
    this.supportedSlots = const [],
  });
}
