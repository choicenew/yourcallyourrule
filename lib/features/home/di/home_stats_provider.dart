import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
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
      
    // 直接读取 SQLite 数据库中的所有规则（包含所有电话规则、订阅规则、正则规则、允许/拦截规则）
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