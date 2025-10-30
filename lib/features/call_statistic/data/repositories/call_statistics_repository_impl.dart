import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_service.dart';

class CallStatisticsRepositoryImpl {
  final CallStatisticsService _statisticsService;
  final List<CallLog> _callLogs;
  final List<RuleBase> _rules;

  CallStatisticsRepositoryImpl(this._callLogs, this._rules)
      : _statisticsService = CallStatisticsService();

  int getTotalBlockedCount() => _statisticsService.getTotalBlockedCount(_callLogs);
  int getWeeklyBlockedCallsCount() => _statisticsService.getWeeklyBlockedCallsCount(_callLogs);
  int getWeeklyFilteredSmsCount() => _statisticsService.getWeeklyFilteredSmsCount(_callLogs);
  int getAllowRulesCount() => _statisticsService.getAllowRulesCount(_rules);
  int getBlockRulesCount() => _statisticsService.getBlockRulesCount(_rules);
  int getSilenceRulesCount() => _statisticsService.getSilenceRulesCount(_rules);
  int getNoneRulesCount() => _statisticsService.getNoneRulesCount(_rules);
  int getWhitelistRulesCount() => _statisticsService.getWhitelistRulesCount(_rules);
  int getBlacklistRulesCount() => _statisticsService.getBlacklistRulesCount(_rules);
  Future<int> getTimeRulesCount(ConfigRepository configRepo) => _statisticsService.getTimeRulesCount(configRepo);
  Map<String, double> getBlockTypeAnalysis() => _statisticsService.getBlockTypeAnalysis(_callLogs);
  Map<DateTime, int> getBlockedCallsByDate(String period) => _statisticsService.getBlockedCallsByDate(_callLogs, period);
}