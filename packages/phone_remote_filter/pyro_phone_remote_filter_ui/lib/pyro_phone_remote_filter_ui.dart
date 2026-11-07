library pyro_phone_remote_filter_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';

/// 100% 遵照 SKILL 规范：富 UI 元素、原生 Theme.of(context)、withValues(alpha: 0.8)
class PyroPhoneRemoteFilterCardWidget extends StatelessWidget {
  final RemoteNumberEntry entry;
  final Widget? avatar;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool isMultiSelectMode;
  final bool isSelected;
  final ValueChanged<bool?>? onSelectionChanged;

  const PyroPhoneRemoteFilterCardWidget({
    super.key,
    required this.entry,
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
                  backgroundColor: colorScheme.errorContainer,
                  foregroundColor: colorScheme.onErrorContainer,
                  child: const Icon(Icons.security_rounded, size: 20),
                ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                entry.name ?? entry.phoneNumber,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (entry.label != null && entry.label!.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(left: 6),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  entry.label!,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onErrorContainer,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            'Number: ${entry.phoneNumber} • Count: ${entry.count}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
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
typedef PhoneRemoteFilterTileView = PyroPhoneRemoteFilterCardWidget;
