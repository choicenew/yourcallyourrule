// -----------------------------------------------------------------------------
// 文件: elite_community_judge_card.dart
// 描述: Elite 社区判官重点卡片，展示众包纠错提议并支持一键微互动投票。
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
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
    context.push('/${AppRouter.deletionProposal}');
  }

  @override
  Widget build(BuildContext context) {
    final asyncProposalStats = ref.watch(proposalStatisticsProvider);
    final l10n = AppLocalizations.of(context)!;

    final totalProposals = asyncProposalStats.value?['total'] ?? 18;
    final pendingProposals = asyncProposalStats.value?['pending'] ?? 6;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: EliteDopamineTheme.warmCardDecoration(
        context: context,
        glowColor: EliteDopamineTheme.warmSunAmber,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // 顶部多巴胺极光条
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              height: 4,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: EliteDopamineTheme.heroWarmGradient,
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
                              gradient: EliteDopamineTheme.heroWarmGradient,
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
                                  const SizedBox(width: 5),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: EliteDopamineTheme.vibrantCoral.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text(
                                      'HOT',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w900,
                                        color: EliteDopamineTheme.vibrantCoral,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '$pendingProposals ${l10n.pendingProposals}',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: _navigateToProposals,
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: EliteDopamineTheme.sunsetTangerine,
                        ),
                        tooltip: l10n.viewDetails,
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // 焦点提议互动卡片
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF9F5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: EliteDopamineTheme.warmSunAmber.withValues(alpha: 0.25),
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
                                l10n.actionBlock,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: EliteDopamineTheme.vibrantCoral,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              l10n.agreeVotes(88),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          '+86 195 **** 8821',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          l10n.deletionProposalDescription,
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
                                    side: BorderSide(
                                      color: Colors.grey[350]!,
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
                              l10n.viewDetails,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: EliteDopamineTheme.sunsetTangerine,
                              ),
                            ),
                            const Icon(Icons.chevron_right, size: 13, color: EliteDopamineTheme.sunsetTangerine),
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
