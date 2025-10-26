import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_card.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/create_proposal_dialog.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/statistics_card.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/deletion_proposal_statistics_service.dart';
import 'package:yourcallyourrule/data/repositories/label_mark_statistics_repository.dart';

class DeletionProposalPage extends ConsumerStatefulWidget {
  const DeletionProposalPage({super.key});

  @override
  ConsumerState<DeletionProposalPage> createState() => _DeletionProposalPageState();
}

class _DeletionProposalPageState extends ConsumerState<DeletionProposalPage> {
  bool _isMultiSelectMode = false;
  Set<String> _selectedProposalIds = {};

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(deletionProposalProvider.notifier).loadPendingProposals());
  }

  void _toggleMultiSelectMode() {
    setState(() {
      _isMultiSelectMode = !_isMultiSelectMode;
      if (!_isMultiSelectMode) _selectedProposalIds.clear();
    });
  }

  void _toggleItemSelection(String proposalId) {
    setState(() {
      if (_selectedProposalIds.contains(proposalId)) {
        _selectedProposalIds.remove(proposalId);
      } else {
        _selectedProposalIds.add(proposalId);
      }
    });
  }

  void _deleteSelectedProposals() async {
    // await ref.read(deletionProposalProvider.notifier).deleteProposalsByIds(_selectedProposalIds);
    setState(() {
      _selectedProposalIds.clear();
      _isMultiSelectMode = false;
    });
    await ref.read(deletionProposalProvider.notifier).refreshProposals();
  }

  @override
  Widget build(BuildContext context) {
    // =======================================================================
    // 【核心修正】: 使用了【正确】的 Provider 名称 `deletionProposalProvider`。
    // REASON: 这是由 @riverpod 为 DeletionProposalNotifier 自动生成的正确名称。
    // =======================================================================
    final proposalState = ref.watch(deletionProposalProvider);
    final voteCountStream = ref.watch(deletionProposalStatisticsServiceProvider).voteCountStream;
    
    return StreamBuilder<int>(
      stream: voteCountStream,
      builder: (context, snapshot) {
        final currentVoteCount = snapshot.data ?? 0;
        
        return GenericListWithAdsPage<Proposal>(
          title: AppLocalizations.of(context)!.deletionProposals,
          items: proposalState.proposals,
          itemBuilder: (context, proposal) => _buildProposalCard(context, proposal),
          adBuilder: () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
          adInterval: 3,
          emptyText: AppLocalizations.of(context)!.noProposalsFound,
          emptyIcon: Icons.how_to_vote_outlined,
          themeColor: Colors.deepPurple,
          isLoading: proposalState.isLoading,
          onRefresh: () => ref.read(deletionProposalProvider.notifier).refreshProposals(),
          onAdd: () => _showCreateProposalDialog(context),
          headerContent: _buildHeaderContent(context),
          infoCard: _buildStatisticsCard(context, currentVoteCount),
          searchHintText: AppLocalizations.of(context)!.searchProposals,
          onSearchChanged: (query) => ref.read(deletionProposalProvider.notifier).searchProposals(query),
          isMultiSelectMode: _isMultiSelectMode,
          selectedItemIds: _selectedProposalIds,
          onToggleMultiSelectMode: _toggleMultiSelectMode,
    onToggleItemSelection: (itemId) => _toggleItemSelection(itemId),
          onDeleteSelected: _deleteSelectedProposals,
          getItemId: (proposal) => proposal.phoneNumber,
        );
      },
    );
  }
  
  Widget _buildStatisticsCard(BuildContext context, int currentVoteCount) {
    final statistics = ref.watch(deletionProposalProvider.select((s) => s.statistics));
    return StatisticsCard(
      statistics: statistics,
      voteCount: currentVoteCount,
      onExchangeVip: currentVoteCount >= 10 ? () => _showVipExchangeDialog(context) : null,
    );
  }
  
  void _showCreateProposalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => CreateProposalDialog(
        onSubmit: (phoneNumber, reason, riskLevel) async {
          await ref.read(deletionProposalProvider.notifier).createProposal(phoneNumber, reason, riskLevel);
        },
      ),
    );
  }
  
  Future<void> _showVipExchangeDialog(BuildContext context) async {
    GoRouter.of(context).push('/vip-exchange');
    if (mounted) {
      await ref.read(deletionProposalProvider.notifier).refreshProposals();
    }
  }
  
  Widget _buildProposalCard(BuildContext context, Proposal proposal) {
    // 【核心修正】: 使用了【正确】的 Provider 名称 `deletionProposalProvider`。
    final notifier = ref.read(deletionProposalProvider.notifier);
    
    return ProposalCard(
      proposal: proposal,
      onVote: (proposalId, isApproval) async {
        try {
          await ref.read(deletionProposalStatisticsServiceProvider).recordVote(proposalId, isApproval);
          await notifier.voteOnProposal(proposalId: proposalId, support: isApproval);
          return true;
        } catch (e) {
          return false;
        }
      },
    );
  }

  Widget _buildHeaderContent(BuildContext context) {
    final theme = Theme.of(context);
    final noticeColor = Colors.amber;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      child: Card(
        color: noticeColor.shade50,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0), side: BorderSide(color: noticeColor.shade200, width: 1)),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: noticeColor.shade800, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.importantNoticeTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: noticeColor.shade900)),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.dataSourceDisclaimer, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black87, height: 1.5)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}