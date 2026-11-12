import 'dart:async';

import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';

import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_service.dart';
import 'package:yourcallyourrule/features/call_policy/evaluators/call_protection_service.dart';
import '../models/home_stats_model.dart';

class HomeStatsService {
  static final HomeStatsService _instance = HomeStatsService._internal();
  factory HomeStatsService() => _instance;
  HomeStatsService._internal();
  
  final CallStatisticsService _statisticsService = CallStatisticsService();
  final CallProtectionService _protectionService = CallProtectionService();
  final ConfigRepository _configRepository = SharedPreferencesConfigRepository();

  Future<HomeStats> getHomeStats(List<CallLogEntry> callLogs, List<PhoneRuleEntity> rules) async {
    final isProtectionActive = await _protectionService.isProtectionActive();
    final totalCalls = callLogs.length;
    final blockedCalls = _statisticsService.getTotalBlockedCount(callLogs);
    final blockRate = totalCalls > 0 ? blockedCalls / totalCalls : 0.0;
    
    final now = DateTime.now();
    final todayBlocked = callLogs.where((log) => 
      log.callType == 'blocked' || log.callType == 'rejected' || log.callType == 'silenced'
    ).where((log) {
      final logDateTime = DateTime.fromMillisecondsSinceEpoch(log.timestamp ?? 0);
      return logDateTime.year == now.year && 
             logDateTime.month == now.month && 
             logDateTime.day == now.day;
    }).length;
    
    final weeklyBlocked = _statisticsService.getWeeklyBlockedCallsCount(callLogs);
    
    final blockTrends = <BlockTrend>[];
    for (int i = 0; i < 7; i++) {
      final day = now.subtract(Duration(days: i));
      final count = callLogs.where((log) => 
        log.callType == 'blocked' || log.callType == 'rejected' || log.callType == 'silenced'
      ).where((log) {
        final logDateTime = DateTime.fromMillisecondsSinceEpoch(log.timestamp ?? 0);
        return logDateTime.year == day.year && 
               logDateTime.month == day.month && 
               logDateTime.day == day.day;
      }).length;
      
      blockTrends.add(BlockTrend(day: i, value: count.toDouble()));
    }
    
    final allowRulesCount = _statisticsService.getAllowRulesCount(rules);
    final blockRulesCount = _statisticsService.getBlockRulesCount(rules);
    final silenceRulesCount = _statisticsService.getSilenceRulesCount(rules);
    final noneRulesCount = _statisticsService.getNoneRulesCount(rules);
    final timeRulesCount = await _statisticsService.getTimeRulesCount(_configRepository);
    final totalRulesCount = rules.length;
    
    return HomeStats(
      blockRate: blockRate,
      todayBlocked: todayBlocked,
      weeklyBlocked: weeklyBlocked,
      isProtectionActive: isProtectionActive,
      blockTrends: blockTrends,
      allowRules: allowRulesCount,
      blockRules: blockRulesCount,
      silenceRules: silenceRulesCount,
      noneRules: noneRulesCount,
      blockedCalls: blockedCalls,
      totalRules: totalRulesCount,
      totalCalls: totalCalls,
      timeRules: timeRulesCount,
    );
  }
}
