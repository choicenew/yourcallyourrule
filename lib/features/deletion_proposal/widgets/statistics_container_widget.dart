import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/statistics_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/statistics_card.dart';

/// 社区贡献统计的“智能容器”组件（100% 绑定 Proposal 实体与用户投票流，无 Map 字符串依赖）
class StatisticsContainerWidget extends ConsumerWidget {
  const StatisticsContainerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. watch 包含完整强类型 Proposal 实体列表的状态
    final proposalState = ref.watch(deletionProposalProvider);
    
    // 2. watch 用户表决投票流
    final voteCountAsync = ref.watch(userVoteCountStreamProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          voteCountAsync.when(
            data: (voteCount) {
              return StatisticsCard(
                proposals: proposalState.proposals,
                voteCount: voteCount,
                onExchangeVip: voteCount >= 10
                    ? () => GoRouter.of(context).push('/vip-exchange')
                    : null,
              );
            },
            loading: () {
              return StatisticsCard(
                proposals: proposalState.proposals,
                voteCount: null,
                onExchangeVip: null,
              );
            },
            error: (err, stack) {
              return StatisticsCard(
                proposals: proposalState.proposals,
                voteCount: 0,
                onExchangeVip: null,
              );
            },
          ),
          const SizedBox(height: 16),
          const GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
