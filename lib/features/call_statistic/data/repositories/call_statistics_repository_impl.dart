import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/call_history/entities/call_log.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_service.dart';

/// 通话统计仓库实现类
class CallStatisticsRepositoryImpl {
  final CallStatisticsService _statisticsService;
  final List<CallLog> _callLogs;
  final List<PhoneRuleEntity> _rules;

  CallStatisticsRepositoryImpl({
    List<CallLog>? callLogs,
    List<PhoneRuleEntity>? rules,
  })  : _statisticsService = CallStatisticsService(),
        _callLogs = callLogs ?? [],
        _rules = rules ?? [];

  int getTotalBlockedCount() => _statisticsService.getTotalBlockedCount(_callLogs);
  int getWeeklyBlockedCallsCount() => _statisticsService.getWeeklyBlockedCallsCount(_callLogs);
  int getAllowRulesCount() => _statisticsService.getAllowRulesCount(_rules);
  int getBlockRulesCount() => _statisticsService.getBlockRulesCount(_rules);
}
