import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/home/models/home_stats_model.dart';
import 'package:yourcallyourrule/features/home/services/home_stats_service.dart';

/// HomeStats的Provider
final homeStatsProvider = StateNotifierProvider<HomeStatsNotifier, AsyncValue<HomeStats>>((ref) {
  return HomeStatsNotifier(ref);
});

class HomeStatsNotifier extends StateNotifier<AsyncValue<HomeStats>> {
  final Ref _ref;
  
  HomeStatsNotifier(this._ref) : super(const AsyncValue.loading()) {
    loadHomeStats();
  }
  
  Future<void> loadHomeStats() async {
    state = const AsyncValue.loading();
    try {
      final callLogService = _ref.read(callLogServiceProvider);
      final ruleManagementService = _ref.read(ruleManagementServiceProvider);
      final homeStatsService = HomeStatsService();
      
      await callLogService.initialize();
      final callLogs = await callLogService.getRecentLogs();
      
      final allowRules = await ruleManagementService.getRulesByAction(RuleAction.allow);
      final blockRules = await ruleManagementService.getRulesByAction(RuleAction.block);
      final muteRules = await ruleManagementService.getRulesByAction(RuleAction.silence);
      final noneRules = await ruleManagementService.getRulesByAction(RuleAction.none);
      
      // 合并所有规则
      final allRules = [...allowRules, ...blockRules, ...muteRules, ...noneRules];
      
      final homeStats = await homeStatsService.getHomeStats(
        callLogs,
        allRules,
      );
      
      state = AsyncValue.data(homeStats);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}