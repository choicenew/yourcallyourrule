import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// 引入所有必要的 Provider 和 Widget
import 'package:yourcallyourrule/features/deletion_proposal/providers/statistics_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/statistics_card.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';

/// 社区贡献统计的“智能容器”组件。
///
/// 【最终形态】: 它完全自给自足，负责获取统计数据、处理加载状态，并集成广告展示。
class StatisticsContainerWidget extends ConsumerWidget {
  const StatisticsContainerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. `watch` 专属的 `proposalStatisticsProvider`。
    final statisticsAsync = ref.watch(proposalStatisticsProvider);
    
    // 2. `watch` 专属的 `userVoteCountStreamProvider`。
    final voteCountAsync = ref.watch(userVoteCountStreamProvider);

    // =======================================================================
    // 3. 【核心修正】: 我们现在返回一个 Column，将统计卡片和广告组合在一起。
    // =======================================================================
    return Column(
      children: [
        // 第一部分：统计卡片
        // 我们将之前 `when` 的逻辑封装在这里
        statisticsAsync.when(
          data: (statistics) {
            return voteCountAsync.when(
              data: (voteCount) {
                // 所有数据都已就绪
                return StatisticsCard(
                  statistics: statistics,
                  voteCount: voteCount,
                  onExchangeVip: voteCount >= 10
                      ? () => GoRouter.of(context).push('/vip-exchange')
                      : null,
                );
              },
              loading: () {
                // 统计已加载，投票数加载中
                return StatisticsCard(
                  statistics: statistics,
                  voteCount: null, // voteCount 尚未就绪
                  onExchangeVip: null,
                );
              },
              error: (err, stack) {
                // 投票数加载失败
                return StatisticsCard(
                  statistics: statistics,
                  voteCount: 0, // 显示 0 作为备用值
                  onExchangeVip: null,
                );
              },
            );
          },
          loading: () {
            // 主要数据（提议统计）正在加载时，显示一个占位的、带有默认值的卡片。
            // 这避免了无限转圈，并保持了布局的稳定性。
            return const StatisticsCard(
              statistics: {'totalPending': 0, 'highRisk': 0, 'mediumRisk': 0, 'lowRisk': 0},
              voteCount: 0,
              onExchangeVip: null,
            );
          },
          error: (err, stack) {
            // 主要数据加载失败，显示错误信息卡片。
            return Card(
              child: SizedBox(
                height: 300, // 给一个高度
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(AppLocalizations.of(context)!.dataLoadingFailed(err.toString())),
                  ),
                ),
              ),
            );
          },
        ),

        // 两个组件之间的间距
        const SizedBox(height: 16),

        // 第二部分：广告
        const GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
      ],
    );
  }
}