import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

/// 真实数据驱动 · 连续平滑贝塞尔波形图表组件
/// 当真实数据全为 0 / 为空时，UI 渲染一条连贯、无缝平滑的低对比度微波骨架线 (0.05~0.12 半透明)；
/// 一旦产生真实拦截点阵，自动无缝完全覆盖替换。
class StatisticChart extends StatelessWidget {
  final bool showDetailedChart;
  final Map<DateTime, int> chartData;
  final Color? lineColor;
  final Color? gradientColor;

  const StatisticChart({
    super.key,
    this.showDetailedChart = false,
    required this.chartData,
    this.lineColor,
    this.gradientColor,
  });

  bool get _hasNonZeroData {
    if (chartData.isEmpty) return false;
    return chartData.values.any((v) => v > 0);
  }

  @override
  Widget build(BuildContext context) {
    final spots = _generateSpots(chartData);

    return showDetailedChart
        ? _buildDetailedChart(context, spots, chartData.keys.toList()..sort())
        : _buildMiniChart(context, spots);
  }

  List<FlSpot> _generateSpots(Map<DateTime, int> data) {
    if (!_hasNonZeroData) {
      // 连续、连贯、流畅无折角的 7 点平滑贝塞尔微波骨架
      return const [
        FlSpot(0, 1.2),
        FlSpot(1, 2.5),
        FlSpot(2, 1.8),
        FlSpot(3, 3.2),
        FlSpot(4, 2.0),
        FlSpot(5, 2.8),
        FlSpot(6, 1.5),
      ];
    }
    final sortedKeys = data.keys.toList()..sort();
    return sortedKeys.asMap().entries.map((entry) {
      final index = entry.key;
      final count = data[entry.value]!;
      return FlSpot(index.toDouble(), count.toDouble());
    }).toList();
  }

  LineChartBarData _mainLine(List<FlSpot> spots, BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isSkeleton = !_hasNonZeroData;

    final baseLineColor = lineColor ??
        (showDetailedChart
            ? theme.colorScheme.primary
            : theme.colorScheme.onPrimaryContainer);

    final finalLineColor = isSkeleton
        ? baseLineColor.withValues(alpha: isDark ? 0.22 : 0.15)
        : baseLineColor;

    final baseGradientColor =
        gradientColor ?? theme.colorScheme.primary.withValues(alpha: 0.18);

    final finalGradientColor = isSkeleton
        ? baseGradientColor.withValues(alpha: 0.05)
        : baseGradientColor;

    return LineChartBarData(
      spots: spots,
      isCurved: true,
      curveSmoothness: 0.38, // 保证三阶贝塞尔曲线高度平滑连贯
      color: finalLineColor,
      barWidth: showDetailedChart ? 3 : 2.2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: showDetailedChart && !isSkeleton,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 3.5,
            color: theme.colorScheme.surface,
            strokeWidth: 2,
            strokeColor: finalLineColor,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            finalGradientColor,
            finalGradientColor.withValues(alpha: 0.0),
          ],
        ),
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final gridLineColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFFE2E8F0);
    final textStyle = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: theme.colorScheme.onSurfaceVariant,
    );

    double maxY = spots.isEmpty ? 0 : spots.map((s) => s.y).reduce(max);
    double chartTopY = (maxY == 0) ? 5 : (maxY * 1.2);
    double yInterval = (chartTopY / 4).ceilToDouble();
    if (yInterval < 1) yInterval = 1;

    return LineChart(
      LineChartData(
        maxY: chartTopY,
        minY: 0,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: yInterval,
          getDrawingHorizontalLine: (value) => FlLine(
            color: gridLineColor,
            strokeWidth: 1,
            dashArray: [4, 4],
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: yInterval,
              getTitlesWidget: (value, meta) {
                if (value == meta.max || value % yInterval != 0) {
                  return const SizedBox.shrink();
                }
                return SideTitleWidget(
                  meta: meta,
                  space: 4,
                  child: Text(value.toInt().toString(), style: textStyle),
                );
              },
            ),
          ),
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
                } else if (index == 0 ||
                    index == dates.length - 1 ||
                    index % (dates.length / 5).round() == 0) {
                  text = DateFormat.Md().format(date);
                }

                if (text.isEmpty) return const SizedBox.shrink();

                return SideTitleWidget(
                  meta: meta,
                  space: 4,
                  child: Text(text, style: textStyle),
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
