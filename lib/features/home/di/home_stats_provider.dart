import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/home/models/home_stats_model.dart';
import 'package:yourcallyourrule/features/home/services/home_stats_service.dart';

// 1. 【修改】Provider类型�?StateNotifierProvider 改为 AsyncNotifierProvider
final homeStatsProvider = AsyncNotifierProvider<HomeStatsNotifier, HomeStats>(() {
  return HomeStatsNotifier();
});

// 2. 【修改】Notifier基类�?StateNotifier<AsyncValue<HomeStats>> 改为 AsyncNotifier<HomeStats>
//    注意：泛型里不再需�?AsyncValue，因为框架会为我们处理它�?
class HomeStatsNotifier extends AsyncNotifier<HomeStats> {
  // 3. 【移除】不再需要在构造函数中接收 Ref�?
  //    'ref' 现在�?AsyncNotifier 的一个内置属性�?
  //    也不再需要手动调用加载方法�?

  // 4. 【核心修改】所有初始化和数据获取逻辑都移�?build 方法�?
  //    这个方法必须返回 Future<HomeStats>�?
  //    Riverpod 会自动处理这�?Future 的生命周期：
  //    - �?Future 开始时，provider 的状态是 AsyncLoading�?
  //    - �?Future 成功完成时，provider 的状态是 AsyncData(返回的�?�?
  //    - �?Future 抛出异常时，provider 的状态是 AsyncError(异常)�?
  @override
  Future<HomeStats> build() async {
    // 5. 【简化】不再需�?try/catch 和手动设�?state�?
    //    直接编写你的数据获取逻辑即可�?
    final callLogService = ref.read(callLogServiceProvider);
    final ruleRepository = ref.read(ruleRepositoryProvider);
    final homeStatsService = HomeStatsService();
      
    await callLogService.initialize();
    final callLogs = await callLogService.getRecentLogs();
      
    // 直接读取 SQLite 数据库中的全量规则（包含电话规则、允�?拦截规则、正则规则等�?
    final allRules = await ruleRepository.getAll();
      
    final homeStats = await homeStatsService.getHomeStats(
      callLogs,
      allRules,
    );
      
    // 6. 【简化】只需返回最终的数据�?
    return homeStats;
  }

  // 7. 【可选但推荐】如果你需要一个“下拉刷新”的功能，可以添加一个公共方法�?
  Future<void> refresh() async {
    // �?provider 重新执行 build 方法来获取最新的数据�?
    // invalidateSelf 会自动将状态设置为 loading，然后等�?build 完成�?
    ref.invalidateSelf();
    // 等待新的状态计算完�?
    await future;
  }
}