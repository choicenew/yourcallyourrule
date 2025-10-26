import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

// 【MODIFIED】: 引入了强类型的 Proposal 模型。
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/verification_report_card.dart';

/// 删除提议卡片组件
///
/// 【MODIFIED】: 这个 Widget 现在是类型安全的，它接收一个 `Proposal` 对象。
class ProposalCard extends StatefulWidget {
  // 【MODIFIED】: 参数类型从 `Map<String, dynamic>` 改为强类型的 `Proposal`。
  final Proposal proposal;
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
    // 【MODIFIED】: 不再需要手动从 Map 中解析和做类型转换。
    // 我们直接从强类型的 `widget.proposal` 对象访问所有需要的属性。
    final proposal = widget.proposal;
    final phoneNumber = proposal.phoneNumber;
    final reason = proposal.reason; // 使用我们在 Proposal 模型中定义的 getter
    final proposalId = proposal.phoneNumber;
    final createdAt = proposal.proposalStartTime.toIso8601String();
    final status = proposal.status.name;

    // 【MODIFIED】: 使用 Proposal 模型中定义的 getters 来获取正确的票数。
    final supportCount = proposal.supportVotes;
    final opposeCount = proposal.opposeVotes;
    final totalVotes = proposal.totalVotes;

    // 【MODIFIED】: 在 Widget 内部处理业务逻辑转换（字符串 -> 整数）。
    // REASON: 这是 UI 展示逻辑，将其放在 Widget 内部是合适的。
    int riskLevelToInt(String riskString) {
      switch (riskString.toLowerCase()) {
        case 'high':
          return 5;
        case 'medium':
          return 3;
        case 'low':
          return 2;
        case 'verified':
          return 1;
        default:
          return 3;
      }
    }

    final riskLevel = riskLevelToInt(proposal.highestRiskLevel);

    // 【MODIFIED】: `verificationReport` 现在也是一个 getter。
    final verificationReport =
        proposal.verificationReport; // 使用 Proposal 模型中的 getter

    final supportPercentage =
        totalVotes > 0 ? (supportCount / totalVotes * 100).round() : 0;

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
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(reason, style: Theme.of(context).textTheme.bodyMedium),

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
                    AppLocalizations.of(
                      context,
                    )!.votesWithPercentage(totalVotes, supportPercentage),
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
                      onPressed:
                          widget.isVoting ? null : () => _handleVote(false),
                      icon: const Icon(Icons.thumb_down, size: 18),
                      label: Text(
                        '${AppLocalizations.of(context)!.voteDisagree} ($opposeCount)',
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed:
                          widget.isVoting ? null : () => _handleVote(true),
                      icon: const Icon(Icons.thumb_up, size: 18),
                      label: Text(
                        '${AppLocalizations.of(context)!.voteAgree} ($supportCount)',
                      ),
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

  // --- 辅助方法 (_buildRiskLevelChip, _buildStatusChip,等) 保持不变 ---
  // (此处省略所有辅助方法的代码，因为它们无需修改)
  Widget _buildRiskLevelChip(BuildContext context, int riskLevel) {
    Color chipColor;
    String label;
    switch (riskLevel) {
      case 5:
        chipColor = Colors.red;
        label = AppLocalizations.of(context)!.riskLevelCritical;
        break;
      case 4:
        chipColor = Colors.deepOrange;
        label = AppLocalizations.of(context)!.riskLevelHigh;
        break;
      case 3:
        chipColor = Colors.orange;
        label = AppLocalizations.of(context)!.riskLevelMedium;
        break;
      case 2:
        chipColor = Colors.yellow.shade700;
        label = AppLocalizations.of(context)!.riskLevelLow;
        break;
      case 1:
      default:
        chipColor = Colors.green;
        label = AppLocalizations.of(context)!.riskLevelVeryLow;
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
      avatar: Icon(icon, size: 16, color: Colors.white),
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

  Widget _buildVotingProgress(
    BuildContext context,
    int supportCount,
    int opposeCount,
  ) {
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
                    right:
                        opposeCount == 0
                            ? const Radius.circular(3)
                            : Radius.zero,
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
                      left:
                          supportCount == 0
                              ? const Radius.circular(3)
                              : Radius.zero,
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
              AppLocalizations.of(context)!.supportCount(supportCount),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.opposeCount(opposeCount),
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
      final difference = DateTime.now().difference(dateTime);
      if (difference.inDays > 0) return '${difference.inDays}d ago';
      if (difference.inHours > 0) return '${difference.inHours}h ago';
      if (difference.inMinutes > 0) return '${difference.inMinutes}m ago';
      return 'Just now';
    } catch (e) {
      return dateTimeString;
    }
  }

  void _handleVote(bool support) {
    // 【MODIFIED】: 直接从强类型对象获取 proposalId (即 phoneNumber)
    final proposalId = widget.proposal.phoneNumber;
    if (proposalId.isNotEmpty) {
      widget.onVote(proposalId, support);
    }
  }
}
