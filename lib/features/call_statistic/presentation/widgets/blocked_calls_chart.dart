import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class BlockedCallsChart extends StatelessWidget {
  final List<double> weeklyData;

  const BlockedCallsChart({super.key, required this.weeklyData});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final barGroups = weeklyData.asMap().entries.map((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value,
            color: Theme.of(context).primaryColor,
            width: 16,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          )
        ],
      );
    }).toList();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: (weeklyData.isEmpty || weeklyData.reduce((a, b) => a > b ? a : b) < 5) ? 5 : null,
        barTouchData: BarTouchData(enabled: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              switch (value.toInt()) {
                case 0: return Text(localizations.chartOneWeekAgo.substring(0, 1));
                case 3: return Text(localizations.chartThreeDaysAgo);
                case 6: return Text(localizations.chartToday);
                default: return const Text('');
              }
            },
            reservedSize: 30,
          )),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        barGroups: barGroups,
      ),
    );
  }
}