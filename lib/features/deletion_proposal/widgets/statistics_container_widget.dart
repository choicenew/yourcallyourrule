import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/statistics_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/statistics_card.dart';

/// 社区贡献统计容器组件
class StatisticsContainerWidget extends ConsumerWidget {
  const StatisticsContainerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proposalState = ref.watch(deletionProposalProvider);
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
          const AdsInlineBanner(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
