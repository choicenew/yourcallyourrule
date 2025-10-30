import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/features/call_statistic/data/repositories/call_statistics_repository_impl.dart';

part 'call_statistics_provider.g.dart';

// [注释]: 状态类保持不变。
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

  const CallStatisticsState({
    this.isLoading = true, this.error, this.blockedCallsCount = 0, this.filteredSmsCount = 0,
    this.allowRulesCount = 0, this.blockRulesCount = 0, this.silenceRulesCount = 0,
    this.noneRulesCount = 0, this.timeRulesCount = 0,
    this.blockTypeAnalysis = const {}, this.chartData = const {},
  });

  CallStatisticsState copyWith({
    bool? isLoading, String? error, int? blockedCallsCount, int? filteredSmsCount,
    int? allowRulesCount, int? blockRulesCount, int? silenceRulesCount, int? noneRulesCount,
    int? timeRulesCount, Map<String, double>? blockTypeAnalysis, Map<DateTime, int>? chartData,
  }) {
    return CallStatisticsState(
      isLoading: isLoading ?? this.isLoading, error: error, blockedCallsCount: blockedCallsCount ?? this.blockedCallsCount,
      filteredSmsCount: filteredSmsCount ?? this.filteredSmsCount, allowRulesCount: allowRulesCount ?? this.allowRulesCount,
      blockRulesCount: blockRulesCount ?? this.blockRulesCount, silenceRulesCount: silenceRulesCount ?? this.silenceRulesCount,
      noneRulesCount: noneRulesCount ?? this.noneRulesCount, timeRulesCount: timeRulesCount ?? this.timeRulesCount,
      blockTypeAnalysis: blockTypeAnalysis ?? this.blockTypeAnalysis, chartData: chartData ?? this.chartData,
    );
  }
}

@Riverpod(keepAlive: true)
class CallStatisticsNotifier extends _$CallStatisticsNotifier {
  
  StreamSubscription? _dataSubscription;
  String _currentTimeRange = 'Week';

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

  // ▼▼▼▼▼ 核心增量修改部分 ▼▼▼▼▼
  Future<void> _calculateStatistics(List<CallLog> callLogs, {required String timeRange}) async {
    try {
      final allRules = await ref.read(ruleManagementServiceProvider).getAllRules();
      final configRepo = ref.read(configRepositoryProvider);
      final repo = CallStatisticsRepositoryImpl(callLogs, allRules);
      
      final timeRulesCount = await repo.getTimeRulesCount(configRepo);
      
      // [修正]: 调用新的辅助方法来获取填充了0的、完整的时间序列数据。
      final completeChartData = _generateCompleteChartData(repo, timeRange);
      
      state = state.copyWith(
        isLoading: false,
        error: null,
        blockedCallsCount: repo.getWeeklyBlockedCallsCount(),
        filteredSmsCount: repo.getWeeklyFilteredSmsCount(),
        allowRulesCount: repo.getAllowRulesCount(),
        blockRulesCount: repo.getBlockRulesCount(),
        silenceRulesCount: repo.getSilenceRulesCount(),
        noneRulesCount: repo.getNoneRulesCount(),
        timeRulesCount: timeRulesCount,
        blockTypeAnalysis: repo.getBlockTypeAnalysis(),
        chartData: completeChartData, // [修正]: 使用填充后的数据
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to calculate statistics: $e');
    }
  }

  /// [新增]: 辅助方法，用于生成完整的、填充了0的图表数据。
  Map<DateTime, int> _generateCompleteChartData(CallStatisticsRepositoryImpl repo, String timeRange) {
    final now = DateTime.now();
    final Map<DateTime, int> completeData = {};
    
    // 1. 从仓库获取原始的、可能不连续的数据。
    final rawData = repo.getBlockedCallsByDate(timeRange);

    if (timeRange.toLowerCase() == 'year') {
      // 对于年份，我们按月生成序列
      for (int i = 11; i >= 0; i--) {
        final monthDate = DateTime(now.year, now.month - i, 1);
        int monthlyTotal = 0;
        rawData.forEach((date, count) {
          if (date.year == monthDate.year && date.month == monthDate.month) {
            monthlyTotal += count;
          }
        });
        completeData[monthDate] = monthlyTotal;
      }
      return completeData;
    }

    // 对于周和月，按天生成序列
    int daysToGenerate = (timeRange.toLowerCase() == 'month') ? 30 : 7;
    for (int i = daysToGenerate - 1; i >= 0; i--) {
      final date = DateTime(now.year, now.month, now.day - i);
      final dateKey = DateTime(date.year, date.month, date.day);
      completeData[dateKey] = rawData[dateKey] ?? 0;
    }
    
    return completeData;
  }
  // ▲▲▲▲▲ 增量修改结束 ▲▲▲▲▲

  Future<void> updateTimeRange(String newTimeRange) async {
    if (_currentTimeRange == newTimeRange) return;
    _currentTimeRange = newTimeRange;
    
    state = state.copyWith(isLoading: true);
    
    final callLogs = await ref.read(callLogServiceProvider).getRecentLogs();
    await _calculateStatistics(callLogs, timeRange: newTimeRange);
  }
}