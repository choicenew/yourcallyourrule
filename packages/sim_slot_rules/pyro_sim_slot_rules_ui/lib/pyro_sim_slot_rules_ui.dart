library pyro_sim_slot_rules_ui;

import 'package:flutter/material.dart';
import 'package:pyro_sim_slot_rules_protocol/pyro_sim_slot_rules_protocol.dart';

/// 100% 遵照 SKILL 规范：富 UI 元素、原生 Theme.of(context)、withValues(alpha: 0.8)
class PyroSimSlotRuleCardWidget extends StatelessWidget {
  final SimSlotRuleEntity rule;
  final Widget? avatar;
  final VoidCallback? onTap;

  const PyroSimSlotRuleCardWidget({
    super.key,
    required this.rule,
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
              backgroundColor: colorScheme.secondaryContainer,
              foregroundColor: colorScheme.onSecondaryContainer,
              child: const Icon(Icons.sim_card_rounded, size: 20),
            ),
        title: Text(
          rule.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          'SIM Slot ${rule.simSlotIndex} • ${rule.phoneNumber}',
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
typedef SimSlotRuleTileView = PyroSimSlotRuleCardWidget;
