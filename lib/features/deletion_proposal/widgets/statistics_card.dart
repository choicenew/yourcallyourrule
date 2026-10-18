import 'package:flutter/material.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_audit_stream_card.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_consensus_card.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_hero_banner.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/risk_bento_grid.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 极致高信息密度 · 社区威胁情报与众包治理控制台组装组件（模块化微组件设计，100% 原生 Theme.of(context) & i18n）
class StatisticsCard extends StatelessWidget {
  final Map<String, int>? statistics;
  final int? voteCount;
  final VoidCallback? onExchangeVip;

  const StatisticsCard({
    super.key,
    this.statistics,
    this.voteCount,
    this.onExchangeVip,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final totalPending = statistics?['totalPending'] ?? 0;
    final highRisk = statistics?['highRisk'] ?? 0;
    final mediumRisk = statistics?['mediumRisk'] ?? 0;
    final lowRisk = statistics?['lowRisk'] ?? 0;
    final count = voteCount ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. 社区威胁情报与 VIP 战报指挥舱组件
        ProposalHeroBanner(
          voteCount: count,
          totalPending: totalPending,
          highRisk: highRisk,
          onExchangeVip: onExchangeVip,
        ),
        const SizedBox(height: 14),

        // 2. 广告集成
        const GoogleAdWidget(adInfo: AdManager.bannerAd),
        const SizedBox(height: 14),

        // 3. 待处理提议战报卡片
        _buildOverviewCard(context, l10n, totalPending),
        const SizedBox(height: 14),

        // 4. 风险等级 3D 异形 Bento 盒组件
        RiskBentoGrid(
          highRisk: highRisk,
          mediumRisk: mediumRisk,
          lowRisk: lowRisk,
        ),
        const SizedBox(height: 14),

        // 5. 广告集成
        const GoogleAdWidget(adInfo: AdManager.bannerAd),
        const SizedBox(height: 14),

        // 6. 社区共识通过率与审议趋势卡片组件
        const ProposalConsensusCard(),
        const SizedBox(height: 14),

        // 7. 社区防护影响力控制台卡片
        _buildImpactCard(context, l10n, totalPending, highRisk),
        const SizedBox(height: 14),

        // 8. 实时社区审议日志数据流组件
        const ProposalAuditStreamCard(),
      ],
    );
  }

  /// 待处理提议概览
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Sync Interval: 15m',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
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

  /// 社区防护影响力控制台卡片
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
