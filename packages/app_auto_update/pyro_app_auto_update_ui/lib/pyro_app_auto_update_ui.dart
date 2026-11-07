library pyro_app_auto_update_ui;

import 'package:flutter/material.dart';
import 'package:pyro_app_auto_update_protocol/pyro_app_auto_update_protocol.dart';

/// 版本更新信息 ListTile 组件
class AppVersionInfoTileView extends StatelessWidget {
  final AppVersionInfo info;

  const AppVersionInfoTileView({
    super.key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.system_update),
      title: Text('Latest Version: ${info.latestVersion}'),
      subtitle: Text('Force Update: ${info.isForceUpdate} • ${info.releaseNotes ?? ""}'),
    );
  }
}
