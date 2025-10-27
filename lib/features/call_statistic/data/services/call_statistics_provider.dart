import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/features/call_statistic/data/repositories/call_statistics_repository_impl.dart';

part 'call_statistics_provider.g.dart';

/// 通话统计的状态模型 (保持不变)
class CallStatisticsState {
  final bool isLoading; // 这个 isLoading 现在只用于【初始加载】
  final String? error;
  final int blockedCallsCount;
  final int filteredSmsCount;
  final int allowRulesCount;
  final int blockRulesCount;
  final int silenceRulesCount;
  final int noneRulesCount;
  final List<double> chartData;
  final Map<String, double> blockTypeAnalysis;

  const CallStatisticsState({
    this.isLoading = true,
    this.error,
    this.blockedCallsCount = 0,
    this.filteredSmsCount = 0,
    this.allowRulesCount = 0,
    this.blockRulesCount = 0,
    this.silenceRulesCount = 0,
    this.noneRulesCount = 0,
    this.chartData = const [0, 0, 0, 0, 0, 0, 0],
    this.blockTypeAnalysis = const {},
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
    List<double>? chartData,
    Map<String, double>? blockTypeAnalysis,
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
      chartData: chartData ?? this.chartData,
      blockTypeAnalysis: blockTypeAnalysis ?? this.blockTypeAnalysis,
    );
  }
}

@Riverpod(keepAlive: true)
class CallStatisticsNotifier extends _$CallStatisticsNotifier {
  
  StreamSubscription? _callLogsSubscription;
  String _currentTimeRange = 'week';

  @override
  CallStatisticsState build() {
    _initializeListeners();
    return const CallStatisticsState(isLoading: true);
  }

  void _initializeListeners() {
    _callLogsSubscription?.cancel();
    final callLogService = ref.read(callLogServiceProvider);
    callLogService.initialize();
    _callLogsSubscription = callLogService.logsStream.listen(
      (callLogs) {
        _calculateStatistics(callLogs, timeRange: _currentTimeRange);
      },
      onError: (e) {
        state = state.copyWith(isLoading: false, error: 'Failed to listen to call logs: $e');
      }
    );
    ref.onDispose(() {
      _callLogsSubscription?.cancel();
    });
  }

  Future<void> _calculateStatistics(List<CallLog> callLogs, {required String timeRange}) async {
    try {
      final allRules = await ref.read(ruleManagementServiceProvider).getAllRules();
      final repo = CallStatisticsRepositoryImpl(callLogs, allRules);
      
      // 【核心修正】: 图表数据的计算现在也依赖于 `timeRange`
      final chartDataPoints = _generateChartData(repo, timeRange);

      // 只有在初始加载时，才需要计算所有统计数据
      if (state.isLoading) {
        state = state.copyWith(
          isLoading: false,
          error: null,
          blockedCallsCount: repo.getWeeklyBlockedCallsCount(),
          filteredSmsCount: repo.getWeeklyFilteredSmsCount(),
          allowRulesCount: repo.getAllowRulesCount(),
          blockRulesCount: repo.getBlockRulesCount(),
          silenceRulesCount: repo.getSilenceRulesCount(),
          noneRulesCount: repo.getNoneRulesCount(),
          chartData: chartDataPoints,
          blockTypeAnalysis: repo.getBlockTypeAnalysis(),
        );
      } else {
        // 如果不是初始加载（例如，只是切换时间范围），我们只更新图表数据
        state = state.copyWith(chartData: chartDataPoints);
      }

    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to calculate statistics: $e');
    }
  }

  // 辅助方法，用于生成不同时间范围的图表数据
  List<double> _generateChartData(CallStatisticsRepositoryImpl repo, String timeRange) {
      final now = DateTime.now();
      if (timeRange == 'month') {
        // 生成月度数据
        final dataPoints = List.generate(30, (index) {
            final day = now.subtract(Duration(days: index));
            final dateKey = DateTime(day.year, day.month, day.day);
            return (repo.getBlockedCallsByDate(timeRange)[dateKey] ?? 0).toDouble();
        });
        return dataPoints.reversed.toList();
      }
      // 默认生成周度数据
      final dataPoints = List.generate(7, (index) {
          final day = now.subtract(Duration(days: index));
          final dateKey = DateTime(day.year, day.month, day.day);
          return (repo.getBlockedCallsByDate(timeRange)[dateKey] ?? 0).toDouble();
      });
      return dataPoints.reversed.toList();
  }


  /// 【核心修正】: `updateTimeRange` 现在是一个【静默】操作。
  Future<void> updateTimeRange(String newTimeRange) async {
    if (_currentTimeRange == newTimeRange) return;

    _currentTimeRange = newTimeRange;
    
    // 【不再设置 isLoading: true】
    // state = state.copyWith(isLoading: true); 

    // 手动获取一次最新的日志列表，并用新的时间范围【只重新计算图表数据】
    final callLogs = await ref.read(callLogServiceProvider).getRecentLogs();
    final allRules = await ref.read(ruleManagementServiceProvider).getAllRules();
    final repo = CallStatisticsRepositoryImpl(callLogs, allRules);
    final newChartData = _generateChartData(repo, newTimeRange);
    
    // 只更新图表数据，其他统计数据保持不变，从而实现静默更新
    state = state.copyWith(chartData: newChartData);
  }
}