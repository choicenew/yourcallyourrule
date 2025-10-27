import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 【MODIFIED】: 引入了您项目中【真实存在】的、手动创建的 Provider。
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';

// 引入所有必要的模型和 Repository 实现
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/features/call_statistic/data/repositories/call_statistics_repository_impl.dart';

part 'call_statistics_provider.g.dart';

/// 通话统计的状态模型 (保持不变)
class CallStatisticsState {
  final bool isLoading;
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

/// 【响应式】的通话统计 Notifier
///
/// 【MODIFIED】: 这是一个普通的 Notifier，它通过监听 Stream 来响应式地更新状态。
@Riverpod(keepAlive: true)
class CallStatisticsNotifier extends _$CallStatisticsNotifier {
  
  StreamSubscription? _callLogsSubscription;
  String _currentTimeRange = 'week';

  @override
  CallStatisticsState build() {
    // 【核心修正】: 100% 恢复并现代化您原始的、基于 Stream.listen 的逻辑。
    _initializeListeners();
    
    // 返回初始加载状态
    return const CallStatisticsState(isLoading: true);
  }

  /// 初始化所有监听器，这精确地复制了您原始 `_loadData` 的核心逻辑。
  void _initializeListeners() {
    _callLogsSubscription?.cancel();
    
    final callLogService = ref.read(callLogServiceProvider);
    
    callLogService.initialize();
    
    // 【100% 恢复】: 监听 `logsStream` 的变化
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

  /// 核心的统计计算方法
  Future<void> _calculateStatistics(List<CallLog> callLogs, {required String timeRange}) async {
    try {
      final allRules = await ref.read(ruleManagementServiceProvider).getAllRules();

      final repo = CallStatisticsRepositoryImpl(callLogs, allRules);
      
      final now = DateTime.now();
      final chartDataPoints = List.generate(7, (index) {
        final day = now.subtract(Duration(days: index));
        final dateKey = DateTime(day.year, day.month, day.day);
        return (repo.getBlockedCallsByDate(timeRange)[dateKey] ?? 0).toDouble();
      });

      state = state.copyWith(
        isLoading: false,
        error: null,
        blockedCallsCount: repo.getWeeklyBlockedCallsCount(),
        filteredSmsCount: repo.getWeeklyFilteredSmsCount(),
        allowRulesCount: repo.getAllowRulesCount(),
        blockRulesCount: repo.getBlockRulesCount(),
        silenceRulesCount: repo.getSilenceRulesCount(),
        noneRulesCount: repo.getNoneRulesCount(),
        chartData: chartDataPoints.reversed.toList(),
        blockTypeAnalysis: repo.getBlockTypeAnalysis(),
      );

    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to calculate statistics: $e');
    }
  }

  /// 供 UI 调用的时间范围更改方法
  ///
  /// 【核心修正】: `refreshData` 被重命名为 `updateTimeRange` 以反映其真实作用，
  ///              并且不再调用不存在的方法。
  Future<void> updateTimeRange(String newTimeRange) async {
    if (_currentTimeRange == newTimeRange && !state.isLoading) return;

    _currentTimeRange = newTimeRange;
    state = state.copyWith(isLoading: true);
    
    // 手动获取一次最新的日志列表并用新的时间范围重新计算。
    // `getRecentLogs` 是您 `CallLogService` 中【真实存在】的方法。
    final callLogs = await ref.read(callLogServiceProvider).getRecentLogs();
    await _calculateStatistics(callLogs, timeRange: newTimeRange);
  }
}