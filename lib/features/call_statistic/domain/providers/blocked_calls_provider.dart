import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/call/local_call_type.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';

part 'blocked_calls_provider.g.dart';

class BlockedCallsState {
  final List<CallLog> logs;
  final List<double> weeklyChartData;

  BlockedCallsState({required this.logs, required this.weeklyChartData});
}

@riverpod
class BlockedCalls extends _$BlockedCalls {
  @override
  Future<BlockedCallsState> build() {
    return _fetchData(tabIndex: 0);
  }

  Future<void> changeTab(int tabIndex) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchData(tabIndex: tabIndex));
  }

  Future<BlockedCallsState> _fetchData({required int tabIndex}) async {
    final callLogService = ref.watch(callLogServiceProvider);
    final allLogs = await callLogService.getRecentLogs();
    
    List<CallLog> filteredLogs;

    switch (tabIndex) {
      case 0:
      case 1:
        filteredLogs = allLogs.where((log) {
          return log.callType == LocalCallType.blocked ||
                 log.callType == LocalCallType.rejected ||
                 log.callType == LocalCallType.silenced;
        }).toList();
        break;
      case 2:
      default:
        filteredLogs = [];
        break;
    }
    
    filteredLogs.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    final now = DateTime.now();
    final weeklyChartData = List.generate(7, (index) {
      final day = now.subtract(Duration(days: index));
      final count = filteredLogs.where((log) =>
          log.timestamp.year == day.year &&
          log.timestamp.month == day.month &&
          log.timestamp.day == day.day
      ).length;
      return count.toDouble();
    });

    return BlockedCallsState(
      logs: filteredLogs,
      weeklyChartData: weeklyChartData.reversed.toList(),
    );
  }
}