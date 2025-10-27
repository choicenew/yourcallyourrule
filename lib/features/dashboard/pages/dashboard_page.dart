import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';

// 引入两个独立的、自给自足的“智能”容器组件
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/call_statistics_container_widget.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/statistics_container_widget.dart';

// 引入通用组件
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 数据分析仪表盘页面
///
/// 【最终形态】: 这是一个 `StatefulConsumerWidget`，它使用 `TabController`
///             来管理两个独立的统计模块的切换。
class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dataAnalysis),
        // 【核心修正】: 使用了您提供的、正确的 AppBar 返回逻辑
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              context.pop();
            } else {
              // 假设您的 Home 路由名称是 AppRouter.home
              GoRouter.of(context).goNamed(AppRouter.home);
            }
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: AppLocalizations.of(context)!.callStatistics), // 本机统计
            Tab(text: AppLocalizations.of(context)!.deletionProposals), // 社区贡献
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 第一个标签页：通话统计
          CallStatisticsContainerWidget(),
          
          // 第二个标签页：社区贡献统计
          StatisticsContainerWidget(),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 3,
        onTap: (index) => BottomNavigationHandler.handleNavigation(context, index),
      ),
    );
  }
}