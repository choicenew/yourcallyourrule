import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/call/local_call_type.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/statistic_period.dart';

class CallStatisticsService {
  bool _isIntercepted(CallLog log) => log.callType == LocalCallType.blocked || log.callType == LocalCallType.rejected || log.callType == LocalCallType.silenced;
  int getTotalBlockedCount(List<CallLog> callLogs) => callLogs.where(_isIntercepted).length;

  int getWeeklyBlockedCallsCount(List<CallLog> callLogs) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekStartTimestamp = DateTime(weekStart.year, weekStart.month, weekStart.day);
    return callLogs.where((log) => _isIntercepted(log) && log.timestamp.isAfter(weekStartTimestamp)).length;
  }

  int getWeeklyFilteredSmsCount(List<CallLog> callLogs) => 0;

  int getAllowRulesCount(List<RuleBase> rules) => rules.where((r) => r.action.type == RuleActionType.allow && r.isEnabled).length;
  int getBlockRulesCount(List<RuleBase> rules) => rules.where((r) => r.action.type == RuleActionType.block && r.isEnabled).length;
  int getSilenceRulesCount(List<RuleBase> rules) => rules.where((r) => r.action.type == RuleActionType.silence && r.isEnabled).length;
  int getNoneRulesCount(List<RuleBase> rules) => rules.where((r) => r.action.type == RuleActionType.none && r.isEnabled).length;
  int getWhitelistRulesCount(List<RuleBase> rules) => getAllowRulesCount(rules);
  int getBlacklistRulesCount(List<RuleBase> rules) => getBlockRulesCount(rules);

  Future<int> getTimeRulesCount(ConfigRepository configRepository) async {
    int count = 0;
    final configMap = await configRepository.getConfig('time_interceptor');
    if (configMap != null && configMap['shouldIntercept'] == true) count++;
    final simConfigMap = await configRepository.getConfig('sim_time_interceptor');
    if (simConfigMap != null) {
      for (var entry in simConfigMap.entries) {
        if (entry.value is Map && entry.value['shouldIntercept'] == true) count++;
      }
    }
    return count;
  }

  Map<String, double> getBlockTypeAnalysis(List<CallLog> callLogs) {
    final typeCounts = <LocalCallType, int>{};
    final interceptedLogs = callLogs.where(_isIntercepted).toList();
    final totalBlocked = interceptedLogs.length;
    if (totalBlocked == 0) return {};
    for (final log in interceptedLogs) {
      typeCounts[log.callType] = (typeCounts[log.callType] ?? 0) + 1;
    }
    return typeCounts.map((type, count) => MapEntry(type.name, (count / totalBlocked) * 100));
  }

  Map<DateTime, int> getBlockedCallsByDate(List<CallLog> callLogs, StatisticPeriod period) {
    final result = <DateTime, int>{};
    final now = DateTime.now();

    int days;
    switch (period) {
      case StatisticPeriod.month:
        days = 30;
        break;
      case StatisticPeriod.year:
        days = 365;
        break;
      case StatisticPeriod.week:
      default:
        days = 7;
        break;
    }

    final startDate = now.subtract(Duration(days: days));
    final relevantLogs = callLogs.where((log) => _isIntercepted(log) && log.timestamp.isAfter(startDate));

    for (final log in relevantLogs) {
      DateTime key;
      if (period == StatisticPeriod.year) {
        key = DateTime(log.timestamp.year, log.timestamp.month, 1);
      } else {
        key = DateTime(log.timestamp.year, log.timestamp.month, log.timestamp.day);
      }
      result[key] = (result[key] ?? 0) + 1;
    }
    return result;
  }

  /// 获取触发拦截频次最高的前 N 条规则
  List<RuleBase> getTopTriggeredRules(List<RuleBase> rules, {int limit = 3}) {
    final active = rules.where((r) => r.isEnabled).toList();
    active.sort((a, b) => b.count.compareTo(a.count));
    return active.take(limit).toList();
  }

  /// 获取卡槽（SIM 1 / SIM 2）拦截比例分布
  Map<int, int> getSimSlotDistribution(List<CallLog> callLogs) {
    final distribution = <int, int>{};
    for (final log in callLogs.where(_isIntercepted)) {
      final slot = log.simSlot ?? 0;
      distribution[slot] = (distribution[slot] ?? 0) + 1;
    }
    return distribution;
  }

  /// 分析拦截频次最高的 2 小时时间段
  String getPeakHoursRange(List<CallLog> callLogs) {
    final intercepted = callLogs.where(_isIntercepted).toList();
    if (intercepted.isEmpty) return '14:00 - 16:00';
    final hourCounts = <int, int>{};
    for (final log in intercepted) {
      final hour = log.timestamp.hour;
      hourCounts[hour] = (hourCounts[hour] ?? 0) + 1;
    }
    var peakHour = 14;
    var maxCount = 0;
    hourCounts.forEach((hour, count) {
      if (count > maxCount) {
        maxCount = count;
        peakHour = hour;
      }
    });
    final endHour = (peakHour + 2) % 24;
    return '${peakHour.toString().padLeft(2, '0')}:00 - ${endHour.toString().padLeft(2, '0')}:00';
  }
}
