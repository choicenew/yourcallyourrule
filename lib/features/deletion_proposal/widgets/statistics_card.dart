import 'package:flutter/material.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 高信息密度社区治理统计分析卡片组件（100% 系统 Theme.of(context) 主题 & i18n）
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
    final l10n = AppLocalizations.of(context)!;
    final totalPending = statistics?['totalPending'] ?? 0;
    final highRisk = statistics?['highRisk'] ?? 0;
    final mediumRisk = statistics?['mediumRisk'] ?? 0;
    final lowRisk = statistics?['lowRisk'] ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. 社区参与与投票概览卡片
        if (voteCount != null) ...[
          _buildVoteStatsCard(context, l10n),
          const SizedBox(height: 14),
        ],

        // 2. 广告集成
        const GoogleAdWidget(adInfo: AdManager.bannerAd),
        const SizedBox(height: 14),

        // 3. 待处理提议概览
        _buildOverviewCard(context, l10n, totalPending),
        const SizedBox(height: 14),

        // 4. 广告集成
        const GoogleAdWidget(adInfo: AdManager.bannerAd),
        const SizedBox(height: 14),

        // 5. 风险等级三宫格分布
        _buildRiskBreakdownRow(context, l10n, highRisk, mediumRisk, lowRisk),
        const SizedBox(height: 14),

        // 6. 广告集成
        const GoogleAdWidget(adInfo: AdManager.bannerAd),
        const SizedBox(height: 14),

        // 7. 社区防护影响力统计卡片
        _buildImpactCard(context, l10n, totalPending, highRisk),
      ],
    );
  }

  Widget _buildVoteStatsCard(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1.1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.how_to_vote_rounded,
                  color: theme.colorScheme.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                l10n.statistics,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildStatisticItem(
            context,
            l10n.totalVotes(voteCount!),
            '$voteCount',
            Icons.how_to_vote_rounded,
            theme.colorScheme.primary,
          ),
          if (onExchangeVip != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onExchangeVip,
                icon: const Icon(Icons.workspace_premium_rounded, size: 18),
                label: Text(
                  l10n.exchangeVip,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOverviewCard(BuildContext context, AppLocalizations l10n, int totalPending) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1.1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
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
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildStatisticItem(
            context,
            l10n.totalPendingProposals,
            '$totalPending',
            Icons.pending_actions_rounded,
            theme.colorScheme.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildRiskBreakdownRow(BuildContext context, AppLocalizations l10n, int highRisk, int mediumRisk, int lowRisk) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: _buildRiskLevelCard(
            context,
            l10n.highRisk,
            highRisk,
            Icons.warning_amber_rounded,
            theme.colorScheme.error,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildRiskLevelCard(
            context,
            l10n.mediumRisk,
            mediumRisk,
            Icons.info_outline_rounded,
            theme.colorScheme.tertiary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildRiskLevelCard(
            context,
            l10n.lowRisk,
            lowRisk,
            Icons.check_circle_outline_rounded,
            theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildImpactCard(BuildContext context, AppLocalizations l10n, int totalPending, int highRisk) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1.1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.communityImpact,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
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
            _calculateParticipationLevel(context, totalPending),
            Icons.people_alt_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 22,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRiskLevelCard(
    BuildContext context,
    String title,
    int count,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1.1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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

  String _calculateParticipationLevel(BuildContext context, int totalProposals) {
    final localizations = AppLocalizations.of(context)!;
    if (totalProposals == 0) {
      return localizations.noActivity;
    } else if (totalProposals < 5) {
      return localizations.low;
    } else if (totalProposals < 20) {
      return localizations.moderate;
    } else if (totalProposals < 50) {
      return localizations.high;
    } else {
      return localizations.veryHigh;
    }
  }
}
