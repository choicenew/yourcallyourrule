import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// 引入所有必要的数据 Provider
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/deletion_proposal_statistics_service.dart';

// 引入纯展示的 StatisticsCard Widget
import 'package:yourcallyourrule/features/deletion_proposal/widgets/statistics_card.dart';

/// 统计信息容器组件。
///
/// 这是一个“智能”组件，负责从 Riverpod Providers 获取所有统计数据，
/// 并将这些数据传递给“哑”的、纯展示性的 `StatisticsCard` Widget。
class StatisticsContainerWidget extends ConsumerWidget {
  const StatisticsContainerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. 从 Notifier 中 `watch` 提议的统计数据。
    //    使用 .select 确保只有在 `statistics` 变化时才重建。
    final statistics = ref.watch(deletionProposalProvider.select((state) => state.statistics));

    // 2. 从 Service 中 `watch` 投票计数的流。
    //    我们创建一个临时的 StreamProvider 来处理这个流。
    final voteCountStreamProvider = StreamProvider<int>((ref) {
      return ref.watch(deletionProposalStatisticsServiceProvider).voteCountStream;
    });
    final voteCountAsync = ref.watch(voteCountStreamProvider);

    // 3. 使用 AsyncValue.when 来处理投票计数流的不同状态。
    return voteCountAsync.when(
      // 当数据成功加载时
      data: (voteCount) {
        // 将获取到的 `statistics` 和 `voteCount` 数据传递给 `StatisticsCard`
        return StatisticsCard(
          statistics: statistics,
          voteCount: voteCount,
          // 这里的回调逻辑现在也内聚在这个容器组件中
          onExchangeVip: voteCount >= 10
              ? () {
                  // 执行页面导航
                  GoRouter.of(context).push('/vip-exchange');
                }
              : null,
        );
      },
      // 当流正在加载时，显示一个加载指示器
      loading: () => const Center(child: CircularProgressIndicator()),
      // 当流发生错误时，显示错误信息
      error: (err, stack) => Center(child: Text('Error loading vote count: $err')),
    );
  }
}