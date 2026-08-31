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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.blockingTrend,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
              ),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F5F0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTimeRangeButton(AppLocalizations.of(context)!.periodWeek, 'Week', notifier),
                    _buildTimeRangeButton(AppLocalizations.of(context)!.periodMonth, 'Month', notifier),
                    _buildTimeRangeButton(AppLocalizations.of(context)!.periodYear, 'Year', notifier),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Stack(
            children: [
              SizedBox(
                height: 200,
                child: StatisticChart(
                  showDetailedChart: true,
                  chartData: state.chartData,
                ),
              ),
              if (state.isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.white.withValues(alpha: 0.6),
                    child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF9500) : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFFFF9500).withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}