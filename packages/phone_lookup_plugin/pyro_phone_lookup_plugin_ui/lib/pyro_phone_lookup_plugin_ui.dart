library pyro_phone_lookup_plugin_ui;

import 'package:material_ui/material_ui.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';

/// 100% 遵照 SKILL 规范：富 UI 元素、原生 Theme.of(context)、withValues(alpha: 0.8)
class PyroPhoneLookupPluginCardWidget extends StatelessWidget {
  final PluginSourceData data;
  final Widget? avatar;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool isMultiSelectMode;
  final bool isSelected;
  final ValueChanged<bool?>? onSelectionChanged;

  const PyroPhoneLookupPluginCardWidget({
    super.key,
    required this.data,
    this.avatar,
    this.onTap,
    this.onDelete,
    this.isMultiSelectMode = false,
    this.isSelected = false,
    this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final displayName = data.name ?? data.phoneNumber ?? 'Unknown Plugin';
    final locationText = [data.province, data.city, data.carrier]
        .where((e) => e != null && e.isNotEmpty)
        .join(' ');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: isMultiSelectMode
            ? Checkbox(
                value: isSelected,
                onChanged: onSelectionChanged,
                activeColor: colorScheme.primary,
              )
            : avatar ??
                CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  foregroundColor: colorScheme.onPrimaryContainer,
                  child: const Icon(Icons.extension_rounded, size: 20),
                ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                displayName,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (data.sourceLabel != null && data.sourceLabel!.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(left: 6),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  data.sourceLabel!,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Row(
            children: [
              Text(
                data.phoneNumber ?? '',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              if (locationText.isNotEmpty) ...[
                const SizedBox(width: 8),
                Text(
                  '• $locationText',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ],
          ),
        ),
        trailing: onDelete != null
            ? IconButton(
                icon: Icon(Icons.delete_outline_rounded, color: colorScheme.error),
                onPressed: onDelete,
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}

/// 兼容别名导出
typedef PhoneLookupPluginTileView = PyroPhoneLookupPluginCardWidget;
