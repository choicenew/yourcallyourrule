import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/statistics_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 真实数据驱动 · 社区提议风险等级分布环形饼图卡片组件
class ProposalRiskDonutChartCard extends ConsumerWidget {
  const ProposalRiskDonutChartCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final statisticsAsync = ref.watch(proposalStatisticsProvider);

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
                  color: theme.colorScheme.secondary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.donut_large_rounded,
                  color: theme.colorScheme.secondary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                l10n.riskLevelLabel,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          statisticsAsync.when(
            data: (stats) {
              final high = stats['highRisk'] ?? 0;
              final medium = stats['mediumRisk'] ?? 0;
              final low = stats['lowRisk'] ?? 0;
              final total = high + medium + low;

              return SizedBox(
                height: 140,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 3,
                          centerSpaceRadius: 36,
                          sections: total > 0
                              ? [
                                  PieChartSectionData(
                                    color: theme.colorScheme.error,
                                    value: high.toDouble(),
                                    title: '',
                                    radius: 18,
                                  ),
                                  PieChartSectionData(
                                    color: theme.colorScheme.tertiary,
                                    value: medium.toDouble(),
                                    title: '',
                                    radius: 18,
                                  ),
                                  PieChartSectionData(
                                    color: theme.colorScheme.primary,
                                    value: low.toDouble(),
                                    title: '',
                                    radius: 18,
                                  ),
                                ]
                              : [
                                  PieChartSectionData(
                                    color: theme.colorScheme.outlineVariant.withValues(alpha: 0.25),
                                    value: 1,
                                    title: '',
                                    radius: 14,
                                  ),
                                ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLegendItem(context, l10n.highRisk, high, total, theme.colorScheme.error),
                          const SizedBox(height: 8),
                          _buildLegendItem(context, l10n.mediumRisk, medium, total, theme.colorScheme.tertiary),
                          const SizedBox(height: 8),
                          _buildLegendItem(context, l10n.lowRisk, low, total, theme.colorScheme.primary),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const SizedBox(
              height: 140,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            error: (_, _) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(
    BuildContext context,
    String label,
    int value,
    int total,
    Color color,
  ) {
    final theme = Theme.of(context);
    final pct = total > 0 ? ((value / total) * 100).toStringAsFixed(0) : '0';

    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        Text(
          '$value ($pct%)',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
