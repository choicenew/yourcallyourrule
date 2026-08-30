import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_card.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/block_type_analysis.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
// [注释]: 导入我们新创建的独立卡片
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/trend_chart_card.dart';
// [注释]: 导入改造后的纯UI图表
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_chart.dart';

/// [重构]: 这是一个 "智能容器" Widget，负责组装所有统计相关的卡片。
/// 它现在是一个 ConsumerWidget，因为它不再需要管理任何本地状态（如 _selectedTimeRange）。
class CallStatisticsContainerWidget extends ConsumerWidget {
  const CallStatisticsContainerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [注释]: 监听 callStatisticsProvider 的状态。
    // 因为 Provider 是同步的 Notifier，所以 ref.watch 直接返回 CallStatisticsState 对象。
    final state = ref.watch(callStatisticsProvider);

    // [注释]: 只在初始加载时（即 chartData 为空）显示骨架屏。
    // 这是为了避免在切换时间范围等操作时整个页面闪烁。
    if (state.isLoading && state.chartData.isEmpty) {
      return _buildLoadingSkeleton();
    }
    
    // [注释]: 如果发生错误，则显示错误信息。
    if (state.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(state.error!),
        ),
      );
    }

    // [注释]: 当数据加载成功后，构建完整的 UI。
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // [注释]: 将 state 对象传递给各个构建方法。
          _buildOverviewCard(context, state),
          const SizedBox(height: 16),
          _buildAdPlaceholder(),
          const SizedBox(height: 16),
          _buildStatsGrid(context, state),
          const SizedBox(height: 16),
          _buildAdPlaceholder(),
          const SizedBox(height: 16),
          // [修正]: 直接使用独立的、自包含的 TrendChartCard。
          // 它自己会处理时间范围选择和局部加载状态。
          const TrendChartCard(),
          const SizedBox(height: 16),
          // [注释]: BlockTypeAnalysis 也是一个自包含的 ConsumerWidget。
          const BlockTypeAnalysis(),
            const SizedBox(height: 16),
              const InlineAdaptiveBannerAdWidget(adInfo: AdManager.adaptiveBannerAd),
          const SizedBox(height: 16),
          _buildExportButton(context),

        ],
      ),
    );
  }
  
  /// [注释]: 构建总览卡片的辅助方法。
  Widget _buildOverviewCard(BuildContext context, CallStatisticsState state) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFB74D), Color(0xFFFF7043)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
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
                    AppLocalizations.of(context)!.totalBlocked,
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${state.blockedCallsCount}',
                    style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // [修正]: 使用改造后的 StatisticChart 作为迷你图表，只传递需要的数据。
          SizedBox(
            height: 60,
            child: StatisticChart(chartData: state.chartData),
          ),
        ],
      ),
    );
  }

  /// [注释]: 构建统计数据网格的辅助方法。
  Widget _buildStatsGrid(BuildContext context, CallStatisticsState state) {
     return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        StatisticCard(
          icon: Icons.phone_disabled_rounded,
          iconColor: const Color(0xFFFF9500),
          backgroundColor: const Color(0xFFFF9500).withValues(alpha: 0.12),
          title: '${state.blockedCallsCount}',
          subtitle: AppLocalizations.of(context)!.blockCalls,
          period: AppLocalizations.of(context)!.thisWeek,
        ),
        StatisticCard(
          icon: Icons.check_circle_outline_rounded,
          iconColor: const Color(0xFF34C759),
          backgroundColor: const Color(0xFF34C759).withValues(alpha: 0.12),
          title: '${state.allowRulesCount}',
          subtitle: AppLocalizations.of(context)!.allowRules,
          period: AppLocalizations.of(context)!.total,
        ),
        StatisticCard(
          icon: Icons.block_rounded,
          iconColor: const Color(0xFFFF4B4B),
          backgroundColor: const Color(0xFFFF4B4B).withValues(alpha: 0.12),
          title: '${state.blockRulesCount}',
          subtitle: AppLocalizations.of(context)!.blockRules,
          period: AppLocalizations.of(context)!.total,
        ),
        StatisticCard(
          icon: Icons.notifications_off_rounded,
          iconColor: const Color(0xFFFFB300),
          backgroundColor: const Color(0xFFFFB300).withValues(alpha: 0.12),
          title: '${state.silenceRulesCount}',
          subtitle: AppLocalizations.of(context)!.silentRules,
          period: AppLocalizations.of(context)!.total,
        ),
        StatisticCard(
          icon: Icons.remove_circle_outline_rounded,
          iconColor: const Color(0xFF8E8E93),
          backgroundColor: const Color(0xFF8E8E93).withValues(alpha: 0.12),
          title: '${state.noneRulesCount}',
          subtitle: AppLocalizations.of(context)!.noActionRules,
          period: AppLocalizations.of(context)!.total,
        ),
      ],
    );
  }

  /// [注释]: 构建广告占位的辅助方法。
  Widget _buildAdPlaceholder() {
    return const SizedBox(
      width: double.infinity,
      child: GoogleAdWidget(adInfo: AdManager.bannerAd),
    );
  }

  /// [注释]: 构建导出按钮的辅助方法。
  Widget _buildExportButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          // [注释]: 导出逻辑将在这里实现。
        },
        icon: const Icon(Icons.file_download),
        label: Text(AppLocalizations.of(context)!.exportStatisticsData),
      ),
    );
  }

  /// [注释]: 构建初始加载时显示的骨架屏。
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