import 'package:flutter/material.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal_status.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/risk_level.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_audit_stream_card.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_consensus_card.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_hero_banner.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_risk_donut_chart_card.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_status_bar_chart_card.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_trend_line_chart_card.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/risk_bento_grid.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class StatisticsCard extends StatelessWidget {
  final List<Proposal>? proposals;
  final Map<String, int>? statistics;
  final int? voteCount;
  final VoidCallback? onExchangeVip;

  const StatisticsCard({
    super.key,
    this.proposals,
    this.statistics,
    this.voteCount,
    this.onExchangeVip,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    final totalPending = proposals != null
        ? proposals!.where((proposal) => proposal.status == ProposalStatus.pending).length
        : (statistics?['totalPending'] ?? 0);
    final highRisk = proposals != null
        ? proposals!.where((proposal) => proposal.highestRiskLevel == RiskLevel.high).length
        : (statistics?['highRisk'] ?? 0);
    final mediumRisk = proposals != null
        ? proposals!.where((proposal) => proposal.highestRiskLevel == RiskLevel.medium).length
        : (statistics?['mediumRisk'] ?? 0);
    final lowRisk = proposals != null
        ? proposals!.where((proposal) => proposal.highestRiskLevel == RiskLevel.low || proposal.highestRiskLevel == RiskLevel.verified).length
        : (statistics?['lowRisk'] ?? 0);
    final count = voteCount ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProposalHeroBanner(
          voteCount: count,
          totalPending: totalPending,
          highRisk: highRisk,
          onExchangeVip: onExchangeVip,
        ),
        const SizedBox(height: 14),

        const AdsInlineBanner(),
        const SizedBox(height: 14),

        _buildOverviewCard(context, l10n, totalPending),
        const SizedBox(height: 14),

        RiskBentoGrid(
          highRisk: highRisk,
          mediumRisk: mediumRisk,
          lowRisk: lowRisk,
        ),
        const SizedBox(height: 14),

        const ProposalRiskDonutChartCard(),
        const SizedBox(height: 14),

        const ProposalTrendLineChartCard(),
        const SizedBox(height: 14),

        const ProposalStatusBarChartCard(),
        const SizedBox(height: 14),

        const AdsInlineBanner(),
        const SizedBox(height: 14),

        const ProposalConsensusCard(),
        const SizedBox(height: 14),

        _buildImpactCard(context, l10n, totalPending, highRisk),
        const SizedBox(height: 14),

        const ProposalAuditStreamCard(),
      ],
    );
  }

  Widget _buildOverviewCard(BuildContext context, AppLocalizations l10n, int totalPending) {
    final theme = Theme.of(context);

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
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.analytics_rounded,
                      color: theme.colorScheme.secondary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    l10n.overview,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.pending_actions_rounded,
                  color: theme.colorScheme.secondary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$totalPending',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    Text(
                      l10n.totalPendingProposals,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImpactCard(BuildContext context, AppLocalizations l10n, int totalPending, int highRisk) {
    final theme = Theme.of(context);

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
          Text(
            l10n.communityImpact,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 14),
          _buildMetricRow(
            context,
            l10n.activeProposals,
            '$totalPending',
            Icons.assignment_outlined,
          ),
          const SizedBox(height: 10),
          _buildMetricRow(
            context,
            l10n.criticalIssues,
            '$highRisk',
            Icons.priority_high_rounded,
          ),
          const SizedBox(height: 10),
          _buildMetricRow(
            context,
            l10n.communityParticipation,
            _calculateParticipationLevel(context, totalPending, l10n),
            Icons.people_alt_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: theme.colorScheme.outline,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  String _calculateParticipationLevel(BuildContext context, int totalProposals, AppLocalizations l10n) {
    if (totalProposals == 0) {
      return l10n.noActivity;
    } else if (totalProposals < 5) {
      return l10n.low;
    } else if (totalProposals < 20) {
      return l10n.moderate;
    } else if (totalProposals < 50) {
      return l10n.high;
    } else {
      return l10n.veryHigh;
    }
  }
}
