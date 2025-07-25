import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class StatisticChart extends StatefulWidget {
  final BlockedCallRepository repository;
  final bool showDetailedChart;
  final String period;

  const StatisticChart({
    super.key,
    required this.repository,
    this.showDetailedChart = false,
    this.period = '',
  });

  @override
  StatisticChartState createState() => StatisticChartState();
}

class StatisticChartState extends State<StatisticChart> {
  List<FlSpot> _chartData = [];
  List<String> _chartLabels = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  String get _currentPeriod {
    if (widget.period.isEmpty) {
      return AppLocalizations.of(context)!.defaultPeriod;
    }
    return widget.period;
  }

  @override
  void didUpdateWidget(StatisticChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldPeriod = oldWidget.period.isEmpty ? AppLocalizations.of(context)!.defaultPeriod : oldWidget.period;
    final currentPeriod = _currentPeriod;
    if (oldPeriod != currentPeriod) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    final calls = await widget.repository.getBlockedCalls();
    final now = DateTime.now();
    
    // 根据选择的周期生成数据
    if (_currentPeriod == AppLocalizations.of(context)!.periodWeek) {
      _generateWeeklyData(calls, now);
    } else if (_currentPeriod == AppLocalizations.of(context)!.periodMonth) {
      _generateMonthlyData(calls, now);
    } else {
      _generateYearlyData(calls, now);
    }
  }

  void _generateWeeklyData(List<BlockedCall> calls, DateTime now) {
    final weekDates = List.generate(7, (index) => now.subtract(Duration(days: index)));
    final data = <FlSpot>[];
    final labels = <String>[];

    for (int i = 6; i >= 0; i--) {
      final date = weekDates[i];
      final count = calls
          .where((call) =>
              call.timestamp.year == date.year &&
              call.timestamp.month == date.month &&
              call.timestamp.day == date.day)
          .length;

      data.add(FlSpot((6 - i).toDouble(), count.toDouble()));
      
      // 生成标签
      if (i == 6) {
        labels.add(AppLocalizations.of(context)!.chartToday);
      } else if (i == 5) {
        labels.add(AppLocalizations.of(context)!.chartOneDayAgo);
      } else if (i == 3) {
        labels.add(AppLocalizations.of(context)!.chartThreeDaysAgo);
      } else if (i == 0) {
        labels.add(AppLocalizations.of(context)!.chartOneWeekAgo);
      } else {
        labels.add('');
      }
    }

    setState(() {
      _chartData = data;
      _chartLabels = labels;
    });
  }

  void _generateMonthlyData(List<BlockedCall> calls, DateTime now) {
    final data = <FlSpot>[];
    final labels = <String>[];
    
    // 生成最近30天的数据，每3天一个点
    for (int i = 0; i < 10; i++) {
      final startDate = now.subtract(Duration(days: i * 3));
      final endDate = now.subtract(Duration(days: i * 3 + 2));
      
      int count = 0;
      for (final call in calls) {
        if (call.timestamp.isAfter(endDate) && 
            call.timestamp.isBefore(startDate.add(const Duration(days: 1)))) {
          count++;
        }
      }
      
      data.add(FlSpot((9 - i).toDouble(), count.toDouble()));
      
      // 生成标签
      if (i == 0) {
        labels.add(AppLocalizations.of(context)!.chartToday);
      } else if (i == 3) {
        labels.add(AppLocalizations.of(context)!.chartTenDaysAgo);
      } else if (i == 9) {
        labels.add(AppLocalizations.of(context)!.chartOneMonthAgo);
      } else {
        labels.add('');
      }
    }

    setState(() {
      _chartData = data;
      _chartLabels = labels;
    });
  }

  void _generateYearlyData(List<BlockedCall> calls, DateTime now) {
    final data = <FlSpot>[];
    final labels = <String>[];
    
    // 生成最近12个月的数据
    for (int i = 0; i < 12; i++) {
      final month = now.month - i > 0 ? now.month - i : now.month - i + 12;
      final year = now.month - i > 0 ? now.year : now.year - 1;
      
      int count = 0;
      for (final call in calls) {
        if (call.timestamp.year == year && call.timestamp.month == month) {
          count++;
        }
      }
      
      data.add(FlSpot((11 - i).toDouble(), count.toDouble()));
      
      // 生成标签
      if (i == 0 || i == 3 || i == 6 || i == 11) {
        labels.add(AppLocalizations.of(context)!.chartMonthFormat(month));
      } else {
        labels.add('');
      }
    }

    setState(() {
      _chartData = data;
      _chartLabels = labels;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 如果没有数据，显示空图表
    if (_chartData.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return widget.showDetailedChart 
          ? _buildDetailedChart(constraints.maxWidth) 
          : _buildMiniChart();
      },
    );
  }

  Widget _buildMiniChart() {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: _chartData,
            isCurved: true,
            color: Colors.white.withValues(alpha:0.8),
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        lineTouchData: const LineTouchData(enabled: false),
      ),
    );
  }

  Widget _buildDetailedChart(double maxWidth) {
    // 根据可用宽度确定要显示的标签数量
    final bool isSmallScreen = maxWidth < 350;
    
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withValues(alpha:0.1),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < _chartLabels.length) {
                  // 在小屏幕上只显示部分标签
                  final String label = _chartLabels[value.toInt()];
                  if (isSmallScreen && label.isEmpty) {
                    return const SizedBox();
                  }
                  
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 10 : 12, 
                        color: Colors.grey
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: _chartData,
            isCurved: true,
            color: const Color(0xFFFFB74D),
            barWidth: isSmallScreen ? 2 : 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: !isSmallScreen),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFFFFB74D).withValues(alpha:0.1),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 8,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                return LineTooltipItem(
                  '${barSpot.y.toInt()}',
                  const TextStyle(color: Color(0xFFFFB74D), fontWeight: FontWeight.bold),
                );
              }).toList();
            },
          ),
          // 在小屏幕上减少触摸区域大小
          touchSpotThreshold: isSmallScreen ? 15 : 10,
        ),
      ),
    );
  }
}