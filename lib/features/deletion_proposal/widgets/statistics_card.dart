import 'package:flutter/material.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/risk_level.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_audit_stream_card.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_consensus_card.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_hero_banner.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_risk_donut_chart_card.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_status_bar_chart_card.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_trend_line_chart_card.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/risk_bento_grid.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 真实数据驱动 · 社区治理统计控制台组件（100% 绑定原生 RiskLevel 强类型实体 & i18n）
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
    final highRisk = statistics?[RiskLevel.high.toRawString().toLowerCase()] ?? statistics?['highRisk'] ?? 0;
    final mediumRisk = statistics?[RiskLevel.medium.toRawString().toLowerCase()] ?? statistics?['mediumRisk'] ?? 0;
    final lowRisk = statistics?[RiskLevel.low.toRawString().toLowerCase()] ?? statistics?['lowRisk'] ?? 0;
    final count = voteCount ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. 社区威胁情报与 VIP 战报指挥舱组件 (Hero Banner)
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

        // 3. 待处理提议真实概览卡片
        _buildOverviewCard(context, l10n, totalPending),
        const SizedBox(height: 14),

        // 4. 风险等级 3D 异形 Bento 盒组件（原生 RiskLevel 驱动）
        RiskBentoGrid(
          highRisk: highRisk,
          mediumRisk: mediumRisk,
          lowRisk: lowRisk,
        ),
        const SizedBox(height: 14),

        // 5. [FlChart 饼图卡片] 风险等级占比 3D 环形图 (ProposalRiskDonutChartCard)
        const ProposalRiskDonutChartCard(),
        const SizedBox(height: 14),

        // 6. [FlChart 折线图卡片] 社区提议提交趋势折线图 (ProposalTrendLineChartCard)
        const ProposalTrendLineChartCard(),
        const SizedBox(height: 14),

        // 7. [FlChart 柱状图卡片] 提议处置状态对比柱状图 (ProposalStatusBarChartCard)
        const ProposalStatusBarChartCard(),
        const SizedBox(height: 14),

        // 8. 广告集成
        const GoogleAdWidget(adInfo: AdManager.bannerAd),
        const SizedBox(height: 14),

        // 9. 社区共识通过率与下架率动态分析组件
        const ProposalConsensusCard(),
        const SizedBox(height: 14),

        // 10. 社区防护影响力控制台卡片
        _buildImpactCard(context, l10n, totalPending, highRisk),
        const SizedBox(height: 14),

        // 11. 实时社区提议与审议数据流日志组件
        const ProposalAuditStreamCard(),
      ],
    );
  }

  /// 待处理提议真实概览
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
