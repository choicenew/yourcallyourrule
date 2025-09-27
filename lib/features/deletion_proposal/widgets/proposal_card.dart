import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/verification_report_card.dart';

/// 删除提议卡片组件
class ProposalCard extends StatefulWidget {
  final Map<String, dynamic> proposal;
  final Future<bool> Function(String proposalId, bool support) onVote;
  final bool isVoting;

  const ProposalCard({
    super.key,
    required this.proposal,
    required this.onVote,
    this.isVoting = false,
  });

  @override
  State<ProposalCard> createState() => _ProposalCardState();
}

class _ProposalCardState extends State<ProposalCard> {
  bool _showReport = false;

  @override
  Widget build(BuildContext context) {
    final proposal = widget.proposal;
    final phoneNumber = proposal['phone_number'] as String? ?? '';
    final reason = proposal['reason'] as String? ?? '';
    final riskLevel = proposal['risk_level'] as int? ?? 1;
    final proposalId = proposal['proposal_id'] as String? ?? '';
    final createdAt = proposal['created_at'] as String?;
    final supportCount = proposal['support_count'] as int? ?? 0;
    final opposeCount = proposal['oppose_count'] as int? ?? 0;
    final status = proposal['status'] as String? ?? 'pending';
    final verificationReportRaw = proposal['verification_report'];
    
    Map<String, dynamic>? verificationReport;
    if (verificationReportRaw is String) {
      try {
        verificationReport = jsonDecode(verificationReportRaw);
      } catch (e) {
        // Handle JSON parsing error if necessary
      }
    } else if (verificationReportRaw is Map<String, dynamic>) {
      verificationReport = verificationReportRaw;
    }

    final totalVotes = supportCount + opposeCount;
    final supportPercentage = totalVotes > 0 ? (supportCount / totalVotes * 100).round() : 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with phone number and risk level
            Row(
              children: [
                Expanded(
                  child: Text(
                    phoneNumber,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildRiskLevelChip(context, riskLevel),
              ],
            ),
            const SizedBox(height: 8),
            
            // Status and creation time
            Row(
              children: [
                _buildStatusChip(context, status),
                const Spacer(),
                if (createdAt != null)
                  Text(
                    _formatDateTime(createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Reason
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
            ),
            
            // Verification Report Section
            if (verificationReport != null) ...[
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  setState(() {
                    _showReport = !_showReport;
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.assessment,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      AppLocalizations.of(context)!.verificationReport,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      _showReport ? Icons.expand_less : Icons.expand_more,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
              if (_showReport) ...[
                const SizedBox(height: 8),
                VerificationReportCard(report: verificationReport),
              ],
            ],
            const SizedBox(height: 16),
            
            // Voting statistics
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
                    'Votes: $totalVotes ($supportPercentage% support)',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildVotingProgress(context, supportCount, opposeCount),
              const SizedBox(height: 16),
            ],
            
            // Action buttons
            if (status == 'pending') ...[
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: widget.isVoting ? null : () => _handleVote(false),
                      icon: const Icon(Icons.thumb_down, size: 18),
                      label: Text('${AppLocalizations.of(context)!.voteDisagree} ($opposeCount)'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: widget.isVoting ? null : () => _handleVote(true),
                      icon: const Icon(Icons.thumb_up, size: 18),
                      label: Text('${AppLocalizations.of(context)!.voteAgree} ($supportCount)'),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
          ],
          ],
        ),
      ),
    );
  }

  Widget _buildRiskLevelChip(BuildContext context, int riskLevel) {
    Color chipColor;
    String label;
    
    switch (riskLevel) {
      case 5:
        chipColor = Colors.red;
        label = 'Critical';
        break;
      case 4:
        chipColor = Colors.deepOrange;
        label = 'High';
        break;
      case 3:
        chipColor = Colors.orange;
        label = 'Medium';
        break;
      case 2:
        chipColor = Colors.yellow.shade700;
        label = 'Low';
        break;
      case 1:
      default:
        chipColor = Colors.green;
        label = 'Very Low';
        break;
    }

    return Chip(
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: chipColor,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildStatusChip(BuildContext context, String status) {
    Color chipColor;
    IconData icon;
    
    switch (status.toLowerCase()) {
      case 'approved':
        chipColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case 'rejected':
        chipColor = Colors.red;
        icon = Icons.cancel;
        break;
      case 'pending':
      default:
        chipColor = Colors.blue;
        icon = Icons.pending;
        break;
    }

    return Chip(
      avatar: Icon(
        icon,
        size: 16,
        color: Colors.white,
      ),
      label: Text(
        status.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: chipColor,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildVotingProgress(BuildContext context, int supportCount, int opposeCount) {
    final total = supportCount + opposeCount;
    if (total == 0) return const SizedBox.shrink();
    
    final supportRatio = supportCount / total;
    
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: supportCount,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.horizontal(
                    left: const Radius.circular(3),
                    right: opposeCount == 0 ? const Radius.circular(3) : Radius.zero,
                  ),
                ),
              ),
            ),
            if (opposeCount > 0)
              Expanded(
                flex: opposeCount,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.horizontal(
                      left: supportCount == 0 ? const Radius.circular(3) : Radius.zero,
                      right: const Radius.circular(3),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Support: $supportCount',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Oppose: $opposeCount',
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
        return 'Just now';
      }
    } catch (e) {
      return dateTimeString;
    }
  }

  void _handleVote(bool support) {
    final proposalId = widget.proposal['proposal_id'] as String? ?? '';
    if (proposalId.isNotEmpty) {
      widget.onVote(proposalId, support);
    }
  }
}