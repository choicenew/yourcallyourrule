import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_card.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/block_type_analysis.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/trend_chart_card.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_chart.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/top_rules_card.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/peak_hours_card.dart';

/// 智能高密度通话拦截统计容器 Widget（100% 采用系统 Theme.of(context) 主题与 i18n）
class CallStatisticsContainerWidget extends ConsumerStatefulWidget {
  const CallStatisticsContainerWidget({super.key});

  @override
  ConsumerState<CallStatisticsContainerWidget> createState() =>
      _CallStatisticsContainerWidgetState();
}

class _CallStatisticsContainerWidgetState
    extends ConsumerState<CallStatisticsContainerWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        ref.invalidate(callStatisticsProvider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(callStatisticsProvider);

    if (state.isLoading && state.chartData.isEmpty) {
      return _buildLoadingSkeleton();
    }
    
    if (state.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(state.error!),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. 顶部战报卡片
          _buildOverviewCard(context, state),
          const SizedBox(height: 14),

          // 2. 广告组件
          _buildAdPlaceholder(),
          const SizedBox(height: 14),

          // 3. 统计网格
          _buildStatsGrid(context, state),
          const SizedBox(height: 14),

          // 4. 广告组件
          const InlineAdaptiveBannerAdWidget(adInfo: AdManager.adaptiveBannerAd),
          const SizedBox(height: 14),

          // 5. 趋势分析曲线
          const TrendChartCard(),
          const SizedBox(height: 14),

          // 6. 热门触发规则排行 (数据驱动 TOP 3)
          const TopRulesCard(),
          const SizedBox(height: 14),

          // 7. 高峰骚扰时间段分析
          const PeakHoursCard(),
          const SizedBox(height: 14),

          // 8. 拦截类型分析
          const BlockTypeAnalysis(),
          const SizedBox(height: 14),

          // 9. 导出数据按钮
          _buildExportButton(context),
        ],
      ),
    );
  }
  
  /// 系统主题 Hero 战报卡片
  Widget _buildOverviewCard(BuildContext context, CallStatisticsState state) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final totalRules = state.blockRulesCount + state.allowRulesCount + state.silenceRulesCount + state.timeRulesCount;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
          width: 1.1,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.totalBlocked,
                    style: TextStyle(
                      color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${state.blockedCallsCount}',
                    style: TextStyle(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shield_rounded, color: theme.colorScheme.primary, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${l10n.enabledStatus}: $totalRules',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: StatisticChart(chartData: state.chartData),
          ),
        ],
      ),
    );
  }

  /// 统计网格（全原生 Theme 调色）
  Widget _buildStatsGrid(BuildContext context, CallStatisticsState state) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        StatisticCard(
          icon: Icons.phone_disabled_rounded,
          iconColor: theme.colorScheme.error,
          backgroundColor: theme.colorScheme.error.withValues(alpha: 0.12),
          title: '${state.blockedCallsCount}',
          subtitle: l10n.blockCalls,
          period: l10n.thisWeek,
        ),
        StatisticCard(
          icon: Icons.check_circle_outline_rounded,
          iconColor: theme.colorScheme.primary,
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
          title: '${state.allowRulesCount}',
          subtitle: l10n.allowRules,
          period: l10n.total,
        ),
        StatisticCard(
          icon: Icons.block_rounded,
          iconColor: theme.colorScheme.error,
          backgroundColor: theme.colorScheme.error.withValues(alpha: 0.12),
          title: '${state.blockRulesCount}',
          subtitle: l10n.blockRules,
          period: l10n.total,
        ),
        StatisticCard(
          icon: Icons.notifications_off_rounded,
          iconColor: theme.colorScheme.secondary,
          backgroundColor: theme.colorScheme.secondary.withValues(alpha: 0.12),
          title: '${state.silenceRulesCount}',
          subtitle: l10n.silentRules,
          period: l10n.total,
        ),
        StatisticCard(
          icon: Icons.timer_rounded,
          iconColor: theme.colorScheme.tertiary,
          backgroundColor: theme.colorScheme.tertiary.withValues(alpha: 0.12),
          title: '${state.timeRulesCount}',
          subtitle: l10n.timeInterceptor,
          period: l10n.total,
        ),
        StatisticCard(
          icon: Icons.remove_circle_outline_rounded,
          iconColor: theme.colorScheme.onSurfaceVariant,
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          title: '${state.noneRulesCount}',
          subtitle: l10n.noActionRules,
          period: l10n.total,
        ),
      ],
    );
  }

  Widget _buildAdPlaceholder() {
    return const SizedBox(
      width: double.infinity,
      child: GoogleAdWidget(adInfo: AdManager.bannerAd),
    );
  }

  Widget _buildExportButton(BuildContext context) {
    return Center(
      child: OutlinedButton.icon(
        onPressed: () {
          // 导出逻辑占位
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        icon: const Icon(Icons.file_download_outlined, size: 18),
        label: Text(
          AppLocalizations.of(context)!.exportStatisticsData,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(child: SizedBox(height: 180, width: double.infinity)),
          SizedBox(height: 16),
          Card(child: SizedBox(height: 200, width: double.infinity)),
          SizedBox(height: 16),
          Card(child: SizedBox(height: 250, width: double.infinity)),
        ],
      ),
    );
  }
}
