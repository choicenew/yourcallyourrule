import 'package:flutter/material.dart';
import 'package:yourcallyourrule/theme/dopamine_theme_extension.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal_status.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/risk_level.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_status_chip.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_risk_chip.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/vote_progress_bar.dart';

/// 投票卡片组件 (基于领域实体枚举与 Theme 主题规范)
class VoteCard extends StatelessWidget {
  final Map<String, dynamic> vote;
  final VoidCallback onUpdate;

  const VoteCard({
    super.key,
    required this.vote,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final phoneNumber = vote['phone_number'] as String? ?? '';
    final reason = vote['reason'] as String? ?? '';
    final rawRisk = vote['risk_level'];
    final riskLevel = rawRisk is RiskLevel
        ? rawRisk
        : RiskLevel.fromString(rawRisk?.toString() ?? 'high');

    final support = vote['support'] as bool? ?? false;
    final votedAt = vote['voted_at'] as String?;
    final rawStatus = vote['status'];
    final status = rawStatus is ProposalStatus
        ? rawStatus
        : ProposalStatus.fromString(rawStatus?.toString() ?? 'pending');

    final supportCount = vote['support_count'] as int? ?? 0;
    final opposeCount = vote['oppose_count'] as int? ?? 0;

    final totalVotes = supportCount + opposeCount;
    final supportPercentage = totalVotes > 0 ? (supportCount / totalVotes * 100).round() : 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头部：电话号码与投票标识
          Row(
            children: [
              Expanded(
                child: Text(
                  phoneNumber,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildVoteChip(context, support),
            ],
          ),
          const SizedBox(height: 8),

          // 状态、风险等级与投票时间
          Row(
            children: [
              ProposalStatusChip(status: status),
              const SizedBox(width: 8),
              ProposalRiskChip(riskLevel: riskLevel),
              const Spacer(),
              if (votedAt != null)
                Text(
                  '${AppLocalizations.of(context)!.voted} ${_formatDateTime(votedAt)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // 提议原因
          if (reason.isNotEmpty) ...[
            Text(
              AppLocalizations.of(context)!.reason,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              reason,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
          ],

          // 投票进度
          if (totalVotes > 0) ...[
            Row(
              children: [
                Icon(
                  Icons.poll,
                  size: 16,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(width: 4),
                Text(
                  '${AppLocalizations.of(context)!.communityVotes}: $totalVotes ($supportPercentage% ${AppLocalizations.of(context)!.support})',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            VoteProgressBar(supportCount: supportCount, opposeCount: opposeCount),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.hourglass_empty,
                    size: 16,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.waitingForMoreVotes,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ],

          if (status == ProposalStatus.approved || status == ProposalStatus.expired) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.proposalProcessed,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    ),
    );
  }

  Widget _buildVoteChip(BuildContext context, bool support) {
    final color = support ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.error;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            support ? Icons.thumb_up : Icons.thumb_down,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            support ? AppLocalizations.of(context)!.supported : AppLocalizations.of(context)!.opposed,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'just now';
      }
    } catch (e) {
      return dateTimeString;
    }
  }
}
