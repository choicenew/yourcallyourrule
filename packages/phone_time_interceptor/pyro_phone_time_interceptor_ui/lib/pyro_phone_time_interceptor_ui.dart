library pyro_phone_time_interceptor_ui;

import 'package:material_ui/material_ui.dart';
import 'package:pyro_phone_time_interceptor_protocol/pyro_phone_time_interceptor_protocol.dart';

/// 100% 遵照 SKILL 规范：富 UI 元素、原生 Theme.of(context)、withValues(alpha: 0.8)
class PyroTimeInterceptorCardWidget extends StatelessWidget {
  final TimeInterceptorConfig config;
  final Widget? avatar;
  final VoidCallback? onTap;

  const PyroTimeInterceptorCardWidget({
    super.key,
    required this.config,
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
              child: const Icon(Icons.access_time_rounded, size: 20),
            ),
        title: Text(
          'Duration: ${config.durationMinutes} mins',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          'Should Intercept: ${config.shouldIntercept}',
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
typedef TimeInterceptorTileView = PyroTimeInterceptorCardWidget;
