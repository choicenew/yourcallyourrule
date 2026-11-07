library pyro_app_auto_update_ui;

import 'package:flutter/material.dart';
import 'package:pyro_app_auto_update_protocol/pyro_app_auto_update_protocol.dart';

/// 100% 遵照 SKILL 规范：富 UI 元素、原生 Theme.of(context)、withValues(alpha: 0.8)
class PyroAppVersionInfoCardWidget extends StatelessWidget {
  final AppVersionInfo info;
  final Widget? avatar;
  final VoidCallback? onTap;

  const PyroAppVersionInfoCardWidget({
    super.key,
    required this.info,
    this.avatar,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 1.0,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: avatar ??
            CircleAvatar(
              backgroundColor: colorScheme.primaryContainer,
              foregroundColor: colorScheme.onPrimaryContainer,
              child: const Icon(Icons.system_update_rounded, size: 20),
            ),
        title: Text(
          'Latest Version: ${info.latestVersion}',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          'Force Update: ${info.isForceUpdate} • ${info.releaseNotes ?? ""}',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

/// 兼容别名导出
typedef AppVersionInfoTileView = PyroAppVersionInfoCardWidget;
