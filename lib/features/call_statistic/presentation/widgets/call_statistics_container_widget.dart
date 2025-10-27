import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';


import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_card.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/block_type_analysis.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';

/// 通话统计的“智能容器”组件，作为 Dashboard 的一个独立标签页。
///
/// 【MODIFIED】: 这是一个 `ConsumerStatefulWidget`，因为它需要管理自己的 UI 状态（时间范围选择）。
class CallStatisticsContainerWidget extends ConsumerStatefulWidget {
  const CallStatisticsContainerWidget({super.key});

  @override
  ConsumerState<CallStatisticsContainerWidget> createState() => _CallStatisticsContainerWidgetState();
}

class _CallStatisticsContainerWidgetState extends ConsumerState<CallStatisticsContainerWidget> {
  // 【新】: 在 Widget 的 State 中管理用户选择的时间范围。
  String _selectedTimeRange = 'week';

  @override
  Widget build(BuildContext context) {
    // 1. 在 Widget 内部 `watch` 自己需要的数据
    final state = ref.watch(callStatisticsProvider);

    // 2. 处理加载和错误状态
    if (state.isLoading) {
      // 在加载时，可以显示一个带有骨架屏的布局，以保持 UI 稳定
      return _buildLoadingSkeleton();
    }
    if (state.error != null) {
      return Center(child: Padding(padding: const EdgeInsets.all(16.0), child: Text(state.error!)));
    }
    
    // 3. 构建完整的 UI
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOverviewCard(context, state),
          const SizedBox(height: 16),
                    _buildAdPlaceholder(),
        const SizedBox(height: 16),
        _buildStatsGrid(context, state),
          const SizedBox(height: 16),
          _buildAdPlaceholder(),
        const SizedBox(height: 16),
        _buildTrendChart(context, state),
        const SizedBox(height: 16),
        const BlockTypeAnalysis(),
        const SizedBox(height: 16),
        _buildExportButton(context),
      ],
      ),
    );
  }

  // --- 所有 _build* 辅助方法都从原始 DashboardPage 迁移过来，作为这个 Widget 的私有方法 ---
  Widget _buildAdPlaceholder() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: const GoogleAdWidget(adInfo: AdManager.bannerAd),
    );
  }

  Widget _buildOverviewCard(BuildContext context, CallStatisticsState state) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFFFB74D), Color(0xFFFF7043)], begin: Alignment.centerLeft, end: Alignment.centerRight), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))]),
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
                  Text(AppLocalizations.of(context)!.monthlyTotal, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14)),
                  const SizedBox(height: 4),
                  Text('${state.blockedCallsCount}', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  Text(AppLocalizations.of(context)!.blockedCommunications, style: const TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)), child: const Text('+12.5%', style: TextStyle(color: Colors.white, fontSize: 12))),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 60,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false), titlesData: const FlTitlesData(show: false), borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(spots: state.chartData.asMap().entries.map((entry) => FlSpot(entry.key.toDouble(), entry.value)).toList(), isCurved: true, color: Colors.white.withOpacity(0.8), barWidth: 2, isStrokeCapRound: true, dotData: const FlDotData(show: false), belowBarData: BarAreaData(show: true, color: Colors.white.withOpacity(0.1))),
                ],
                lineTouchData: const LineTouchData(enabled: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, CallStatisticsState state) {
    return GridView.count(
      crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      children: [
        StatisticCard(icon: Icons.phone_disabled, iconColor: Colors.blue, backgroundColor: Colors.blue.withOpacity(0.1), title: '${state.blockedCallsCount}', subtitle: AppLocalizations.of(context)!.blockCalls, period: AppLocalizations.of(context)!.thisWeek),
      //  StatisticCard(icon: Icons.sms_failed, iconColor: Colors.purple, backgroundColor: Colors.purple.withOpacity(0.1), title: '${state.filteredSmsCount}', subtitle: AppLocalizations.of(context)!.filterSMS, period: AppLocalizations.of(context)!.thisWeek),
        StatisticCard(icon: Icons.person_add, iconColor: Colors.green, backgroundColor: Colors.green.withOpacity(0.1), title: '${state.allowRulesCount}', subtitle: AppLocalizations.of(context)!.allowRules, period: AppLocalizations.of(context)!.total),
        StatisticCard(icon: Icons.person_remove, iconColor: Colors.red, backgroundColor: Colors.red.withOpacity(0.1), title: '${state.blockRulesCount}', subtitle: AppLocalizations.of(context)!.blockRules, period: AppLocalizations.of(context)!.total),
        StatisticCard(icon: Icons.volume_off, iconColor: Colors.orange, backgroundColor: Colors.orange.withOpacity(0.1), title: '${state.silenceRulesCount}', subtitle: AppLocalizations.of(context)!.silentRules, period: AppLocalizations.of(context)!.total),
        StatisticCard(icon: Icons.do_not_disturb_alt, iconColor: Colors.grey, backgroundColor: Colors.grey.withOpacity(0.1), title: '${state.noneRulesCount}', subtitle: AppLocalizations.of(context)!.noActionRules, period: AppLocalizations.of(context)!.total),
      ],
    );
  }

  // =======================================================================
  // 【核心修正】: `_buildTrendChart` 现在正确地包含了交互逻辑。
  // =======================================================================
  Widget _buildTrendChart(BuildContext context, CallStatisticsState state) {
    final notifier = ref.read(callStatisticsProvider.notifier);
    return Container(
      margin: const EdgeInsets.only(bottom: 16), padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.blockingTrend, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  _buildTimeRangeButton(AppLocalizations.of(context)!.week, 'week', notifier),
                  _buildTimeRangeButton(AppLocalizations.of(context)!.month, 'month', notifier),
                  _buildTimeRangeButton(AppLocalizations.of(context)!.year, 'year', notifier),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                lineBarsData: [LineChartBarData(spots: state.chartData.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(), isCurved: true, color: Theme.of(context).primaryColor, barWidth: 3, dotData: const FlDotData(show: false), belowBarData: BarAreaData(show: true, color: Theme.of(context).primaryColor.withOpacity(0.1)))],
                gridData: const FlGridData(show: false), titlesData: const FlTitlesData(show: false), borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 【核心修正】: `_buildTimeRangeButton` 现在是 `StatefulWidget` 的一部分，可以调用 `setState`。
  Widget _buildTimeRangeButton(String text, String range, CallStatisticsNotifier notifier) {
    final isSelected = _selectedTimeRange == range;
    return GestureDetector(
      onTap: () {
        // 1. 更新本地 UI 状态，让按钮立即响应
        setState(() => _selectedTimeRange = range);
        // 2. 调用 Notifier 去获取并计算新时间范围的数据
        notifier.updateTimeRange(range);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent, borderRadius: BorderRadius.circular(20)),
        child: Text(text, style: TextStyle(fontSize: 12, color: isSelected ? Theme.of(context).primaryColor : Colors.grey, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      ),
    );
  }
  
  Widget _buildExportButton(BuildContext context) => Center(child: ElevatedButton.icon(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.statisticsExportFeatureComingSoon))), icon: const Icon(Icons.file_download), label: Text(AppLocalizations.of(context)!.exportStatisticsData), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB74D), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), elevation: 5)));

  /// 构建加载状态的骨架屏
  Widget _buildLoadingSkeleton() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          // 模拟 OverviewCard
          Card(child: SizedBox(height: 180)),
          SizedBox(height: 16),
          // 模拟 StatsGrid
          Card(child: SizedBox(height: 200)),
          SizedBox(height: 16),
          // 模拟 TrendChart
          Card(child: SizedBox(height: 250)),
        ],
      ),
    );
  }
}