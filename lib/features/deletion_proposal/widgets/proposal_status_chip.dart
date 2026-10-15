import 'package:flutter/material.dart';
import 'package:yourcallyourrule/theme/dopamine_theme_extension.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal_status.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 删除提议状态 Chip 组件（100% 强类型 ProposalStatus 枚举与 Theme 色彩）
class ProposalStatusChip extends StatelessWidget {
  final ProposalStatus status;

  const ProposalStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color chipColor;
    IconData icon;
    String displayText;

    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    switch (status) {
      case ProposalStatus.approved:
        chipColor = colorScheme.tertiary;
        icon = Icons.check_circle;
        displayText = l10n.approved;
        break;
      case ProposalStatus.rejected:
        chipColor = colorScheme.error;
        icon = Icons.cancel;
        displayText = l10n.rejected;
        break;
      case ProposalStatus.expired:
        chipColor = colorScheme.onSurfaceVariant;
        icon = Icons.timer_off_rounded;
        displayText = status.name.toUpperCase();
        break;
      case ProposalStatus.pending:
      default:
        chipColor = colorScheme.primary;
        icon = Icons.pending;
        displayText = l10n.pending;
        break;
    }

    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: chipColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: chipColor),
            const SizedBox(width: 4),
            Text(
              displayText,
              style: TextStyle(
                color: chipColor,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
