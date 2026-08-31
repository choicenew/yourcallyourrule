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
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: EliteDopamineTheme.softLilac.withValues(alpha: 0.12),
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
            // 顶部丁香多巴胺极光条
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              height: 4,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFC084FC), Color(0xFFA855F7), Color(0xFFEC4899)],
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
                              gradient: const LinearGradient(
                                colors: [Color(0xFFC084FC), Color(0xFFA855F7)],
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
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  if (pendingProposals > 0) ...[
                                    const SizedBox(width: 5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                                      decoration: BoxDecoration(
                                        color: EliteDopamineTheme.softLilac.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        '$pendingProposals',
                                        style: const TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w800,
                                          color: EliteDopamineTheme.softLilac,
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
                                  color: Colors.grey[600],
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
                          foregroundColor: const Color(0xFFA855F7),
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
                        color: const Color(0xFFFBF9F5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFEDE8DF),
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
                                  color: EliteDopamineTheme.vibrantCoral.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  firstProposal.highestRiskLevel.isNotEmpty ? firstProposal.highestRiskLevel : l10n.actionBlock,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: EliteDopamineTheme.vibrantCoral,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                l10n.agreeVotes(firstProposal.proposalCount),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            firstProposal.phoneNumber,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            firstProposal.reason.isNotEmpty ? firstProposal.reason : l10n.deletionProposalDescription,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
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
                                      backgroundColor: EliteDopamineTheme.freshMint,
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
                                      foregroundColor: Colors.grey[700],
                                      side: const BorderSide(
                                        color: Color(0xFFEDE8DF),
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
                                color: EliteDopamineTheme.freshMint.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.check_circle_rounded, color: EliteDopamineTheme.freshMint, size: 15),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${l10n.voteSubmitted}: $_votedAction',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: EliteDopamineTheme.freshMint,
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
                        color: const Color(0xFFFBF9F5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFEDE8DF),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFA855F7).withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.how_to_vote_outlined,
                              color: Color(0xFFA855F7),
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
                              color: Colors.grey[700],
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
                          color: Colors.grey[600],
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
        backgroundColor: EliteDopamineTheme.warmCanvasBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: EliteCommunityJudgeCard(),
          ),
        ),
      ),
    ),
  );
}
