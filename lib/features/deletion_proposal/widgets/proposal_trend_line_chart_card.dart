import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 真实数据驱动 · 社区提议时间序列趋势折线图卡片组件
class ProposalTrendLineChartCard extends ConsumerWidget {
  const ProposalTrendLineChartCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final proposalState = ref.watch(deletionProposalProvider);
    final proposals = proposalState.proposals;

    final isSkeleton = proposals.isEmpty;

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
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.show_chart_rounded,
                  color: theme.colorScheme.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                l10n.blockingTrend,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 120,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: isSkeleton
                        ? const [
                            FlSpot(0, 1.2),
                            FlSpot(1, 2.5),
                            FlSpot(2, 1.8),
                            FlSpot(3, 3.0),
                            FlSpot(4, 2.1),
                            FlSpot(5, 2.7),
                            FlSpot(6, 1.4),
                          ]
                        : proposals.asMap().entries.map((entry) {
                            return FlSpot(entry.key.toDouble(), (entry.value.proposalCount).toDouble());
                          }).toList(),
                    isCurved: true,
                    curveSmoothness: 0.38,
                    color: isSkeleton
                        ? theme.colorScheme.primary.withValues(alpha: 0.2)
                        : theme.colorScheme.primary,
                    barWidth: 2.2,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: !isSkeleton),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          theme.colorScheme.primary.withValues(alpha: isSkeleton ? 0.05 : 0.15),
                          theme.colorScheme.primary.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
