import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:intl/intl.dart'; // 需要加入这个用于时间格式化，如果没有请忽略或手动格式化
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/deletion_proposal/models/proposal_history_item.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/test_sync_button.dart';
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


import 'package:yourcallyourrule/features/deletion_proposal/providers/my_proposal_history_provider.dart';

// 定义视图类型
enum ProposalViewType { public, mine }

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
  
  // 当前视图状态 (默认显示公共列表)
  ProposalViewType _currentViewType = ProposalViewType.public;
  // 我的历史记录搜索词
  String _myHistorySearchQuery = '';

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
    final proposalState = ref.watch(deletionProposalProvider);
    final voteCountStream = ref.watch(deletionProposalStatisticsServiceProvider).voteCountStream;

    return Scaffold(
      appBar: AppBar(
        title: _isMultiSelectMode 
          ? Text(AppLocalizations.of(context)!.selectedItems(_selectedProposalIds.length)) 
          : Text(AppLocalizations.of(context)!.deletionProposals),
        backgroundColor: Colors.deepPurple,
        leading: _isMultiSelectMode 
          ? IconButton(
              icon: const Icon(Icons.close),
              onPressed: _toggleMultiSelectMode,
            )
          : null,
        actions: _buildAppBarActions(context),
      ),
      body: StreamBuilder<int>(
        stream: voteCountStream,
        builder: (context, snapshot) {
          if (_currentViewType == ProposalViewType.public) {
            return _buildPublicProposalsView(context, proposalState);
          } else {
            return _buildMyHistoryView(context);
          }
        },
      ),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    final List<Widget> appBarActions = [];
    
    if (_isMultiSelectMode) {
      appBarActions.add(
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: _selectedProposalIds.isNotEmpty ? _deleteSelectedProposals : null,
          tooltip: AppLocalizations.of(context)!.deleteSelected,
        ),
      );
    } else {
      if (_currentViewType == ProposalViewType.public) {
        appBarActions.add(
          IconButton(
            icon: const Icon(Icons.analytics_outlined),
            onPressed: () => _showStatisticsDialog(0),
            tooltip: AppLocalizations.of(context)!.statistics,
          ),
        );
        
        appBarActions.add(
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: _options.hasActiveFilters ? Theme.of(context).colorScheme.primary : null,
            ),
            onPressed: _showFilterAndSortDialog,
            tooltip: AppLocalizations.of(context)!.filterAndSortTitle,
          ),
        );
      }
      
      if (_currentViewType == ProposalViewType.mine) {
        appBarActions.add(
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(myProposalHistoryProvider.future),
            tooltip: AppLocalizations.of(context)!.refresh,
          ),
        );
      }

      appBarActions.add(
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _showCreateProposalDialog(context),
          tooltip: AppLocalizations.of(context)!.add,
        ),
      );

      if (_currentViewType == ProposalViewType.public) {
        appBarActions.add(
          IconButton(
            icon: const Icon(Icons.select_all),
            onPressed: _toggleMultiSelectMode,
            tooltip: AppLocalizations.of(context)!.selectMultiple,
          ),
        );
      }
      
      appBarActions.add(
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showMoreOptions(context, 0),
          tooltip: AppLocalizations.of(context)!.moreOptions,
        ),
      );
    }
    return appBarActions;
  }

  Widget _buildPublicProposalsView(BuildContext context, dynamic proposalState) {
    final processedProposals = proposalState.proposals.where((proposal) {
      if (_options.status != null && proposal.status != _options.status) return false;
      if (_options.riskLevel != null && proposal.highestRiskLevel != _options.riskLevel) return false;
      if (_options.onlyVerifiedOwner == true && proposal.verifiedOwnerCount == 0) return false;
      return true;
    }).toList();

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

    return GenericListWithAdsPage<Proposal>(
      showAppBar: false,
      title: AppLocalizations.of(context)!.deletionProposals,
      items: processedProposals,
      itemBuilder: (context, proposal) => _buildProposalCard(context, proposal),
      adBuilder: () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
      adInterval: 3,
      emptyText: AppLocalizations.of(context)!.noProposalsFound,
      emptyIcon: Icons.how_to_vote_outlined,
      themeColor: Colors.deepPurple,
      isLoading: proposalState.isLoading,
      onRefresh: () => ref.read(deletionProposalProvider.notifier).refreshProposals(),
      infoCard: _buildHeaderContent(context),
      headerContent: _buildSegmentControl(),
      searchHintText: AppLocalizations.of(context)!.searchProposals,
      onSearchChanged: (query) => ref.read(deletionProposalProvider.notifier).searchProposals(query),
      isMultiSelectMode: _isMultiSelectMode,
      selectedItemIds: _selectedProposalIds,
      getItemId: (proposal) => proposal.phoneNumber,
      onToggleItemSelection: (itemId) => _toggleItemSelection(itemId),
      onAdd: null,
      customActions: null,
      onToggleMultiSelectMode: null,
      onDeleteSelected: null,
      onMoreOptions: null,
    );
  }

  Widget _buildMyHistoryView(BuildContext context) {
    final historyAsync = ref.watch(myProposalHistoryProvider);
    final List<MyProposalHistoryItem> allItems = historyAsync.value ?? [];

    final List<MyProposalHistoryItem> filteredItems = allItems.where((item) {
      if (_myHistorySearchQuery.isEmpty) return true;
      return item.phoneNumber.contains(_myHistorySearchQuery);
    }).toList();

    filteredItems.sort((a, b) => b.submissionTime.compareTo(a.submissionTime));

    return GenericListWithAdsPage<MyProposalHistoryItem>(
      showAppBar: false,
      title: AppLocalizations.of(context)!.proposalCreated,
      items: filteredItems,
      itemBuilder: (context, item) => _buildHistoryTile(context, item),
      adBuilder: () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
      adInterval: 4,
      emptyText: AppLocalizations.of(context)!.noProposalsFound,
      emptyIcon: Icons.history_edu_outlined,
      isLoading: historyAsync.isLoading,
      onRefresh: () => ref.refresh(myProposalHistoryProvider.future),
      infoCard: _buildHeaderContent(context),
      headerContent: _buildSegmentControl(),
      searchHintText: AppLocalizations.of(context)!.numberSearch,
      onSearchChanged: (query) => setState(() => _myHistorySearchQuery = query),
      isMultiSelectMode: false,
    );
  }
  
  // --- 新增：构建切换按钮 (Segment Control) ---
  // 这个 Widget 将被放置在你要求的“绿色圈圈”位置
  Widget _buildSegmentControl() {
    final isPublic = _currentViewType == ProposalViewType.public;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _currentViewType = ProposalViewType.public;
                    // 切换回 Public 时关闭多选
                    if (_isMultiSelectMode) _isMultiSelectMode = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isPublic ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: isPublic ? [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 6, offset: const Offset(0, 2))] : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.deletionProposals,
                    style: TextStyle(
                      fontWeight: isPublic ? FontWeight.w900 : FontWeight.w600,
                      color: isPublic ? const Color(0xFFFF9500) : Colors.grey[700],
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _currentViewType = ProposalViewType.mine),
                child: Container(
                  decoration: BoxDecoration(
                    color: !isPublic ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: !isPublic ? [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 6, offset: const Offset(0, 2))] : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.proposalCreated,
                    style: TextStyle(
                      fontWeight: !isPublic ? FontWeight.w900 : FontWeight.w600,
                      color: !isPublic ? const Color(0xFFFF9500) : Colors.grey[700],
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // --- 构建 My History 列表项 ---
  Widget _buildHistoryTile(BuildContext context, MyProposalHistoryItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFF9500).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.history_rounded, color: Color(0xFFFF9500), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.phoneNumber,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded, size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat.yMMMd().add_jm().format(item.submissionTime),
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                if (item.status == MyProposalStatus.underReview) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Votes: ${item.currentVotes} • Risk: ${item.highestRiskLevel}',
                    style: const TextStyle(
                      color: Color(0xFFFF9500),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F5F0),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFEDE8DF)),
            ),
            child: Text(
              item.status.name,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
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
    context.pushNamed(AppRouter.vipExchange);
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
    final l10n = AppLocalizations.of(context)!;
    const noticeColor = Colors.deepPurple;

    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: noticeColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: noticeColor.withValues(alpha: 0.15),
          width: 1.1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: noticeColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: noticeColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.importantNoticeTitle,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: noticeColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.dataSourceDisclaimer,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black87,
                    height: 1.4,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}