import 'package:flutter/material.dart';

class HomeStats {
  final double blockRate;
  final int todayBlocked;
  final int weeklyBlocked;
  final bool isProtectionActive;
  final List<BlockTrend> blockTrends;
  // 保留原有字段以兼容旧代码
  //final int blacklistRules;
 // final int whitelistRules;
  // 添加新的字段来存储四种action类型的规则数量
  final int allowRules;
  final int blockRules;
  final int silenceRules;
  final int noneRules;
  final int timeRules;
  final int blockedCalls;
  final int totalRules;
  final int totalCalls;

  HomeStats({
    required this.blockRate,
    required this.todayBlocked,
    required this.weeklyBlocked,
    required this.isProtectionActive,
    required this.blockTrends,
   // required this.blacklistRules,
   // required this.whitelistRules,
    this.allowRules = 0,
    this.blockRules = 0,
    this.silenceRules = 0,
    this.noneRules = 0,
    required this.timeRules,
    required this.blockedCalls,
    required this.totalRules,
    required this.totalCalls,
  });

  factory HomeStats.empty() {
    return HomeStats(
      blockRate: 0.0,
      todayBlocked: 0,
      weeklyBlocked: 0,
      isProtectionActive: false,
      blockTrends: [],
    //  blacklistRules: 0,
     // whitelistRules: 0,
      allowRules: 0,
      blockRules: 0,
      silenceRules: 0,
      noneRules: 0,
      timeRules: 0,
      blockedCalls: 0,
      totalRules: 0,
      totalCalls: 0,
    );
  }
}

class BlockTrend {
  final int day;
  final double value;

  BlockTrend({required this.day, required this.value});
}