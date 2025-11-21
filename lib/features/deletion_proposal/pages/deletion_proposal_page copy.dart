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

// 【MODIFIED】: 引入了新的状态管理类
import 'package:yourcallyourrule/features/deletion_proposal/models/proposal_list_options.dart';

class DeletionProposalPage extends ConsumerStatefulWidget {
  const DeletionProposalPage({super.key});

  @override
  ConsumerState<DeletionProposalPage> createState() => _DeletionProposalPageState();
}

class _DeletionProposalPageState extends ConsumerState<DeletionProposalPage> {
  bool _isMultiSelectMode = false;
  Set<String> _selectedProposalIds = {};

  // 【MODIFIED】: 使用统一的 `ProposalListOptions` 来管理所有筛选和排序状态。
  ProposalListOptions _options = const ProposalListOptions();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(deletionProposalProvider.notifier).refreshProposals());
  }

  // --- 多选逻辑 (保持不变) ---
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
  
  // =======================================================================
  // 【核心修正】: 提供了功能更丰富的筛选/排序对话框。
  // =======================================================================

  /// 显示筛选与排序对话框
  void _showFilterAndSortDialog() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        // 使用 StatefulWidget 来让 BottomSheet 内部可以管理临时状态
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 排序部分
                    Text(AppLocalizations.of(context)!.sortBy, style: Theme.of(context).textTheme.titleMedium),
                    RadioListTile<ProposalSortType>(
                      title: Text(AppLocalizations.of(context)!.sortNewest),
                      value: ProposalSortType.newest,
                      groupValue: _options.sortType,
                      onChanged: (val) => setSheetState(() => setState(() => _options = _options.copyWith(sortType: val))),
                    ),
                    RadioListTile<ProposalSortType>(
                      title: Text(AppLocalizations.of(context)!.sortOldest),
                      value: ProposalSortType.oldest,
                      groupValue: _options.sortType,
                      onChanged: (val) => setSheetState(() => setState(() => _options = _options.copyWith(sortType: val))),
                    ),
                    RadioListTile<ProposalSortType>(
                      title: Text(AppLocalizations.of(context)!.sortMostPopular),
                      value: ProposalSortType.mostPopular,
                      groupValue: _options.sortType,
                      onChanged: (val) => setSheetState(() => setState(() => _options = _options.copyWith(sortType: val))),
                    ),
                    RadioListTile<ProposalSortType>(
                      title: Text(AppLocalizations.of(context)!.sortLeastPopular),
                      value: ProposalSortType.leastPopular,
                      groupValue: _options.sortType,
                      onChanged: (val) => setSheetState(() => setState(() => _options = _options.copyWith(sortType: val))),
                    ),
                    const Divider(),
                    // 筛选部分
                    Text(AppLocalizations.of(context)!.filterBy, style: Theme.of(context).textTheme.titleMedium),
                    SwitchListTile(
                      title: Text(AppLocalizations.of(context)!.filterVerifiedOwner),
                      value: _options.onlyVerifiedOwner ?? false,
                      onChanged: (val) => setSheetState(() => setState(() => _options = _options.copyWith(onlyVerifiedOwner: val))),
                    ),
                    // 更多筛选选项可以继续添加...
                    const Divider(),
                    // 操作按钮
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() => _options = _options.clearFilters());
                            Navigator.pop(ctx);
                          },
                          child: Text(AppLocalizations.of(context)!.clearFilter),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: Text(AppLocalizations.of(context)!.apply),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  
  /// 显示统计信息的弹窗 (保持不变)
  void _showStatisticsDialog(int currentVoteCount) {
    showDialog(
      context: context,
      builder: (context) {
        final statistics = ref.watch(deletionProposalProvider.select((s) => s.statistics));
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          content: SingleChildScrollView(
            child: StatisticsCard(
              statistics: statistics,
              voteCount: currentVoteCount,
              onExchangeVip: currentVoteCount >= 10 ? () => _showVipExchangeDialog(context) : null,
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)!.closeButton)),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // =======================================================================
    // 【核心修正】: 使用了【正确】的 Provider 名称 `deletionProposalProvider`。
    // REASON: 这是由 @riverpod 为 DeletionProposalNotifier 自动生成的正确名称。
    // =======================================================================
    final proposalState = ref.watch(deletionProposalProvider);
    final voteCountStream = ref.watch(deletionProposalStatisticsServiceProvider).voteCountStream;

    // 【MODIFIED】: 筛选和排序逻辑现在都在这里集中处理。
    final processedProposals = proposalState.proposals.where((proposal) {
      if (_options.status != null && proposal.status != _options.status) return false;
      if (_options.riskLevel != null && proposal.highestRiskLevel != _options.riskLevel) return false;
      if (_options.onlyVerifiedOwner == true && proposal.verifiedOwnerCount == 0) return false;
      return true;
    }).toList();

    // 应用排序
    processedProposals.sort((a, b) {
      switch (_options.sortType) {
        case ProposalSortType.newest:
          return b.proposalStartTime.compareTo(a.proposalStartTime);
        case ProposalSortType.oldest:
          return a.proposalStartTime.compareTo(b.proposalStartTime);
        case ProposalSortType.mostPopular:
          return b.proposalCount.compareTo(a.proposalCount);
        case ProposalSortType.leastPopular:
          return a.proposalCount.compareTo(b.proposalCount);
      }
    });

    return StreamBuilder<int>(
      stream: voteCountStream,
      builder: (context, snapshot) {
        final currentVoteCount = snapshot.data ?? 0;
        
        return GenericListWithAdsPage<Proposal>(
          title: AppLocalizations.of(context)!.deletionProposals,
          items: processedProposals, // 使用处理后的列表
          itemBuilder: (context, proposal) => _buildProposalCard(context, proposal),
          adBuilder: () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
          adInterval: 3,
          emptyText: AppLocalizations.of(context)!.noProposalsFound,
          emptyIcon: Icons.how_to_vote_outlined,
          themeColor: Colors.deepPurple,
          isLoading: proposalState.isLoading,
          onRefresh: () => ref.read(deletionProposalProvider.notifier).refreshProposals(),
          onAdd: () => _showCreateProposalDialog(context),
          
          // 【MODIFIED】: 使用 `customActions` 提供快捷操作按钮。
          customActions: [
            IconButton(
              icon: const Icon(Icons.analytics_outlined),
              onPressed: () => _showStatisticsDialog(currentVoteCount),
              tooltip: AppLocalizations.of(context)!.statistics,
            ),
            IconButton(
              icon: Icon(
                Icons.filter_list,
                color: _options.hasActiveFilters ? Theme.of(context).colorScheme.primary : null,
              ),
              onPressed: _showFilterAndSortDialog,
              tooltip: AppLocalizations.of(context)!.filterAndSortTitle,
            ),
          ],

          headerContent: _buildHeaderContent(context),
          //infoCard: _buildStatisticsCard(context, currentVoteCount),
          searchHintText: AppLocalizations.of(context)!.searchProposals,
          onSearchChanged: (query) => ref.read(deletionProposalProvider.notifier).searchProposals(query),
          isMultiSelectMode: _isMultiSelectMode,
          selectedItemIds: _selectedProposalIds,
          onToggleMultiSelectMode: _toggleMultiSelectMode,
          onToggleItemSelection: (itemId) => _toggleItemSelection(itemId),
          onDeleteSelected: _deleteSelectedProposals,
          getItemId: (proposal) => proposal.phoneNumber,
                onMoreOptions: () => _showMoreOptions(context, currentVoteCount),
        );
      },
    );
  }
  

  void _showMoreOptions(BuildContext context, int currentVoteCount) {
     
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.filter_list),
            title: Text(AppLocalizations.of(context)!.statistics),
            onTap: () {
              Navigator.pop(context);
              _showStatisticsDialog(currentVoteCount);
            },
          ),
        ],
      ),
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