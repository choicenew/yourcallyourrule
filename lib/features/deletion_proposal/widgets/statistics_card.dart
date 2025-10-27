import 'package:flutter/material.dart';

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
        // Vote statistics card (if voteCount is provided)
        if (voteCount != null) ...[
          Card(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.how_to_vote,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)!.statistics,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildStatisticItem(
                    context,
                    AppLocalizations.of(context)!.totalVotes(voteCount!),
                    voteCount.toString(),
                    Icons.how_to_vote,
                    Theme.of(context).colorScheme.secondary,
                  ),
                  if (onExchangeVip != null) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: onExchangeVip,
                        icon: const Icon(Icons.star),
                        label: Text(AppLocalizations.of(context)!.exchangeVip),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        // Overview card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.analytics,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.overview,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildStatisticItem(
                  context,
                  AppLocalizations.of(context)!.totalPendingProposals,
                  totalPending.toString(),
                  Icons.pending_actions,
                  Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Risk level breakdown
        Row(
          children: [
            Expanded(
              child: _buildRiskLevelCard(
                context,
                AppLocalizations.of(context)!.highRisk,
                highRisk,
                Icons.warning,
                Colors.red,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildRiskLevelCard(
                context,
                AppLocalizations.of(context)!.mediumRisk,
                mediumRisk,
                Icons.info,
                Colors.orange,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildRiskLevelCard(
                context,
                AppLocalizations.of(context)!.lowRisk,
                lowRisk,
                Icons.check_circle,
                Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Additional metrics
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.communityImpact,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildMetricRow(
                  context,
                  AppLocalizations.of(context)!.activeProposals,
                  totalPending.toString(),
                  Icons.assignment,
                ),
                const SizedBox(height: 12),
                _buildMetricRow(
                  context,
                  AppLocalizations.of(context)!.criticalIssues,
                  highRisk.toString(),
                  Icons.priority_high,
                ),
                const SizedBox(height: 12),
                _buildMetricRow(
                  context,
                  AppLocalizations.of(context)!.communityParticipation,
                  _calculateParticipationLevel(context, totalPending),
                  Icons.people,
                ),
              ],
            ),
          ),
        ),
      ],
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
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
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
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              count.toString(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
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