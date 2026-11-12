import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_service.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/statistic_period.dart';

/// 通话统计仓库实现类
class CallStatisticsRepositoryImpl {
  final CallStatisticsService _statisticsService;
  final List<CallLogEntry> _callLogs;
  final List<PhoneRuleEntity> _rules;

  CallStatisticsRepositoryImpl([
    List<CallLogEntry>? callLogs,
    List<PhoneRuleEntity>? rules,
  ])  : _statisticsService = CallStatisticsService(),
        _callLogs = callLogs ?? [],
        _rules = rules ?? [];

  int getTotalBlockedCount() => _statisticsService.getTotalBlockedCount(_callLogs);
  int getWeeklyBlockedCallsCount() => _statisticsService.getWeeklyBlockedCallsCount(_callLogs);
  Future<int> getWeeklyFilteredSmsCount() async => _statisticsService.getWeeklyFilteredSmsCount(_callLogs);
  int getAllowRulesCount() => _statisticsService.getAllowRulesCount(_rules);
  int getBlockRulesCount() => _statisticsService.getBlockRulesCount(_rules);
  int getSilenceRulesCount() => _statisticsService.getSilenceRulesCount(_rules);
  int getNoneRulesCount() => _statisticsService.getNoneRulesCount(_rules);
  Future<int> getTimeRulesCount(ConfigRepository repo) => _statisticsService.getTimeRulesCount(repo);
  Map<String, double> getBlockTypeAnalysis() => _statisticsService.getBlockTypeAnalysis(_callLogs);
  Map<DateTime, int> getBlockedCallsTrend({required DateTime startDate, required DateTime endDate}) =>
      _statisticsService.getBlockedCallsByDate(_callLogs, StatisticPeriod.week);
}
