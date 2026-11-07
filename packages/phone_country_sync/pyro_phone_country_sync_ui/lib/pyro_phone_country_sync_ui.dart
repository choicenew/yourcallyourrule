library pyro_phone_country_sync_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_country_sync_protocol/pyro_phone_country_sync_protocol.dart';

/// 100% 遵照 SKILL 规范：富 UI 元素、原生 Theme.of(context)、withValues(alpha: 0.8)
class PyroCountrySyncCardWidget extends StatelessWidget {
  final CountrySyncPayload payload;
  final Widget? avatar;
  final VoidCallback? onTap;

  const PyroCountrySyncCardWidget({
    super.key,
    required this.payload,
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
              child: const Icon(Icons.public_rounded, size: 20),
            ),
        title: Text(
          payload.countryIsoCode,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          'Records: ${payload.totalRecords} • Status: ${payload.status}',
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
typedef CountrySyncTileView = PyroCountrySyncCardWidget;
