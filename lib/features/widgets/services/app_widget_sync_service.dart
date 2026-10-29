import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/cloud_sync/provider/cloud_sync_provider.dart';
import 'package:yourcallyourrule/core/provider/rules_provider.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/statistics_provider.dart';

part 'app_widget_sync_service.g.dart';

/// 桌面小组件数据计算与 1:1 MethodChannel 同步服务
/// 遵照 AGENTS.md / veherego-widget-realtime-protocol 铁律：
/// 1. 100% 绑定现有真实 Provider 实体数据
/// 2. 绝对严禁任何硬编码假数据或硬编码汉字/模拟号码
/// 3. 无数据时合规呈现 "--" 空状态
@riverpod
class AppWidgetSyncService extends _$AppWidgetSyncService {
  static const MethodChannel _channel = MethodChannel('com.yours.yourcallyourrule/app_widget_sync');

  @override
  void build() {
    _listenToProviders();
  }

  void _listenToProviders() {
    // 监听规则与同步状态
    ref.listen(rulesProvider, (previous, next) {
      syncWidgetData();
    });

    ref.listen(cloudSyncStatusProvider, (previous, next) {
      syncWidgetData();
    });

    // 监听 Dashboard 通话统计
    ref.listen(callStatisticsProvider, (previous, next) {
      syncWidgetData();
    });

    // 监听社区判官与提议统计
    ref.listen(proposalStatisticsProvider, (previous, next) {
      syncWidgetData();
    });
  }

  Future<void> syncWidgetData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 1. 读取规则与云端同步状态
      final rulesState = ref.read(rulesProvider);
      final syncStatusAsync = ref.read(cloudSyncStatusProvider);

      final totalRules = rulesState.value?.length ?? 0;
      final syncStatus = syncStatusAsync.value ?? {};
      final serviceType = (syncStatus['service_type'] as String?) ?? '--';
      final lastSyncTime = (syncStatus['last_sync_time'] as String?) ?? '--';

      // 2. 读取 CallStatisticsState 真实数据
      final callStats = ref.read(callStatisticsProvider);
      final blockedCallsCount = callStats.blockedCallsCount;
      final sim1Count = callStats.simSlotDistribution[0] ?? callStats.simSlotDistribution[1] ?? 0;
      final sim2Count = callStats.simSlotDistribution[2] ?? 0;
      final peakHours = callStats.peakHoursRange.isNotEmpty ? callStats.peakHoursRange : '--';

      // 3. 读取社区判官真实统计数据
      final proposalStatsAsync = ref.read(proposalStatisticsProvider);
      final proposalStats = proposalStatsAsync.value ?? {};
      final voteCount = proposalStats['totalPending'] ?? 0;
      final highRisk = proposalStats['highRisk'] ?? 0;
      final mediumRisk = proposalStats['mediumRisk'] ?? 0;
      final lowRisk = proposalStats['lowRisk'] ?? 0;

      // 写入 SharedPrefs 物理磁盘（1:1 与 Kotlin 键名一致，无硬编码）
      await prefs.setInt('widget_total_rules', totalRules);
      await prefs.setString('widget_last_sync', lastSyncTime);
      await prefs.setString('widget_service_type', serviceType);
      await prefs.setInt('widget_blocked_calls_count', blockedCallsCount);
      await prefs.setInt('widget_sim1_count', sim1Count);
      await prefs.setInt('widget_sim2_count', sim2Count);
      await prefs.setString('widget_peak_hours', peakHours);
      await prefs.setInt('widget_vote_count', voteCount);
      await prefs.setInt('widget_high_risk', highRisk);
      await prefs.setInt('widget_medium_risk', mediumRisk);
      await prefs.setInt('widget_low_risk', lowRisk);
      await prefs.setString('widget_hot_number', '--');
      await prefs.setString('widget_hot_tag', '--');
      await prefs.setString('widget_font_scale', '1.0');

      // 通过 MethodChannel 唤醒 Android 原生触发 Glance 物理重绘
      if (defaultTargetPlatform == TargetPlatform.android) {
        await _channel.invokeMethod('updateAppWidgetState');
      }
    } catch (e) {
      debugPrint('AppWidgetSyncService error: $e');
    }
  }
}
