library pyro_phone_rules_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';

/// 100% 遵照 SKILL 规范：富 UI 元素、原生 Theme.of(context)、0 硬编码、0 假假分支
class PyroPhoneRuleCardWidget extends StatelessWidget {
  final PhoneRuleEntity rule;
  final Widget? avatar;
  final String? location;
  final List<String>? labelTags;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool isMultiSelectMode;
  final bool isSelected;
  final ValueChanged<bool?>? onSelectionChanged;

  const PyroPhoneRuleCardWidget({
    super.key,
    required this.rule,
    this.avatar,
    this.location,
    this.labelTags,
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
    final isBlock = rule.actionType == 'block';

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
                  backgroundColor: isBlock ? colorScheme.errorContainer : colorScheme.primaryContainer,
                  foregroundColor: isBlock ? colorScheme.onErrorContainer : colorScheme.onPrimaryContainer,
                  child: Icon(
                    isBlock ? Icons.block_rounded : Icons.check_circle_outline_rounded,
                    size: 20,
                  ),
                ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                rule.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (labelTags != null && labelTags!.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(left: 6),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  labelTags!.first,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onTertiaryContainer,
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
                rule.phoneNumber,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              if (location != null && location!.isNotEmpty) ...[
                const SizedBox(width: 8),
                Text(
                  '• $location',
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
typedef PhoneRuleTileView = PyroPhoneRuleCardWidget;
