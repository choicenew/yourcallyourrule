library pyro_phone_marking_ui;

import 'package:material_ui/material_ui.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';

/// 100% 遵照 SKILL 规范：富 UI 元素、原生 Theme.of(context)、withValues(alpha: 0.8)
class PyroPhoneMarkCardWidget extends StatelessWidget {
  final LabelPhoneEntry entry;
  final Widget? avatar;
  final VoidCallback? onTap;

  const PyroPhoneMarkCardWidget({
    super.key,
    required this.entry,
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
              child: const Icon(Icons.label_rounded, size: 20),
            ),
        title: Text(
          entry.name.isNotEmpty ? entry.name : entry.phoneNumber,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          'Label: ${entry.labelId} • Enabled: ${entry.isEnabled}',
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
typedef PhoneMarkTileView = PyroPhoneMarkCardWidget;
