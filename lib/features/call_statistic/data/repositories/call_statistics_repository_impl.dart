import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_service.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/call_statistics_repository.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';

class CallStatisticsRepositoryImpl implements CallStatisticsRepository {
  final CallStatisticsService _statisticsService;
  final List<CallLog> _callLogs;
  final List<RuleBase> _rules;
  final BlockedCallRepository _blockedCallRepository = BlockedCallRepository();

  CallStatisticsRepositoryImpl(this._callLogs, this._rules)
      : _statisticsService = CallStatisticsService();

  int getTotalBlockedCount() {
    return _statisticsService.getTotalBlockedCount(_callLogs);
  }

  int getWeeklyBlockedCallsCount() {
    return _statisticsService.getWeeklyBlockedCallsCount(_callLogs);
  }

  int getWeeklyFilteredSmsCount() {
    return _statisticsService.getWeeklyFilteredSmsCount(_callLogs);
  }

  // 获取允许规则数量
  int getAllowRulesCount() {
    return _statisticsService.getAllowRulesCount(_rules);
  }

  // 获取阻止规则数量
  int getBlockRulesCount() {
    return _statisticsService.getBlockRulesCount(_rules);
  }

  // 获取静音规则数量
  int getSilenceRulesCount() {
    return _statisticsService.getSilenceRulesCount(_rules);
  }

  // 获取无动作规则数量
  int getNoneRulesCount() {
    return _statisticsService.getNoneRulesCount(_rules);
  }

  // 兼容旧代码的方法
  int getWhitelistRulesCount() {
    return _statisticsService.getWhitelistRulesCount(_rules);
  }

  // 兼容旧代码的方法
  int getBlacklistRulesCount() {
    return _statisticsService.getBlacklistRulesCount(_rules);
  }

  Map<String, double> getBlockTypeAnalysis() {
    return _statisticsService.getBlockTypeAnalysis(_callLogs);
  }

  double calculateMonthlyGrowthRate() {
    return _statisticsService.calculateMonthlyGrowthRate(_callLogs);
  }

  Map<DateTime, int> getBlockedCallsByDate(String period) {
    return _statisticsService.getBlockedCallsByDate(_callLogs, period);
  }

  @override
  Future<List<BlockedCall>> getBlockedCalls() async {
    return _blockedCallRepository.getBlockedCalls();
  }

  @override
  Future<void> addBlockedCall(String phoneNumber) async {
    await _blockedCallRepository.addBlockedCall(phoneNumber);
  }
}