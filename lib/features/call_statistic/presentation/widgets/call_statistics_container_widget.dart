import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';

import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_card.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/block_type_analysis.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';

class CallStatisticsContainerWidget extends ConsumerStatefulWidget {
  const CallStatisticsContainerWidget({super.key});

  @override
  ConsumerState<CallStatisticsContainerWidget> createState() => _CallStatisticsContainerWidgetState();
}

class _CallStatisticsContainerWidgetState extends ConsumerState<CallStatisticsContainerWidget> {
  String _selectedTimeRange = 'Week';

  @override
  Widget build(BuildContext context) {
    // [修正]: ref.watch 现在直接返回 CallStatisticsState 对象。
    final state = ref.watch(callStatisticsProvider);

    // [修正]: 只在初始加载时（即 chartData 为空）显示骨架屏。
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

    // [注释]: 正常构建 UI。
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
          _buildTrendChart(context, state), // 将 state 传递下去
          const SizedBox(height: 16),
          const BlockTypeAnalysis(), // BlockTypeAnalysis 内部会自己 watch provider
          const SizedBox(height: 16),
          _buildExportButton(context),
        ],
      ),
    );
  }

  Widget _buildTrendChart(BuildContext context, CallStatisticsState state) {
    // [注释]: 获取 notifier 实例以供按钮使用。
    final notifier = ref.read(callStatisticsProvider.notifier);

    final sortedKeys = state.chartData.keys.toList()..sort();
    final trendChartSpots = sortedKeys.asMap().entries.map((entry) {
      final index = entry.key;
      final count = state.chartData[entry.value]!;
      return FlSpot(index.toDouble(), count.toDouble());
    }).toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.blockingTrend,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  _buildTimeRangeButton(AppLocalizations.of(context)!.periodWeek, 'Week', notifier),
                  _buildTimeRangeButton(AppLocalizations.of(context)!.periodMonth, 'Month', notifier),
                  _buildTimeRangeButton(AppLocalizations.of(context)!.periodYear, 'Year', notifier),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // [修正]: 使用 Stack 在图表上层叠一个加载指示器，而不是替换整个图表。
          Stack(
            children: [
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: trendChartSpots, isCurved: true, color: Theme.of(context).primaryColor, barWidth: 3,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(show: true, color: Theme.of(context).primaryColor.withOpacity(0.1)),
                      ),
                    ],
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
              // [修正]: 当 state.isLoading 为 true (仅在更新时) 并且 chartData 不为空时，显示覆盖层。
              if (state.isLoading && state.chartData.isNotEmpty)
                Positioned.fill(
                  child: Container(
                    color: Colors.white.withOpacity(0.5),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // [注释]: _buildTimeRangeButton 的签名现在接收 CallStatistics notifier
  Widget _buildTimeRangeButton(String text, String range, CallStatisticsNotifier notifier) {
    final isSelected = _selectedTimeRange == range;
    return GestureDetector(
      onTap: () {
        if (_selectedTimeRange != range) {
          setState(() => _selectedTimeRange = range);
          notifier.updateTimeRange(range);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
  
  // [注释]: 其他所有 _build* 辅助方法都保持原样，无需修改。
  // ... _buildOverviewCard, _buildStatsGrid, etc. ...
  Widget _buildOverviewCard(BuildContext context, CallStatisticsState state) {
    final sortedKeys = state.chartData.keys.toList()..sort();
    final miniChartSpots = sortedKeys.asMap().entries.map((entry) {
      final index = entry.key;
      final date = entry.value;
      final count = state.chartData[date]!;
      return FlSpot(index.toDouble(), count.toDouble());
    }).toList();

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
          SizedBox(
            height: 60,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: miniChartSpots,
                    isCurved: true,
                    color: Colors.white.withOpacity(0.8),
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
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

  Widget _buildAdPlaceholder() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: const GoogleAdWidget(adInfo: AdManager.bannerAd),
    );
  }

  Widget _buildExportButton(BuildContext context) => Center(
    child: ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.file_download),
      label: Text(AppLocalizations.of(context)!.exportStatisticsData),
    ),
  );

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