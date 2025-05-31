import 'dart:async';

import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';

import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_service.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_protection_service.dart';
import '../models/home_stats_model.dart';

class HomeStatsService {
  // 单例模式
  static final HomeStatsService _instance = HomeStatsService._internal();
  factory HomeStatsService() => _instance;
  HomeStatsService._internal();
  
  final CallStatisticsService _statisticsService = CallStatisticsService();
  final CallProtectionService _protectionService = CallProtectionService();
  final ConfigRepository _configRepository = SharedPreferencesConfigRepository();

  // 使用真实数据接口
  Future<HomeStats> getHomeStats(List<CallLog> callLogs, List<RuleBase> rules) async {
    // 检查呼叫保护是否激活
    final isProtectionActive = await _protectionService.isProtectionActive();
    // 计算拦截率
    final totalCalls = callLogs.length;
    final blockedCalls = _statisticsService.getTotalBlockedCount(callLogs);
    final blockRate = totalCalls > 0 ? blockedCalls / totalCalls : 0.0;
    
    // 获取今日拦截数量
    final now = DateTime.now();
    final todayBlocked = callLogs.where((log) => 
      log.labelIds != null && 
      log.labelIds!.isNotEmpty && 
      log.timestamp.year == now.year && 
      log.timestamp.month == now.month && 
      log.timestamp.day == now.day
    ).length;
    
    // 获取本周拦截数量
    final weeklyBlocked = _statisticsService.getWeeklyBlockedCallsCount(callLogs);
    
    // 获取拦截趋势数据
    final blockTrends = <BlockTrend>[];
    for (int i = 0; i < 7; i++) {
      final day = now.subtract(Duration(days: i));
      final count = callLogs.where((log) => 
        log.labelIds != null && 
        log.labelIds!.isNotEmpty && 
        log.timestamp.year == day.year && 
        log.timestamp.month == day.month && 
        log.timestamp.day == day.day
      ).length;
      
      blockTrends.add(BlockTrend(day: i, value: count.toDouble()));
    }
    
    // 计算各类规则数量
    // 使用新的方法获取四种action类型的规则数量
    final allowRulesCount = _statisticsService.getAllowRulesCount(rules);
    final blockRulesCount = _statisticsService.getBlockRulesCount(rules);
    final silenceRulesCount = _statisticsService.getSilenceRulesCount(rules);
    final noneRulesCount = _statisticsService.getNoneRulesCount(rules);
    // 计算时间规则数量 - 使用专门的方法获取
    final timeRulesCount = await _statisticsService.getTimeRulesCount(_configRepository);
    final totalRulesCount = rules.length;
    
    return HomeStats(
      blockRate: blockRate,
      todayBlocked: todayBlocked,
      weeklyBlocked: weeklyBlocked,
      isProtectionActive: isProtectionActive,
      blockTrends: blockTrends,
      // 为了兼容旧代码，仍然使用blacklistRules和whitelistRules字段
      // 但实际上分别对应blockRulesCount和allowRulesCount
    //  blacklistRules: blockRulesCount,
   //   whitelistRules: allowRulesCount,
      // 添加新的字段来存储四种action类型的规则数量
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