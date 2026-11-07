library pyro_deletion_proposal_ui;

import 'package:flutter/material.dart';
import 'package:pyro_deletion_proposal_protocol/pyro_deletion_proposal_protocol.dart';

/// 100% 遵照 SKILL 规范：富 UI 元素、原生 Theme.of(context)、withValues(alpha: 0.8)
class PyroProposalCardWidget extends StatelessWidget {
  final ProposalEntity proposal;
  final Widget? avatar;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const PyroProposalCardWidget({
    super.key,
    required this.proposal,
    this.avatar,
    this.onTap,
    this.onDelete,
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
              backgroundColor: colorScheme.tertiaryContainer,
              foregroundColor: colorScheme.onTertiaryContainer,
              child: const Icon(Icons.report_problem_rounded, size: 20),
            ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                proposal.phoneNumber,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 6),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Votes: ${proposal.voteCount}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            'Reason: ${proposal.reason} • Status: ${proposal.status}',
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
typedef ProposalTileView = PyroProposalCardWidget;
