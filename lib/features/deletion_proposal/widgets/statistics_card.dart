import 'package:flutter/material.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 统计信息卡片组件
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
    final totalPending = statistics?['totalPending'] ?? 0;
    final highRisk = statistics?['highRisk'] ?? 0;
    final mediumRisk = statistics?['mediumRisk'] ?? 0;
    final lowRisk = statistics?['lowRisk'] ?? 0;

    return Column(
      children: [
        if (voteCount != null) ...[
          _buildVoteStatsCard(context),
          const SizedBox(height: 14),
        ],
        GoogleAdWidget(adInfo: AdManager.bannerAd),
        const SizedBox(height: 14),
        _buildOverviewCard(context, totalPending),
        const SizedBox(height: 14),
        GoogleAdWidget(adInfo: AdManager.bannerAd),
        const SizedBox(height: 14),
        _buildRiskBreakdownRow(context, highRisk, mediumRisk, lowRisk),
        const SizedBox(height: 14),
        GoogleAdWidget(adInfo: AdManager.bannerAd),  
        const SizedBox(height: 14),
        _buildImpactCard(context, totalPending, highRisk),
      ],
    );
  }

  Widget _buildVoteStatsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.how_to_vote_rounded,
                  color: Color(0xFFFF9500),
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.statistics,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStatisticItem(
            context,
            AppLocalizations.of(context)!.totalVotes(voteCount!),
            voteCount.toString(),
            Icons.how_to_vote_rounded,
            const Color(0xFFFF9500),
          ),
          if (onExchangeVip != null) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF9500), Color(0xFFFF5E3A)],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF9500).withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: onExchangeVip,
                icon: const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 18),
                label: Text(
                  AppLocalizations.of(context)!.exchangeVip,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOverviewCard(BuildContext context, int totalPending) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.analytics_rounded,
                  color: Color(0xFF6C5CE7),
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.overview,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStatisticItem(
            context,
            AppLocalizations.of(context)!.totalPendingProposals,
            totalPending.toString(),
            Icons.pending_actions_rounded,
            const Color(0xFF6C5CE7),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskBreakdownRow(BuildContext context, int highRisk, int mediumRisk, int lowRisk) {
    return Row(
      children: [
        Expanded(
          child: _buildRiskLevelCard(
            context,
            AppLocalizations.of(context)!.highRisk,
            highRisk,
            Icons.warning_amber_rounded,
            const Color(0xFFFF4B4B),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildRiskLevelCard(
            context,
            AppLocalizations.of(context)!.mediumRisk,
            mediumRisk,
            Icons.info_outline_rounded,
            const Color(0xFFFF9500),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildRiskLevelCard(
            context,
            AppLocalizations.of(context)!.lowRisk,
            lowRisk,
            Icons.check_circle_outline_rounded,
            const Color(0xFF34C759),
          ),
        ),
      ],
    );
  }

  Widget _buildImpactCard(BuildContext context, int totalPending, int highRisk) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.communityImpact,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildMetricRow(
            context,
            AppLocalizations.of(context)!.activeProposals,
            totalPending.toString(),
            Icons.assignment_outlined,
          ),
          const SizedBox(height: 12),
          _buildMetricRow(
            context,
            AppLocalizations.of(context)!.criticalIssues,
            highRisk.toString(),
            Icons.priority_high_rounded,
          ),
          const SizedBox(height: 12),
          _buildMetricRow(
            context,
            AppLocalizations.of(context)!.communityParticipation,
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
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
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
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
              size: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
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
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.outline,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
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