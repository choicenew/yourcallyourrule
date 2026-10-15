import 'package:flutter/material.dart';
import 'package:yourcallyourrule/theme/dopamine_theme_extension.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal_status.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/verification_report_card.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_status_chip.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_risk_chip.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/vote_progress_bar.dart';

/// 删除提议卡片组件 (100% 强类型与领域实体对齐)
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

    final supportCount = proposal.supportVotes;
    final opposeCount = proposal.opposeVotes;
    final totalVotes = proposal.totalVotes;

    final verificationReport = proposal.verificationReport;
    final supportPercentage =
        totalVotes > 0 ? (supportCount / totalVotes * 100).round() : 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 头部：号码与风险等级
            Row(
              children: [
                Expanded(
                  child: Text(
                    phoneNumber,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                ProposalRiskChip(riskLevel: proposal.highestRiskLevel),
              ],
            ),
            const SizedBox(height: 8),

            // 状态与创建时间
            Row(
              children: [
                ProposalStatusChip(status: proposal.status),
                const Spacer(),
                Text(
                  _formatDateTime(createdAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              reason,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
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
                      Icon(
                        Icons.assessment_rounded,
                        size: 16,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        l10n.verificationReport,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
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
                        color: Theme.of(context).colorScheme.tertiary,
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
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    l10n.votesWithPercentage(totalVotes, supportPercentage),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              VoteProgressBar(supportCount: supportCount, opposeCount: opposeCount),
              const SizedBox(height: 14),
            ],

            // 投票操作按钮
            if (proposal.status == ProposalStatus.pending) ...[
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
                        foregroundColor: Theme.of(context).colorScheme.error,
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.error.withValues(alpha: 0.3),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
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
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        foregroundColor: Theme.of(context).colorScheme.onTertiary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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

  Future<void> _handleVote(bool support) async {
    await widget.onVote(widget.proposal.phoneNumber, support);
  }

  String _formatDateTime(String isoString) {
    try {
      final dateTime = DateTime.parse(isoString);
      return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return isoString;
    }
  }
}
