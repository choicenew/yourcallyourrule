// -----------------------------------------------------------------------------
// 文件: elite_stats_insight_card.dart
// 描述: Elite 拦截成就与数据战报卡片，展示已防护通话统计与全类型规则分布。
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/statistic_period.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// ------------------- Widget 定义 -------------------

class EliteStatsInsightCard extends ConsumerStatefulWidget {
  const EliteStatsInsightCard({super.key});

  @override
  ConsumerState<EliteStatsInsightCard> createState() => _EliteStatsInsightCardState();
}

class _EliteStatsInsightCardState extends ConsumerState<EliteStatsInsightCard> {
  // 100% 强类型领域枚举，拒绝硬编码字符串
  StatisticPeriod _selectedPeriod = StatisticPeriod.week;

  void _navigateToStatistics() {
    context.pushNamed(AppRouter.callStatistics);
  }

  void _onPeriodChanged(StatisticPeriod period) {
    if (_selectedPeriod == period) return;
    setState(() {
      _selectedPeriod = period;
    });
    // 强类型枚举直接传递给 CallStatisticsNotifier 重新计算统计数据
    ref.read(callStatisticsProvider.notifier).updateTimeRange(period);
  }

  @override
  Widget build(BuildContext context) {
    final stats = ref.watch(callStatisticsProvider);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final totalBlocked = stats.blockedCallsCount;
    final blockRules = stats.blockRulesCount;
    final allowRules = stats.allowRulesCount;
    final silenceRules = stats.silenceRulesCount;
    final timeRules = stats.timeRulesCount;
    final noneRules = stats.noneRulesCount;

    final int sum = blockRules + allowRules + silenceRules + timeRules + noneRules;

    // 动态规则类型分布数据建模，支持任意数量的规则类型展示
    final List<_RuleTypeShare> categories = [
      _RuleTypeShare(label: l10n.blockRules, count: blockRules, color: theme.colorScheme.error),
      _RuleTypeShare(label: l10n.allowRules, count: allowRules, color: theme.colorScheme.primary),
      _RuleTypeShare(label: l10n.silentRules, count: silenceRules, color: theme.colorScheme.tertiary),
      if (timeRules > 0)
        _RuleTypeShare(label: l10n.timeInterceptor, count: timeRules, color: theme.colorScheme.secondary),
      if (noneRules > 0)
        _RuleTypeShare(label: l10n.actionNone, count: noneRules, color: theme.colorScheme.primaryContainer),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.08),
            blurRadius: 24,
            spreadRadius: 1,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题与时间切换 (采用强类型 StatisticPeriod 枚举)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [theme.colorScheme.error, theme.colorScheme.primary]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.insights_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.statistics,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        '${l10n.blockedCalls}: $totalBlocked',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Week / Month 切换胶囊，与 CallStatisticsNotifier 同步联动
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _buildRangePill(l10n.thisWeek, StatisticPeriod.week),
                    _buildRangePill(l10n.month, StatisticPeriod.month),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 多巴胺全类型规则与统计成就横向滑块列表 (使各种 Rule 类型清晰可见)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildInsightMetric(
                  label: l10n.blockedCalls,
                  count: '$totalBlocked',
                  color: theme.colorScheme.primary,
                  icon: Icons.phone_disabled_rounded,
                ),
                const SizedBox(width: 8),
                _buildInsightMetric(
                  label: l10n.blockRules,
                  count: '$blockRules',
                  color: theme.colorScheme.error,
                  icon: Icons.shield_rounded,
                ),
                const SizedBox(width: 8),
                _buildInsightMetric(
                  label: l10n.allowRules,
                  count: '$allowRules',
                  color: theme.colorScheme.tertiary,
                  icon: Icons.check_circle_rounded,
                ),
                const SizedBox(width: 8),
                _buildInsightMetric(
                  label: l10n.silentRules,
                  count: '$silenceRules',
                  color: theme.colorScheme.secondary,
                  icon: Icons.notifications_off_rounded,
                ),
                const SizedBox(width: 8),
                _buildInsightMetric(
                  label: l10n.timeInterceptor,
                  count: '$timeRules',
                  color: theme.colorScheme.primaryContainer,
                  icon: Icons.timer_rounded,
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // 动态多类型拦截比例分布进度条（根据真实数据计算）
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.blockTypeAnalysisTitle,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    l10n.enabled,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  height: 8,
                  child: sum > 0
                      ? Row(
                          children: categories.map((cat) {
                            final pct = ((cat.count / sum) * 100).round();
                            if (pct <= 0) return const SizedBox.shrink();
                            return Expanded(
                              flex: pct,
                              child: Container(color: cat.color),
                            );
                          }).toList(),
                        )
                      : Container(
                          color: const Color(0xFFE8E5DF),
                        ),
                ),
              ),
              const SizedBox(height: 6),
              // 动态图例展示
              Wrap(
                spacing: 12,
                runSpacing: 4,
                children: categories.map((cat) {
                  final pct = sum > 0 ? ((cat.count / sum) * 100).round() : 0;
                  return _buildLegendDot('${cat.label} $pct%', cat.color);
                }).toList(),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // 底部跳转详情
          Center(
            child: TextButton.icon(
              onPressed: _navigateToStatistics,
              icon: const Icon(Icons.bar_chart_rounded, size: 15),
              label: Text(
                l10n.viewDetails,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
              ),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
                visualDensity: VisualDensity.compact,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRangePill(String label, StatisticPeriod period) {
    final isSelected = _selectedPeriod == period;
    return GestureDetector(
      onTap: () => _onPeriodChanged(period),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 3,
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
            color: isSelected ? Colors.black87 : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildInsightMetric({
    required String label,
    required String count,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: 125,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF9F5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  count,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class _RuleTypeShare {
  final String label;
  final int count;
  final Color color;

  const _RuleTypeShare({
    required this.label,
    required this.count,
    required this.color,
  });
}

// ------------------- Widget Previewer 支持 -------------------

@Preview(name: 'Stats Insight Card', group: 'Elite Showcase')
Widget previewEliteStatsInsightCard() {
  return ProviderScope(
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: EliteStatsInsightCard(),
          ),
        ),
      ),
    ),
  );
}
