import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/blocked_calls_chart.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// [重构]: 导入我们新创建的 Provider。
import 'package:yourcallyourrule/features/call_statistic/domain/providers/blocked_calls_provider.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/providers/blocked_call_repository_provider.dart';


// [重构]: 从 StatefulWidget 改为 ConsumerStatefulWidget，因为需要管理 TabController。
class BlockedCallsPage extends ConsumerStatefulWidget {
  // [重构]: 移除 repository 参数，因为它现在由 provider 管理。
  const BlockedCallsPage({super.key});

  @override
  ConsumerState<BlockedCallsPage> createState() => BlockedCallsPageState();
}

class BlockedCallsPageState extends ConsumerState<BlockedCallsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    // [注释]: TabController 的初始化保持不变。
    _tabController = TabController(length: 3, vsync: this);
    
    // [重构]: 添加监听器，当用户切换 Tab 时，调用 Notifier 的方法来加载新数据。
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        ref.read(blockedCallsProvider.notifier).changeTab(_tabController.index);
      }
    });
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  // [重构]: _loadBlockedCalls 和 _handleTabChange 方法已被移除，逻辑已移入 initState 的监听器和 Notifier 中。

  @override
  Widget build(BuildContext context) {
    // [重构]: 监听 blockedCallsProvider 的异步状态。
    final blockedCallsAsync = ref.watch(blockedCallsProvider);
    // [注释]: 从 provider 获取 repository 实例，传递给图表。
    final repository = ref.watch(blockedCallRepositoryProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.blockedCallsTitle),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: AppLocalizations.of(context)!.allCallsTab),
            Tab(text: AppLocalizations.of(context)!.phoneCallsTab),
            Tab(text: AppLocalizations.of(context)!.smsTab),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              // [注释]: BlockedCallsChart 仍然接收 repository，这没有问题。
              child: BlockedCallsChart(repository: repository),
            ),
          ),
          const InlineAdaptiveBannerAdWidget(adInfo: AdManager.adaptiveBannerAd),
          Expanded(
            flex: 3,
            // [重构]: 使用 .when 来根据异步状态构建列表。
            child: blockedCallsAsync.when(
              data: (state) {
                final blockedCalls = state.calls;
                if (blockedCalls.isEmpty) {
                  return Center(child: Text(AppLocalizations.of(context)!.noData)); 
                }
                return ListView.builder(
                  itemCount: blockedCalls.length,
                  itemBuilder: (context, index) {
                    final call = blockedCalls[index];
                    return ListTile(
                      leading: Icon(
                        call.type == BlockedType.call ? Icons.phone : Icons.sms,
                        color: call.type == BlockedType.call ? Colors.red : Colors.orange,
                      ),
                      title: Text(call.phoneNumber),
                      subtitle: Text(
                        '${call.timestamp.toString().substring(0, 16)} · ${call.type == BlockedType.call ? AppLocalizations.of(context)!.phoneCallsTab : AppLocalizations.of(context)!.smsTab}'
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, st) => Center(child: Text(AppLocalizations.of(context)!.dataLoadFailure(err.toString()))),
            )
          ),
        ],
      ),
    );
  }
}