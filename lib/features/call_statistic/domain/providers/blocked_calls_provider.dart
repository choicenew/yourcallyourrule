import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_service.dart';

part 'blocked_calls_provider.g.dart';

class BlockedCallsState {
  final List<CallLogEntry> logs;
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
    
    List<CallLogEntry> filteredLogs;

    switch (tabIndex) {
      case 0:
      case 1:
        filteredLogs = allLogs.where((log) {
          return log.callType == 'blocked' ||
                 log.callType == 'rejected' ||
                 log.callType == 'silenced';
        }).toList();
        break;
      case 2:
      default:
        filteredLogs = [];
        break;
    }
    
    filteredLogs.sort((a, b) => (b.timestamp ?? 0).compareTo(a.timestamp ?? 0));

    final now = DateTime.now();
    final weeklyChartData = List.generate(7, (index) {
      final day = now.subtract(Duration(days: index));
      final count = filteredLogs.where((log) {
        final logDateTime = DateTime.fromMillisecondsSinceEpoch(log.timestamp ?? 0);
        return logDateTime.year == day.year &&
            logDateTime.month == day.month &&
            logDateTime.day == day.day;
      }).length;
      return count.toDouble();
    });

    return BlockedCallsState(
      logs: filteredLogs,
      weeklyChartData: weeklyChartData.reversed.toList(),
    );
  }
}
