import 'package:yourcallyourrule/features/call_history/entities/call_log.dart';
import 'package:yourcallyourrule/features/call_history/entities/local_call_type.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/statistic_period.dart';

/// 通话统计服务类
class CallStatisticsService {
  bool _isIntercepted(CallLog log) =>
      log.localCallType == LocalCallType.blocked ||
      log.localCallType == LocalCallType.rejected ||
      log.localCallType == LocalCallType.silenced;

  int getTotalBlockedCount(List<CallLog> callLogs) =>
      callLogs.where(_isIntercepted).length;

  int getWeeklyBlockedCallsCount(List<CallLog> callLogs) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekStartTimestamp = DateTime(weekStart.year, weekStart.month, weekStart.day);
    return callLogs.where((log) => _isIntercepted(log) && log.dateTime.isAfter(weekStartTimestamp)).length;
  }

  int getWeeklyFilteredSmsCount(List<CallLog> callLogs) => 0;

  int getAllowRulesCount(List<PhoneRuleEntity> rules) =>
      rules.where((r) => r.actionType == 'allow' && r.isEnabled).length;

  int getBlockRulesCount(List<PhoneRuleEntity> rules) =>
      rules.where((r) => r.actionType == 'block' && r.isEnabled).length;

  int getSilenceRulesCount(List<PhoneRuleEntity> rules) =>
      rules.where((r) => r.actionType == 'silence' && r.isEnabled).length;

  int getNoneRulesCount(List<PhoneRuleEntity> rules) =>
      rules.where((r) => r.actionType == 'none' && r.isEnabled).length;

  int getWhitelistRulesCount(List<PhoneRuleEntity> rules) => getAllowRulesCount(rules);

  int getBlacklistRulesCount(List<PhoneRuleEntity> rules) => getBlockRulesCount(rules);

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
      typeCounts[log.localCallType] = (typeCounts[log.localCallType] ?? 0) + 1;
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
    final relevantLogs = callLogs.where((log) => _isIntercepted(log) && log.dateTime.isAfter(startDate));

    for (final log in relevantLogs) {
      DateTime key;
      if (period == StatisticPeriod.year) {
        key = DateTime(log.dateTime.year, log.dateTime.month, 1);
      } else {
        key = DateTime(log.dateTime.year, log.dateTime.month, log.dateTime.day);
      }
      result[key] = (result[key] ?? 0) + 1;
    }
    return result;
  }

  List<PhoneRuleEntity> getTopTriggeredRules(List<PhoneRuleEntity> rules, {int limit = 3}) {
    final active = rules.where((r) => r.isEnabled).toList();
    active.sort((a, b) => b.count.compareTo(a.count));
    return active.take(limit).toList();
  }

  Map<int, int> getSimSlotDistribution(List<CallLog> callLogs) {
    final distribution = <int, int>{};
    for (final log in callLogs.where(_isIntercepted)) {
      final slot = log.simSlotIndex;
      distribution[slot] = (distribution[slot] ?? 0) + 1;
    }
    return distribution;
  }

  String getPeakHoursRange(List<CallLog> callLogs) {
    final intercepted = callLogs.where(_isIntercepted).toList();
    if (intercepted.isEmpty) return '14:00 - 16:00';
    final hourCounts = <int, int>{};
    for (final log in intercepted) {
      final hour = log.dateTime.hour;
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
