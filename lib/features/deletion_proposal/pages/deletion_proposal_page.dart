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
  bool _isMultiSelectMode = false;
  Set<String> _selectedProposalIds = {};

  @override
  void initState() {
    super.initState();
    // 初始化统计服务
    _statisticsService = DeletionProposalStatisticsService(
      ref.read(labelMarkStatisticsRepositoryProvider)
    );
  }

  void _toggleMultiSelectMode() {
    setState(() {
      _isMultiSelectMode = !_isMultiSelectMode;
      if (!_isMultiSelectMode) {
        _selectedProposalIds = {};
      }
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
    // Implement deletion logic here
    // For example:
    // await ref.read(deletionProposalProvider.notifier).deleteProposalsByIds(_selectedProposalIds);
    // After deletion, reset multi-select mode and clear selected items
    setState(() {
      _selectedProposalIds = {};
      _isMultiSelectMode = false;
    });
    await ref.read(deletionProposalProvider.notifier).refreshProposals();
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
          headerContent: _buildHeaderContent(context),
          infoCard: _buildStatisticsCard(currentVoteCount),
          searchHintText: AppLocalizations.of(context)!.searchProposals,
          onSearchChanged: (query) {
            ref.read(deletionProposalProvider.notifier).searchProposals(query);
          },
          isMultiSelectMode: _isMultiSelectMode,
          selectedItemIds: _selectedProposalIds,
          onToggleMultiSelectMode: _toggleMultiSelectMode,
          onToggleItemSelection: _toggleItemSelection,
          onDeleteSelected: _deleteSelectedProposals,
          getItemId: (proposal) => proposal.id,
        );
      },
    );
  }
  
  Widget _buildStatisticsCard(int currentVoteCount) {
    return StatisticsCard(
      voteCount: currentVoteCount,
      onExchangeVip: currentVoteCount >= 10 
        ? () => _showVipExchangeDialog(context, currentVoteCount)
        : null,
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

/// 用于向用户说明数据来源和应用的局限性
Widget _buildHeaderContent(BuildContext context) {
  // 获取当前主题颜色，用于UI元素的配色
  final theme = Theme.of(context);
  final noticeColor = Colors.amber; // 您可以根据您的App风格选择颜色，如 Colors.blue, Colors.orange等

  return Padding(
    // 为卡片添加外边距
    padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
    child: Card(
      // 设置卡片的背景色，使用浅色调
      color: noticeColor.shade50,
      // 设置卡片的阴影
      elevation: 2,
      // 设置卡片的形状和边框
      shape: RoundedRectangleBorder(
        // 设置圆角
        borderRadius: BorderRadius.circular(12.0),
        // 设置边框颜色，使其与背景色协调
        side: BorderSide(color: noticeColor.shade200, width: 1),
      ),
      // 使用 ClipRRect 来确保子组件不会超出圆角范围
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // 顶部对齐
          children: [
            // 左侧的提示图标
            Icon(
              Icons.info_outline,
              color: noticeColor.shade800, // 使用深色调以保证清晰度
              size: 24,
            ),
            const SizedBox(width: 16), // 图标和文字之间的间距
            // 右侧的文字内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 左对齐
                children: [
                  // 标题
                  Text(
                    AppLocalizations.of(context)!.importantNoticeTitle, // 使用本地化
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: noticeColor.shade900, // 标题颜色更深
                    ),
                  ),
                  const SizedBox(height: 8), // 标题和正文之间的间距
                  // 详细说明
                  Text(
                    AppLocalizations.of(context)!.dataSourceDisclaimer, // 使用本地化
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black87, // 正文颜色
                      height: 1.5, // 增加行高，提升可读性
                    ),
                  ),
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