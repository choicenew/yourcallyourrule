import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/verification_report_card.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_status_chip.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_risk_chip.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/vote_progress_bar.dart';

/// 删除提议卡片组件 (Elite Dopamine 现代视觉规范)
class ProposalCard extends StatefulWidget {
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
    final l10n = AppLocalizations.of(context)!;
    final proposal = widget.proposal;
    final phoneNumber = proposal.phoneNumber;
    final reason = proposal.reason;
    final createdAt = proposal.proposalStartTime.toIso8601String();
    final status = proposal.status.name;

    final supportCount = proposal.supportVotes;
    final opposeCount = proposal.opposeVotes;
    final totalVotes = proposal.totalVotes;

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
    final verificationReport = proposal.verificationReport;
    final supportPercentage =
        totalVotes > 0 ? (supportCount / totalVotes * 100).round() : 0;

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
          // 头部：号码与风险等级
          Row(
            children: [
              Expanded(
                child: Text(
                  phoneNumber,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
              ),
              ProposalRiskChip(riskLevel: riskLevel),
            ],
          ),
          const SizedBox(height: 8),

          // 状态与创建时间
          Row(
            children: [
              ProposalStatusChip(status: status),
              const Spacer(),
              Text(
                _formatDateTime(createdAt),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 提议原因
          Text(
            l10n.reason,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            reason,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              height: 1.4,
            ),
          ),

          // 验证报告折叠区域
          if (verificationReport != null) ...[
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                setState(() {
                  _showReport = !_showReport;
                });
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(
                      Icons.assessment_rounded,
                      size: 16,
                      color: Color(0xFF6C5CE7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      l10n.verificationReport,
                      style: const TextStyle(
                        color: Color(0xFF6C5CE7),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      _showReport
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 16,
                      color: const Color(0xFF6C5CE7),
                    ),
                  ],
                ),
              ),
            ),
            if (_showReport) ...[
              const SizedBox(height: 8),
              VerificationReportCard(report: verificationReport),
            ],
          ],
          const SizedBox(height: 14),

          // 投票进度条与数据
          if (totalVotes > 0) ...[
            Row(
              children: [
                Icon(
                  Icons.poll_rounded,
                  size: 14,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  l10n.votesWithPercentage(totalVotes, supportPercentage),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            VoteProgressBar(supportCount: supportCount, opposeCount: opposeCount),
            const SizedBox(height: 14),
          ],

          // 投票操作按钮
          if (status == 'pending') ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed:
                        widget.isVoting ? null : () => _handleVote(false),
                    icon: const Icon(Icons.thumb_down_rounded, size: 16),
                    label: Text(
                      '${l10n.voteDisagree} ($opposeCount)',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      side: const BorderSide(color: Colors.redAccent, width: 1.1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        widget.isVoting ? null : () => _handleVote(true),
                    icon: const Icon(Icons.thumb_up_rounded, size: 16),
                    label: Text(
                      '${l10n.voteAgree} ($supportCount)',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: EliteDopamineTheme.freshMint,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ],
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

  void _handleVote(bool support) {
    // 【MODIFIED】: 直接从强类型对象获取 proposalId (即 phoneNumber)
    final proposalId = widget.proposal.phoneNumber;
    if (proposalId.isNotEmpty) {
      widget.onVote(proposalId, support);
    }
  }
}
