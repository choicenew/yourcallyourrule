library pyro_phone_call_overlay_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_call_overlay_protocol/pyro_phone_call_overlay_protocol.dart';

/// 悬浮窗配置 ListTile 组件
class PhoneOverlayTileView extends StatelessWidget {
  final PhoneCallOverlayConfig config;

  const PhoneOverlayTileView({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.picture_in_picture_alt),
      title: const Text('Call Overlay Config'),
      subtitle: Text('Enabled: ${config.enableOverlay} • Color: ${config.backgroundColor}'),
    );
  }
}
