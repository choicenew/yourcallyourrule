import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/call_statistics_container_widget.dart';
// [重构]: 移除所有不再需要的 import
// import 'package:yourcallyourrule/ads/ad_manager.dart';
// import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
// import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';
// import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_card.dart';
// import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_chart.dart';
// import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/block_type_analysis.dart';

// [重构]: 只导入页面需要的核心组件
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
// [重构]: 导入我们已经重构好的自包含容器 Widget



// [重构]: 从 ConsumerStatefulWidget 改为更简单的 ConsumerWidget，因为它不再管理任何状态。
class CallStatisticsPage extends ConsumerWidget {
  const CallStatisticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [注释]: 页面不再需要直接 watch provider，因为子 Widget 会自己处理。
    // final statisticsState = ref.watch(callStatisticsProvider);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      bottomNavigationBar: BottomNavigation(
        currentIndex: 3,
        onTap: (index) => BottomNavigationHandler.handleNavigation(context, index),
      ),
      appBar: AppBar(title: Text(localizations.statisticsPageTitle)),
      // [重构]: body 现在非常简单，直接渲染自包含的 CallStatisticsContainerWidget。
      // 它将负责处理自己的加载、错误和数据显示逻辑。
      // 这样，如果未来有新的 Widget 需要添加到页面中，可以直接加在外面，
      // 不会影响 CallStatisticsContainerWidget 的内部逻辑。
      body: const CallStatisticsContainerWidget(),
    );
  }

  // [重构]: 移除所有重复的 _build... 方法，因为它们都已经被封装在
  // CallStatisticsContainerWidget 内部了。
  // Widget _buildStatisticsContent(...) { ... }
  // Widget _buildPeriodSelector(...) { ... }
  // Widget _periodButton(...) { ... }
}