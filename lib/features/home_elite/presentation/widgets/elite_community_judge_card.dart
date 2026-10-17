// -----------------------------------------------------------------------------
// 文件: elite_community_judge_card.dart
// 描述: Elite 社区判官重点卡片，展示众包纠错提议并支持一键微互动投票。
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/statistics_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// ------------------- Widget 定义 -------------------

class EliteCommunityJudgeCard extends ConsumerStatefulWidget {
  const EliteCommunityJudgeCard({super.key});

  @override
  ConsumerState<EliteCommunityJudgeCard> createState() => _EliteCommunityJudgeCardState();
}

class _EliteCommunityJudgeCardState extends ConsumerState<EliteCommunityJudgeCard> {
  bool _hasVoted = false;
  String _votedAction = '';

  void _navigateToProposals() {
    context.pushNamed(AppRouter.deletionProposal);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final asyncProposalStats = ref.watch(proposalStatisticsProvider);
    final proposalState = ref.watch(deletionProposalProvider);
    final l10n = AppLocalizations.of(context)!;

    final stats = asyncProposalStats.value ?? proposalState.statistics;
    final totalProposals = stats['total'] ?? 0;
    final pendingProposals = stats['pending'] ?? 0;
    final Proposal? firstProposal = proposalState.proposals.isNotEmpty ? proposalState.proposals.first : null;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: theme.colorScheme.secondary.withValues(alpha: 0.12),
            blurRadius: 24,
            spreadRadius: 1,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // 顶部极光条
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              height: 4,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [theme.colorScheme.secondary, theme.colorScheme.primary, theme.colorScheme.tertiary],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 顶部：徽章 + 标题 + 查看全部
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [theme.colorScheme.secondary, theme.colorScheme.primary],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.how_to_vote_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    l10n.deletionProposals,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  if (pendingProposals > 0) ...[
                                    const SizedBox(width: 5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.secondary.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        '$pendingProposals',
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w800,
                                          color: theme.colorScheme.secondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              Text(
                                '${l10n.pendingProposals}: $pendingProposals',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      TextButton.icon(
                        onPressed: _navigateToProposals,
                        icon: const Icon(Icons.arrow_forward_ios_rounded, size: 12),
                        label: Text(
                          l10n.viewDetails,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: theme.colorScheme.secondary,
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // 真实焦点提议互动卡片 / 精美空状态占位
                  if (firstProposal != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.error.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  firstProposal.highestRiskLevel.getLocalizedLabel(context),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.error,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                l10n.agreeVotes(firstProposal.proposalCount),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            firstProposal.phoneNumber,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            firstProposal.reason.isNotEmpty ? firstProposal.reason : l10n.deletionProposalDescription,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // 多巴胺投票互动按钮
                          if (!_hasVoted)
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      ref.read(deletionProposalProvider.notifier).voteOnProposal(
                                        proposalId: firstProposal.phoneNumber,
                                        support: true,
                                      );
                                      setState(() {
                                        _hasVoted = true;
                                        _votedAction = l10n.voteAgree;
                                      });
                                    },
                                    icon: const Icon(Icons.thumb_up_rounded, size: 14),
                                    label: Text(
                                      l10n.voteAgree,
                                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.colorScheme.tertiary,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      ref.read(deletionProposalProvider.notifier).voteOnProposal(
                                        proposalId: firstProposal.phoneNumber,
                                        support: false,
                                      );
                                      setState(() {
                                        _hasVoted = true;
                                        _votedAction = l10n.voteDisagree;
                                      });
                                    },
                                    icon: const Icon(Icons.thumb_down_alt_rounded, size: 14),
                                    label: Text(
                                      l10n.voteDisagree,
                                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: theme.colorScheme.onSurfaceVariant,
                                      side: BorderSide(
                                        color: theme.colorScheme.outlineVariant,
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.tertiary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_circle_rounded, color: theme.colorScheme.tertiary, size: 15),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${l10n.voteSubmitted}: $_votedAction',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.tertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    )
                  else
                    // 精美多巴胺空状态占位
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.how_to_vote_outlined,
                              color: theme.colorScheme.secondary,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.deletionProposalDescription,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 10),

                  // 底部众包指标
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${l10n.totalProposals}: $totalProposals',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      InkWell(
                        onTap: _navigateToProposals,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              l10n.communityVotes,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFA855F7),
                              ),
                            ),
                            const Icon(Icons.chevron_right, size: 13, color: Color(0xFFA855F7)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- Widget Previewer 支持 -------------------

@Preview(name: 'Community Judge Card', group: 'Elite Showcase')
Widget previewEliteCommunityJudgeCard() {
  return const ProviderScope(
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: EliteCommunityJudgeCard(),
          ),
        ),
      ),
    ),
  );
}
