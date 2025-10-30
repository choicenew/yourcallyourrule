import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math'; // 导入 math 库以使用 max 函数

/// [重构]: 这是一个纯粹的、无状态的UI组件，只负责根据传入的数据渲染图表。
class StatisticChart extends StatelessWidget {
  final bool showDetailedChart;
  final Map<DateTime, int> chartData;
    // 【新增】: 两个可选的颜色参数
  final Color? lineColor;
  final Color? gradientColor;

  const StatisticChart({
    super.key,
    this.showDetailedChart = false,
    required this.chartData,
    this.lineColor,
    this.gradientColor,
  });

  @override
  Widget build(BuildContext context) {
    final spots = _generateSpots(chartData);
    
    // [注释]: 即使所有值为0，spots 列表也不会为空，所以 isEmpty 判断可以移除。
    // 但为了防止 chartData 本身就是空 map 的边缘情况，保留它更健壮。
    if (spots.isEmpty) {
      return const SizedBox(height: 200, child: Center(child: Text("No data available")));
    }

    return showDetailedChart 
      ? _buildDetailedChart(context, spots, chartData.keys.toList()..sort()) 
      : _buildMiniChart(context, spots);
  }

  List<FlSpot> _generateSpots(Map<DateTime, int> data) {
    final sortedKeys = data.keys.toList()..sort();
    return sortedKeys.asMap().entries.map((entry) {
      final index = entry.key;
      final count = data[entry.value]!;
      return FlSpot(index.toDouble(), count.toDouble());
    }).toList();
  }

  LineChartBarData _mainLine(List<FlSpot> spots, BuildContext context) {

    // 【修改】: 优先使用传入的 `lineColor`，如果为空，则使用原来的逻辑。
    final finalLineColor = lineColor ?? 
                           (showDetailedChart ? Theme.of(context).primaryColor : Colors.white.withOpacity(0.8));

    // 【修改】: 优先使用传入的 `gradientColor`，如果为空，则使用原来的逻辑。
    final finalGradientColor = gradientColor ?? 
                                Theme.of(context).primaryColor.withOpacity(0.1);

    return LineChartBarData(
      spots: spots,
      isCurved: true,
       color: finalLineColor, // 使用最终计算出的线条颜色
      barWidth: showDetailedChart ? 3 : 2,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: showDetailedChart,
        color: finalGradientColor, // 使用最终计算出的渐变颜色
      ),
    );
  }

  Widget _buildMiniChart(BuildContext context, List<FlSpot> spots) {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [_mainLine(spots, context)],
        lineTouchData: const LineTouchData(enabled: false),
      ),
    );
  }

  Widget _buildDetailedChart(BuildContext context, List<FlSpot> spots, List<DateTime> dates) {
    // ▼▼▼▼▼ 核心修正部分 ▼▼▼▼▼
    // 1. 找到数据中的最大 Y 值。
    double maxY = spots.isEmpty ? 0 : spots.map((s) => s.y).reduce(max);
    
    // 2. [修正]: 动态计算图表的 Y 轴顶部值。
    // 如果最大值是0，我们设置一个默认的顶部值（例如5），让坐标轴可见。
    // 否则，我们将顶部值设为比最大值稍大一些，以留出空间。
    double chartTopY = (maxY == 0) ? 5 : (maxY * 1.2);

    // 3. [修正]: 动态计算 Y 轴网格线和标签的间隔。
    // 我们希望大约有 4-5 条网格线。
    // 我们取 Y 轴顶部值的 1/4，然后向上取整到一个合适的整数。
    double yInterval = (chartTopY / 4).ceilToDouble();
    // 确保间隔至少为 1，以避免在 maxY 很小时（例如1或2）间隔计算为0。
    if (yInterval < 1) {
      yInterval = 1;
    }
    // ▲▲▲▲▲ 修正结束 ▲▲▲▲▲
    
    return LineChart(
      LineChartData(
        maxY: chartTopY,
        minY: 0, // Y轴从0开始
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: yInterval, // [修正]: 使用动态计算的间隔
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          
          // Y 轴 (左侧) 标题
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: yInterval, // [修正]: 标签的间隔应该与网格线一致
              getTitlesWidget: (value, meta) {
                // [注释]: 只显示整数标签
                if (value == meta.max || value % yInterval != 0) {
                  return const SizedBox.shrink();
                }
                return SideTitleWidget(
                  meta: meta,
                  space: 4,
                  child: Text(value.toInt().toString(), style: const TextStyle(fontSize: 10)),
                );
              },
            ),
          ),
          
          // X 轴 (底部) 标题
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= dates.length) return const SizedBox.shrink();
                
                final date = dates[index];
                String text = '';

                if (dates.length <= 10) { 
                  text = DateFormat.d().format(date);
                } else if (index == 0 || index == dates.length - 1 || index % (dates.length / 5).round() == 0) { 
                   text = DateFormat.Md().format(date);
                }

                if (text.isEmpty) return const SizedBox.shrink();
                
                return SideTitleWidget(
                  meta: meta,
                  space: 4,
                  child: Text(text, style: const TextStyle(fontSize: 10)),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [_mainLine(spots, context)],
      ),
    );
  }
}