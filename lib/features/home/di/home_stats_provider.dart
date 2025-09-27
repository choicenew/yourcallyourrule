import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/home/models/home_stats_model.dart';
import 'package:yourcallyourrule/features/home/services/home_stats_service.dart';

// 1. 【修改】Provider类型从 StateNotifierProvider 改为 AsyncNotifierProvider
final homeStatsProvider = AsyncNotifierProvider<HomeStatsNotifier, HomeStats>(() {
  return HomeStatsNotifier();
});

// 2. 【修改】Notifier基类从 StateNotifier<AsyncValue<HomeStats>> 改为 AsyncNotifier<HomeStats>
//    注意：泛型里不再需要 AsyncValue，因为框架会为我们处理它。
class HomeStatsNotifier extends AsyncNotifier<HomeStats> {
  // 3. 【移除】不再需要在构造函数中接收 Ref。
  //    'ref' 现在是 AsyncNotifier 的一个内置属性。
  //    也不再需要手动调用加载方法。

  // 4. 【核心修改】所有初始化和数据获取逻辑都移入 build 方法。
  //    这个方法必须返回 Future<HomeStats>。
  //    Riverpod 会自动处理这个 Future 的生命周期：
  //    - 在 Future 开始时，provider 的状态是 AsyncLoading。
  //    - 在 Future 成功完成时，provider 的状态是 AsyncData(返回的值)。
  //    - 在 Future 抛出异常时，provider 的状态是 AsyncError(异常)。
  @override
  Future<HomeStats> build() async {
    // 5. 【简化】不再需要 try/catch 和手动设置 state。
    //    直接编写你的数据获取逻辑即可。
    final callLogService = ref.read(callLogServiceProvider);
    final ruleManagementService = ref.read(ruleManagementServiceProvider);
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
      
    // 6. 【简化】只需返回最终的数据。
    return homeStats;
  }

  // 7. 【可选但推荐】如果你需要一个“下拉刷新”的功能，可以添加一个公共方法。
  Future<void> refresh() async {
    // 让 provider 重新执行 build 方法来获取最新的数据。
    // invalidateSelf 会自动将状态设置为 loading，然后等待 build 完成。
    ref.invalidateSelf();
    // 等待新的状态计算完成
    await future;
  }
}