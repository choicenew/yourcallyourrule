import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/phone_rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/call_statistic/data/repositories/call_statistics_repository_impl.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_service.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/statistic_period.dart';

part 'call_statistics_provider.g.dart';

class CallStatisticsState {
  final bool isLoading;
  final String? error;
  final int blockedCallsCount;
  final int filteredSmsCount;
  final int allowRulesCount;
  final int blockRulesCount;
  final int silenceRulesCount;
  final int noneRulesCount;
  final int timeRulesCount;
  final Map<String, double> blockTypeAnalysis;
  final Map<DateTime, int> chartData;
  final List<PhoneRuleEntity> topTriggeredRules;
  final Map<int, int> simSlotDistribution;
  final String peakHoursRange;

  const CallStatisticsState({
    this.isLoading = true,
    this.error,
    this.blockedCallsCount = 0,
    this.filteredSmsCount = 0,
    this.allowRulesCount = 0,
    this.blockRulesCount = 0,
    this.silenceRulesCount = 0,
    this.noneRulesCount = 0,
    this.timeRulesCount = 0,
    this.blockTypeAnalysis = const {},
    this.chartData = const {},
    this.topTriggeredRules = const [],
    this.simSlotDistribution = const {},
    this.peakHoursRange = 'N/A',
  });

  CallStatisticsState copyWith({
    bool? isLoading,
    String? error,
    int? blockedCallsCount,
    int? filteredSmsCount,
    int? allowRulesCount,
    int? blockRulesCount,
    int? silenceRulesCount,
    int? noneRulesCount,
    int? timeRulesCount,
    Map<String, double>? blockTypeAnalysis,
    Map<DateTime, int>? chartData,
    List<PhoneRuleEntity>? topTriggeredRules,
    Map<int, int>? simSlotDistribution,
    String? peakHoursRange,
  }) {
    return CallStatisticsState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      blockedCallsCount: blockedCallsCount ?? this.blockedCallsCount,
      filteredSmsCount: filteredSmsCount ?? this.filteredSmsCount,
      allowRulesCount: allowRulesCount ?? this.allowRulesCount,
      blockRulesCount: blockRulesCount ?? this.blockRulesCount,
      silenceRulesCount: silenceRulesCount ?? this.silenceRulesCount,
      noneRulesCount: noneRulesCount ?? this.noneRulesCount,
      timeRulesCount: timeRulesCount ?? this.timeRulesCount,
      blockTypeAnalysis: blockTypeAnalysis ?? this.blockTypeAnalysis,
      chartData: chartData ?? this.chartData,
      topTriggeredRules: topTriggeredRules ?? this.topTriggeredRules,
      simSlotDistribution: simSlotDistribution ?? this.simSlotDistribution,
      peakHoursRange: peakHoursRange ?? this.peakHoursRange,
    );
  }
}

@Riverpod(keepAlive: true)
class CallStatisticsNotifier extends _$CallStatisticsNotifier {
  StreamSubscription<List<CallLogEntry>>? _dataSubscription;
  StatisticPeriod _currentTimeRange = StatisticPeriod.week;

  @override
  CallStatisticsState build() {
    _listenToDataChanges();
    _initialLoad();
    return const CallStatisticsState(isLoading: true);
  }

  void _listenToDataChanges() {
    _dataSubscription?.cancel();
    final callLogService = ref.read(callLogServiceProvider);
    _dataSubscription = callLogService.logsStream.listen(
      (callLogs) async {
        await _calculateStatistics(callLogs, timeRange: _currentTimeRange);
      },
      onError: (e) { state = state.copyWith(isLoading: false, error: 'Failed to listen to data: $e'); }
    );
    ref.onDispose(() => _dataSubscription?.cancel());
  }

  Future<void> _initialLoad() async {
    final initialLogs = await ref.read(callLogServiceProvider).getRecentLogs();
    await _calculateStatistics(initialLogs, timeRange: _currentTimeRange);
  }

  Future<void> _calculateStatistics(List<CallLogEntry> callLogs, {required StatisticPeriod timeRange}) async {
    try {
      final allRules = await ref.read(ruleManagementServiceProvider).getAllRules();
      final configRepo = ref.read(configRepositoryProvider);
      final repo = CallStatisticsRepositoryImpl(callLogs, allRules);
      final statService = CallStatisticsService();

      final timeRulesCount = await repo.getTimeRulesCount(configRepo);
      final completeChartData = _generateCompleteChartData(repo, timeRange);

      final topRules = statService.getTopTriggeredRules(allRules, limit: 3);
      final simDist = statService.getSimSlotDistribution(callLogs);
      final peakHours = statService.getPeakHoursRange(callLogs);

      state = state.copyWith(
        isLoading: false,
        error: null,
        blockedCallsCount: repo.getWeeklyBlockedCallsCount(),
        filteredSmsCount: await repo.getWeeklyFilteredSmsCount(),
        allowRulesCount: repo.getAllowRulesCount(),
        blockRulesCount: repo.getBlockRulesCount(),
        silenceRulesCount: repo.getSilenceRulesCount(),
        noneRulesCount: repo.getNoneRulesCount(),
        timeRulesCount: timeRulesCount,
        blockTypeAnalysis: repo.getBlockTypeAnalysis(),
        chartData: completeChartData,
        topTriggeredRules: topRules,
        simSlotDistribution: simDist,
        peakHoursRange: peakHours,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to calculate statistics: $e');
    }
  }

  Map<DateTime, int> _generateCompleteChartData(CallStatisticsRepositoryImpl repo, StatisticPeriod period) {
    final now = DateTime.now();
    final DateTime startDate;
    int days = 7;

    switch (period) {
      case StatisticPeriod.week:
        days = 7;
        break;
      case StatisticPeriod.month:
        days = 30;
        break;
      case StatisticPeriod.year:
        days = 365;
        break;
    }
    
    startDate = now.subtract(Duration(days: days - 1));
    final rawData = repo.getBlockedCallsTrend(startDate: startDate, endDate: now);
    
    final Map<DateTime, int> completeData = {};
    for (int i = 0; i < days; i++) {
      final date = DateTime(startDate.year, startDate.month, startDate.day).add(Duration(days: i));
      completeData[date] = rawData[date] ?? 0;
    }
    return completeData;
  }

  void updateTimeRange(StatisticPeriod newPeriod) {
    if (_currentTimeRange != newPeriod) {
      _currentTimeRange = newPeriod;
      state = state.copyWith(isLoading: true);
      _initialLoad();
    }
  }
}
