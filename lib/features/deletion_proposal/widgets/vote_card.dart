import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 投票卡片组件 (基于统一 EliteDopamineTheme 主题系统规范)
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
    final riskLevel = vote['risk_level'] as int? ?? 1;
    final support = vote['support'] as bool? ?? false;
    final votedAt = vote['voted_at'] as String?;
    final status = vote['status'] as String? ?? 'pending';
    final supportCount = vote['support_count'] as int? ?? 0;
    final opposeCount = vote['oppose_count'] as int? ?? 0;

    final totalVotes = supportCount + opposeCount;
    final supportPercentage = totalVotes > 0 ? (supportCount / totalVotes * 100).round() : 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: EliteDopamineTheme.warmCardDecoration(
        context: context,
        borderRadius: BorderRadius.circular(20),
      ),
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
              _buildStatusChip(context, status),
              const SizedBox(width: 8),
              _buildRiskLevelChip(context, riskLevel),
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
            _buildVotingProgress(context, supportCount, opposeCount),
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

          if (status == 'completed') ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: EliteDopamineTheme.freshMint.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: EliteDopamineTheme.freshMint.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 16,
                    color: EliteDopamineTheme.freshMint,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.proposalProcessed,
                    style: TextStyle(
                      color: Colors.green.shade700,
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
    );
  }

  Widget _buildVoteChip(BuildContext context, bool support) {
    final color = support ? EliteDopamineTheme.freshMint : Colors.red;
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

  Widget _buildStatusChip(BuildContext context, String status) {
    Color chipColor;
    IconData icon;
    String displayText;

    switch (status.toLowerCase()) {
      case 'approved':
        chipColor = EliteDopamineTheme.freshMint;
        icon = Icons.check_circle;
        displayText = AppLocalizations.of(context)!.approved;
        break;
      case 'rejected':
        chipColor = Colors.red;
        icon = Icons.cancel;
        displayText = AppLocalizations.of(context)!.rejected;
        break;
      case 'completed':
        chipColor = Colors.blue;
        icon = Icons.done_all;
        displayText = AppLocalizations.of(context)!.completed;
        break;
      case 'pending':
      default:
        chipColor = Colors.orange;
        icon = Icons.pending;
        displayText = AppLocalizations.of(context)!.pending;
        break;
    }

    return Container(
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
    );
  }

  Widget _buildRiskLevelChip(BuildContext context, int riskLevel) {
    Color chipColor;
    String label;

    switch (riskLevel) {
      case 5:
        chipColor = Colors.red;
        label = AppLocalizations.of(context)!.critical;
        break;
      case 4:
        chipColor = Colors.deepOrange;
        label = AppLocalizations.of(context)!.high;
        break;
      case 3:
        chipColor = Colors.orange;
        label = AppLocalizations.of(context)!.medium;
        break;
      case 2:
        chipColor = Colors.yellow.shade700;
        label = AppLocalizations.of(context)!.low;
        break;
      case 1:
      default:
        chipColor = EliteDopamineTheme.freshMint;
        label = AppLocalizations.of(context)!.veryLow;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: chipColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildVotingProgress(BuildContext context, int supportCount, int opposeCount) {
    final total = supportCount + opposeCount;
    if (total == 0) return const SizedBox.shrink();

    return Column(
      children: [
        Row(
          children: [
            if (supportCount > 0)
              Expanded(
                flex: supportCount,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: EliteDopamineTheme.freshMint,
                    borderRadius: BorderRadius.horizontal(
                      left: const Radius.circular(2),
                      right: opposeCount == 0 ? const Radius.circular(2) : Radius.zero,
                    ),
                  ),
                ),
              ),
            if (opposeCount > 0)
              Expanded(
                flex: opposeCount,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.horizontal(
                      left: supportCount == 0 ? const Radius.circular(2) : Radius.zero,
                      right: const Radius.circular(2),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${AppLocalizations.of(context)!.support}: $supportCount',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${AppLocalizations.of(context)!.oppose}: $opposeCount',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
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