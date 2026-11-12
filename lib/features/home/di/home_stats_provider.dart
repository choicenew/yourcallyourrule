import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/home/models/home_stats_model.dart';
import 'package:yourcallyourrule/features/home/services/home_stats_service.dart';

final homeStatsProvider = AsyncNotifierProvider<HomeStatsNotifier, HomeStats>(() {
  return HomeStatsNotifier();
});

class HomeStatsNotifier extends AsyncNotifier<HomeStats> {
  @override
  Future<HomeStats> build() async {
    final callLogService = ref.read(callLogServiceProvider);
    final ruleRepository = ref.read(ruleRepositoryProvider);
    final homeStatsService = HomeStatsService();
      
    await callLogService.initialize();
    final callLogs = await callLogService.getRecentLogs();
      
    final allRules = await ruleRepository.getAll();
      
    final homeStats = await homeStatsService.getHomeStats(
      callLogs,
      allRules,
    );
      
    return homeStats;
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
