import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

class StatisticChart extends ConsumerWidget {
  final bool showDetailedChart;
  // 【恢复】 period 参数，它将决定图表的标签显示
  final String period;

  const StatisticChart({
    super.key,
    this.showDetailedChart = false,
    required this.period,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 从唯一的 Notifier 获取 chartData
    final chartDataMap = ref.watch(callStatisticsProvider).chartData;

    // 将 Map<DateTime, int> 转换为 List<FlSpot>
    final spots = _generateSpots(chartDataMap);
    
    if (spots.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.noData));
    }

    return showDetailedChart 
      ? _buildDetailedChart(context, spots, chartDataMap.keys.toList()..sort()) 
      : _buildMiniChart(spots);
  }

  // 【修复】这个方法现在可以正确处理 Map
  List<FlSpot> _generateSpots(Map<DateTime, int> data) {
    if (data.isEmpty) return [];
    
    final sortedKeys = data.keys.toList()..sort();
    return sortedKeys.asMap().entries.map((entry) {
      final index = entry.key;
      final date = entry.value;
      final count = data[date]!;
      return FlSpot(index.toDouble(), count.toDouble());
    }).toList();
  }

  LineChartBarData _mainLine(List<FlSpot> spots) {
    return LineChartBarData(
      spots: spots, isCurved: true,
      color: showDetailedChart ? const Color(0xFFFFB74D) : Colors.white.withOpacity(0.8),
      barWidth: showDetailedChart ? 3 : 2,
      isStrokeCapRound: true, dotData: FlDotData(show: showDetailedChart),
      belowBarData: BarAreaData(show: true, color: const Color(0xFFFFB74D).withOpacity(0.1)),
    );
  }

  Widget _buildMiniChart(List<FlSpot> spots) {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [_mainLine(spots)],
        lineTouchData: const LineTouchData(enabled: false),
      ),
    );
  }

  Widget _buildDetailedChart(BuildContext context, List<FlSpot> spots, List<DateTime> dates) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 1),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(sideTitles: SideTitles(
            showTitles: true, reservedSize: 30,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index >= 0 && index < dates.length) {
                // 根据 period 显示不同的标签
                 if (period.toLowerCase() == 'year') {
                    if (index == 0 || index == dates.length -1 || index == (dates.length / 2).floor()) {
                       return Text('${dates[index].month}');
                    }
                 } else { // week or month
                    if (index == 0 || index == dates.length -1 || index == (dates.length / 2).floor()) {
                       return Text('${dates[index].day}');
                    }
                 }
              }
              return const Text('');
            },
          )),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [_mainLine(spots)],
      ),
    );
  }
}