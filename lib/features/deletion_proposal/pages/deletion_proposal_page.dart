import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/purchase/services/vip_exchange_service.dart';
import '../widgets/proposal_card.dart';
import '../widgets/create_proposal_dialog.dart';
import '../widgets/statistics_card.dart';
import '../providers/deletion_proposal_provider.dart';
import '../services/deletion_proposal_statistics_service.dart';

class DeletionProposalPage extends ConsumerStatefulWidget {
  const DeletionProposalPage({super.key});

  @override
  ConsumerState<DeletionProposalPage> createState() => _DeletionProposalPageState();
}

class _DeletionProposalPageState extends ConsumerState<DeletionProposalPage> {
  late DeletionProposalStatisticsService _statisticsService;
  
  @override
  void initState() {
    super.initState();
    // 初始化统计服务
    _statisticsService = DeletionProposalStatisticsService(
      ref.read(labelMarkStatisticsRepositoryProvider)
    );
  }

  @override
  Widget build(BuildContext context) {
    final proposalState = ref.watch(deletionProposalProvider);
    final voteCount = ref.watch(labelMarkStatisticsRepositoryProvider).markCountStream;
    
    return StreamBuilder<int>(
      stream: voteCount,
      builder: (context, snapshot) {
        final currentVoteCount = snapshot.data ?? 0;
        
        return GenericListWithAdsPage(
          title: AppLocalizations.of(context)!.deletionProposals,
          items: proposalState.proposals,
          itemBuilder: (context, proposal) => _buildProposalCard(context, proposal),
          adBuilder:  () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
          adInterval: 3,
          emptyText: AppLocalizations.of(context)!.noProposalsFound,
          emptyIcon: Icons.how_to_vote_outlined,
          themeColor: Colors.deepPurple,
          isLoading: proposalState.isLoading,
          onRefresh: () async {
            await ref.read(deletionProposalProvider.notifier).refreshProposals();
          },
          onAdd: () {
            _showCreateProposalDialog(context);
          },
          infoCard: StatisticsCard(
            voteCount: currentVoteCount,
            onExchangeVip: currentVoteCount >= 10 
              ? () => _showVipExchangeDialog(context, currentVoteCount)
              : null,
          ),
          searchHintText: AppLocalizations.of(context)!.searchProposals,
          onSearchChanged: (query) {
            // 实现搜索逻辑
            ref.read(deletionProposalProvider.notifier).searchProposals(query);
          },
        );
      },
    );
  }
  
  void _showCreateProposalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => CreateProposalDialog(
        onSubmit: (phoneNumber, reason, riskLevel) async {
          await ref.read(deletionProposalProvider.notifier).createProposal(
            phoneNumber,
            reason,
            riskLevel,
          );
        },
      ),
    );
  }
  
  Future<void> _showVipExchangeDialog(BuildContext context, int voteCount) async {
    // 导航到VIP兑换页面
    GoRouter.of(context).push('/vip-exchange');
    
    // 返回后刷新数据
    if (mounted) {
      await ref.read(deletionProposalProvider.notifier).refreshProposals();
    }
  }
  
  Widget _buildProposalCard(BuildContext context, dynamic proposal) {
    return ProposalCard(
      proposal: proposal,
      onVote: (proposalId, isApproval) async {
        try {
          // 记录投票到统计服务
          await _statisticsService.recordVote(proposalId, isApproval);
          
          // 执行实际投票
          await ref.read(deletionProposalProvider.notifier).voteOnProposal(
            proposalId: proposalId,
            support: isApproval,
          );
          
          // 投票成功后刷新数据，不再在这里处理兑换逻辑
          return true;
        } catch (e) {
          return false;
        }
      },
    );
  }
}