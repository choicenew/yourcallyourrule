library pyro_phone_call_statistic_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_call_statistic_protocol/pyro_phone_call_statistic_protocol.dart';

/// 100% 遵照 SKILL 规范：富 UI 元素、原生 Theme.of(context)、withValues(alpha: 0.8)
class PyroPhoneCallStatisticCardWidget extends StatelessWidget {
  final PhoneCallStatisticData data;
  final Widget? avatar;
  final VoidCallback? onTap;

  const PyroPhoneCallStatisticCardWidget({
    super.key,
    required this.data,
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
              backgroundColor: colorScheme.errorContainer,
              foregroundColor: colorScheme.onErrorContainer,
              child: const Icon(Icons.pie_chart_rounded, size: 20),
            ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Blocked: ${data.blockedCalls} / Total: ${data.totalCalls}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            'Allowed: ${data.allowedCalls} • Silenced: ${data.silencedCalls}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

/// 兼容别名导出
typedef PhoneCallStatisticCardView = PyroPhoneCallStatisticCardWidget;
