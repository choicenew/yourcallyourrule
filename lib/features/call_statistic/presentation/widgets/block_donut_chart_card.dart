import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 动态规则动作分布环形饼图组件 (PieChart / Donut Chart - 100% 数据驱动 & 常驻渲染)
class BlockDonutChartCard extends ConsumerWidget {
  const BlockDonutChartCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(callStatisticsProvider);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final blockRules = state.blockRulesCount;
    final allowRules = state.allowRulesCount;
    final silenceRules = state.silenceRulesCount;
    final timeRules = state.timeRulesCount;
    final noneRules = state.noneRulesCount;

    final int rawTotalSum = blockRules + allowRules + silenceRules + timeRules + noneRules;
    final int totalSum = rawTotalSum > 0 ? rawTotalSum : 1;

    final List<_DonutSectionData> sections = rawTotalSum > 0
        ? [
            if (blockRules > 0)
              _DonutSectionData(
                label: l10n.blockRules,
                value: blockRules,
                color: theme.colorScheme.error,
              ),
            if (allowRules > 0)
              _DonutSectionData(
                label: l10n.allowRules,
                value: allowRules,
                color: theme.colorScheme.primary,
              ),
            if (silenceRules > 0)
              _DonutSectionData(
                label: l10n.silentRules,
                value: silenceRules,
                color: theme.colorScheme.tertiary,
              ),
            if (timeRules > 0)
              _DonutSectionData(
                label: l10n.timeInterceptor,
                value: timeRules,
                color: theme.colorScheme.secondary,
              ),
            if (noneRules > 0)
              _DonutSectionData(
                label: l10n.actionNone,
                value: noneRules,
                color: theme.colorScheme.outline,
              ),
          ]
        : [
            _DonutSectionData(
              label: l10n.blockRules,
              value: 1,
              color: theme.colorScheme.primary,
            ),
          ];

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
                  Icons.pie_chart_rounded,
                  color: theme.colorScheme.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                l10n.blockTypeAnalysisTitle,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // 左侧 🍩 Donut 环形饼图
              SizedBox(
                width: 110,
                height: 110,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 32,
                    sections: sections.map((sec) {
                      return PieChartSectionData(
                        color: sec.color,
                        value: sec.value.toDouble(),
                        radius: 18,
                        showTitle: false,
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // 右侧 动态图例说明与百分比
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: sections.map((sec) {
                    final pct = rawTotalSum > 0 ? ((sec.value / totalSum) * 100).round() : 100;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: sec.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              sec.label,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '$pct%',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: sec.color,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DonutSectionData {
  final String label;
  final int value;
  final Color color;

  const _DonutSectionData({
    required this.label,
    required this.value,
    required this.color,
  });
}
