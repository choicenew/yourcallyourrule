import 'package:flutter/material.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 投票卡片组件
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
    final proposalId = vote['proposal_id'] as String? ?? '';
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

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with phone number and your vote
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
            
            // Status and vote time
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
            
            // Reason
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
            
            // Current voting status
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
            
            // Action based on status
            if (status == 'completed') ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 16,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.proposalProcessed,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w500,
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
    return Chip(
      avatar: Icon(
        support ? Icons.thumb_up : Icons.thumb_down,
        size: 16,
        color: Colors.white,
      ),
      label: Text(
        support ? AppLocalizations.of(context)!.supported : AppLocalizations.of(context)!.opposed,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: support ? Colors.green : Colors.red,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildStatusChip(BuildContext context, String status) {
    Color chipColor;
    IconData icon;
    String displayText;
    
    switch (status.toLowerCase()) {
      case 'approved':
        chipColor = Colors.green;
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

    return Chip(
      avatar: Icon(
        icon,
        size: 14,
        color: Colors.white,
      ),
      label: Text(
        displayText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: chipColor,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
        chipColor = Colors.green;
        label = AppLocalizations.of(context)!.veryLow;
        break;
    }

    return Chip(
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: chipColor,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                    color: Colors.green,
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