import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_chart.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class TrendChartCard extends ConsumerStatefulWidget {
  const TrendChartCard({super.key});

  @override
  ConsumerState<TrendChartCard> createState() => _TrendChartCardState();
}

class _TrendChartCardState extends ConsumerState<TrendChartCard> {
  String _selectedTimeRange = 'Week';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(callStatisticsProvider);
    final notifier = ref.read(callStatisticsProvider.notifier);
    
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
          Stack(
            children: [
              SizedBox(
                height: 200,
                // [注释]: 这里调用了已修正的 StatisticChart
                child: StatisticChart(
                  showDetailedChart: true,
                  chartData: state.chartData,
                ),
              ),
              if (state.isLoading)
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

  Widget _buildTimeRangeButton(String text, String range, CallStatisticsNotifier notifier) {
    final isSelected = _selectedTimeRange == range;
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
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
}