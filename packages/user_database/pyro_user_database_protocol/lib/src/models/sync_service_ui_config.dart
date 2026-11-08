import 'package:flutter/widgets.dart';

/// 云端同步服务自动挂载 UI 配置描述符
class SyncServiceUIConfig {
  final String providerId;
  final String displayName;
  final IconData icon;
  final Color themeColor;
  final WidgetBuilder? settingsBuilder;

  const SyncServiceUIConfig({
    required this.providerId,
    required this.displayName,
    required this.icon,
    this.themeColor = const Color(0xFF2196F3),
    this.settingsBuilder,
  });
}
