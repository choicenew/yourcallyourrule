import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';

import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
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
    // 使用rule.action来区分白名单和黑名单规则
    final blacklistRulesCount = _statisticsService.getBlacklistRulesCount(rules);
    final whitelistRulesCount = _statisticsService.getWhitelistRulesCount(rules);
    // 计算时间规则数量 - 使用专门的方法获取
    final timeRulesCount = await _statisticsService.getTimeRulesCount(_configRepository);
    final totalRulesCount = rules.length;
    
    return HomeStats(
      blockRate: blockRate,
      todayBlocked: todayBlocked,
      weeklyBlocked: weeklyBlocked,
      isProtectionActive: isProtectionActive,
      blockTrends: blockTrends,
      blacklistRules: blacklistRulesCount,
      whitelistRules: whitelistRulesCount,
      blockedCalls: blockedCalls,
      totalRules: totalRulesCount,
      totalCalls: totalCalls,
      timeRules: timeRulesCount,
    );
  }
}