// -----------------------------------------------------------------------------
// 文件: elite_stats_insight_card.dart
// 描述: Elite 拦截成就与数据战报卡片，展示已防护通话统计与类型分布。
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// ------------------- Widget 定义 -------------------

class EliteStatsInsightCard extends ConsumerStatefulWidget {
  const EliteStatsInsightCard({super.key});

  @override
  ConsumerState<EliteStatsInsightCard> createState() => _EliteStatsInsightCardState();
}

class _EliteStatsInsightCardState extends ConsumerState<EliteStatsInsightCard> {
  String _selectedRange = 'Week';

  void _navigateToStatistics() {
    context.pushNamed(AppRouter.callStatistics);
  }

  @override
  Widget build(BuildContext context) {
    final stats = ref.watch(callStatisticsProvider);
    final l10n = AppLocalizations.of(context)!;

    final totalBlocked = stats.blockedCallsCount;
    final totalRules = stats.blockRulesCount + stats.allowRulesCount + stats.silenceRulesCount;
    final blockRules = stats.blockRulesCount;
    final allowRules = stats.allowRulesCount;
    final silenceRules = stats.silenceRulesCount;

    final int sum = blockRules + allowRules + silenceRules;
    final int blockedPct = sum > 0 ? ((blockRules / sum) * 100).round() : (totalBlocked > 0 ? 100 : 0);
    final int allowPct = sum > 0 ? ((allowRules / sum) * 100).round() : 0;
    final int silencePct = sum > 0 ? (100 - blockedPct - allowPct).clamp(0, 100) : 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: EliteDopamineTheme.sunsetTangerine.withValues(alpha: 0.08),
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
          // 标题与时间切换
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      gradient: EliteDopamineTheme.coralSunsetGradient,
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
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '${l10n.blockedCalls}: $totalBlocked',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: EliteDopamineTheme.sunsetTangerine,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Week / Month 切换胶囊
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EDE6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _buildRangePill(l10n.thisWeek, 'Week'),
                    _buildRangePill(l10n.month, 'Month'),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // 多巴胺真实统计成就指标
          Row(
            children: [
              Expanded(
                child: _buildInsightMetric(
                  label: l10n.blockedCalls,
                  count: '$totalBlocked',
                  color: EliteDopamineTheme.sunsetTangerine,
                  icon: Icons.phone_disabled_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildInsightMetric(
                  label: l10n.phoneRuleManagement,
                  count: '$totalRules',
                  color: EliteDopamineTheme.freshMint,
                  icon: Icons.rule_folder_rounded,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 拦截类型分布多巴胺进度条（根据真实数据计算）
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
                          children: [
                            if (blockedPct > 0)
                              Expanded(
                                flex: blockedPct,
                                child: Container(color: EliteDopamineTheme.vibrantCoral),
                              ),
                            if (blockedPct > 0 && (allowPct > 0 || silencePct > 0)) const SizedBox(width: 2),
                            if (allowPct > 0)
                              Expanded(
                                flex: allowPct,
                                child: Container(color: EliteDopamineTheme.sunsetTangerine),
                              ),
                            if (allowPct > 0 && silencePct > 0) const SizedBox(width: 2),
                            if (silencePct > 0)
                              Expanded(
                                flex: silencePct,
                                child: Container(color: EliteDopamineTheme.freshMint),
                              ),
                          ],
                        )
                      : Container(
                          color: const Color(0xFFE8E5DF),
                        ),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLegendDot('${l10n.blockRules} $blockedPct%', EliteDopamineTheme.vibrantCoral),
                  _buildLegendDot('${l10n.allowRules} $allowPct%', EliteDopamineTheme.sunsetTangerine),
                  _buildLegendDot('${l10n.silentRules} $silencePct%', EliteDopamineTheme.freshMint),
                ],
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
                foregroundColor: EliteDopamineTheme.sunsetTangerine,
                visualDensity: VisualDensity.compact,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRangePill(String label, String key) {
    final isSelected = _selectedRange == key;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRange = key;
        });
      },
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
                    fontSize: 16,
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

// ------------------- Widget Previewer 支持 -------------------

@Preview(name: 'Stats Insight Card', group: 'Elite Showcase')
Widget previewEliteStatsInsightCard() {
  return const ProviderScope(
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        backgroundColor: EliteDopamineTheme.warmCanvasBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: EliteStatsInsightCard(),
          ),
        ),
      ),
    ),
  );
}
