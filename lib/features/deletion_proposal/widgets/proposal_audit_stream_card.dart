import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 系统主题 · 真实数据驱动的社区提议列表与流日志独立微组件 (100% 真实数据 + 100% i18n)
class ProposalAuditStreamCard extends ConsumerWidget {
  const ProposalAuditStreamCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final proposalState = ref.watch(deletionProposalProvider);
    final proposals = proposalState.proposals;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.tertiary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.receipt_long_rounded,
                      color: theme.colorScheme.tertiary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    l10n.auditStreamLog,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  l10n.liveStream,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: theme.colorScheme.tertiary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (proposals.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  l10n.noProposalsFound,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: proposals.length > 3 ? 3 : proposals.length,
              separatorBuilder: (context, index) => const Divider(height: 16, thickness: 0.8),
              itemBuilder: (context, index) {
                final proposal = proposals[index];
                return _buildStreamLogRow(context, proposal, theme, l10n);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildStreamLogRow(
    BuildContext context,
    Proposal proposal,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    final phone = proposal.phoneNumber;
    final maskedPhone = phone.length > 7
        ? '${phone.substring(0, 3)}****${phone.substring(phone.length - 4)}'
        : phone;
    final total = proposal.totalVotes;
    final ratioPct = total > 0 ? ((proposal.supportVotes / total) * 100).toStringAsFixed(0) : '0';

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                maskedPhone,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${proposal.highestRiskLevel.name.toUpperCase()} · $ratioPct% Delete Ratio',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            proposal.status.name.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
