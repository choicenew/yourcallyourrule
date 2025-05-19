// 保持图表逻辑，规范依赖注入
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';


class BlockedCallsChart extends StatefulWidget {
  final BlockedCallRepository repository;

  const BlockedCallsChart({super.key, required this.repository});

  @override
  BlockedCallsChartState createState() => BlockedCallsChartState();
}

class BlockedCallsChartState extends State<BlockedCallsChart> {
  List<BarChartGroupData> _weeklyData = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  BlockedType? _currentType;
  
  Future<void> _loadData() async {
    // 获取所有类型的拦截记录
    List<BlockedCall> calls;
    
    // 根据当前选择的类型加载数据
    if (_currentType == BlockedType.call) {
      calls = await widget.repository.getBlockedCallsOnly();
    } else if (_currentType == BlockedType.sms) {
      calls = await widget.repository.getBlockedSmsOnly();
    } else {
      // 全部类型
      calls = await widget.repository.getBlockedCalls();
    }
    
    final now = DateTime.now();
    final weekDates =
        List.generate(7, (index) => now.subtract(Duration(days: index)));

    setState(() {
      _weeklyData = weekDates.asMap().entries.map((entry) {
        final index = entry.key;
        final date = entry.value;
        final count = calls
            .where((call) =>
                call.timestamp.year == date.year &&
                call.timestamp.month == date.month &&
                call.timestamp.day == date.day)
            .length;

        return BarChartGroupData(
          x: index,
          barRods: [BarChartRodData(toY: count.toDouble())],
        );
      }).toList();
    });
  }

  void _changeChartType(BlockedType? type) {
    setState(() {
      _currentType = type;
    });
    _loadData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceChip(
              label: const Text('全部'),
              selected: _currentType == null,
              onSelected: (_) => _changeChartType(null),
            ),
            const SizedBox(width: 8),
            ChoiceChip(
              label: const Text('电话'),
              selected: _currentType == BlockedType.call,
              onSelected: (_) => _changeChartType(BlockedType.call),
            ),
            const SizedBox(width: 8),
            ChoiceChip(
              label: const Text('短信'),
              selected: _currentType == BlockedType.sms,
              onSelected: (_) => _changeChartType(BlockedType.sms),
            ),
          ],
        ),
        const SizedBox(height: 8),
        OrientationBuilder(
      builder: (context, orientation) {
        final mediaQuery = MediaQuery.of(context);

        // 根据屏幕方向和宽度设置 cardWidth 和 cardHeight
        final chartWidth = (orientation == Orientation.portrait
            ? (mediaQuery.size.width < 600
                ? mediaQuery.size.width * 0.95
                : mediaQuery.size.width < 1000
                    ? mediaQuery.size.width * 0.8
                    : mediaQuery.size.width * 0.6)
            : (mediaQuery.size.width < 900
                ? mediaQuery.size.width * 0.8
                : mediaQuery.size.width * 0.6));
        final chartHeight =
            chartWidth * (mediaQuery.size.width < 600 ? 0.4 : 0.3);

        return Column(
          children: [
            SizedBox(
              width: chartWidth, // 应用计算的宽度
              height: chartHeight, // 应用计算的高度
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: _weeklyData.isEmpty ? 1 : null,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          switch (value.toInt()) {
                            case 0:
                              return Text('Today');
                            case 1:
                              return Text('1d ago');
                            case 3:
                              return Text('3d ago');
                            case 6:
                              return Text('1w ago');
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: _weeklyData.reversed.toList(),
                ),
              ),
            ),
            Text('Weekly Blocked Calls Summary',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        );
      },
    ),
      ],
    );
  }
}
