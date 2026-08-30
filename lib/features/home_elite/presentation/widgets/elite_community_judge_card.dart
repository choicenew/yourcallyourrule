import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/statistics_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class EliteCommunityJudgeCard extends ConsumerStatefulWidget {
  const EliteCommunityJudgeCard({super.key});

  @override
  ConsumerState<EliteCommunityJudgeCard> createState() => _EliteCommunityJudgeCardState();
}

class _EliteCommunityJudgeCardState extends ConsumerState<EliteCommunityJudgeCard> {
  bool _hasVoted = false;
  String _votedAction = '';

  @override
  Widget build(BuildContext context) {
    final asyncProposalStats = ref.watch(proposalStatisticsProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final totalProposals = asyncProposalStats.value?['total'] ?? 18;
    final pendingProposals = asyncProposalStats.value?['pending'] ?? 6;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: EliteDopamineTheme.dopamineCardDecoration(
        context: context,
        glowColor: EliteDopamineTheme.electricViolet,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // 多巴胺背景极光流
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              height: 5,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: EliteDopamineTheme.communityHeroGradient,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
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
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: EliteDopamineTheme.communityHeroGradient,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.how_to_vote_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    l10n?.deletionProposals ?? 'Community Shield Judge',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: EliteDopamineTheme.sunsetOrange.withValues(alpha: 0.18),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'HOT',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w900,
                                        color: isDark ? Colors.amber[300] : Colors.amber[900],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '$pendingProposals active votes waiting for community decisions',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => context.push('/deletion-proposal'),
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: EliteDopamineTheme.neonCyan,
                        ),
                        tooltip: 'View all proposals',
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 焦点提议互动卡片（多巴胺极速微投票）
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.04)
                          : Colors.grey[50],
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.grey[200]!,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: EliteDopamineTheme.coralPink.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Marked as Telemarketing',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: EliteDopamineTheme.coralPink,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '88% Agree',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: isDark ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '+86 195 **** 8821',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Community proposed to remove tag: "Delivery Courier Service (Wrongly Reported)"',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // 多巴胺投票互动按钮
                        if (!_hasVoted)
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _hasVoted = true;
                                      _votedAction = 'Support Delete';
                                    });
                                  },
                                  icon: const Icon(Icons.thumb_up_rounded, size: 14),
                                  label: const Text('Agree Delete', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: EliteDopamineTheme.emeraldGreen,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _hasVoted = true;
                                      _votedAction = 'Keep Tag';
                                    });
                                  },
                                  icon: const Icon(Icons.thumb_down_alt_rounded, size: 14),
                                  label: const Text('Keep Tag', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: isDark ? Colors.grey[300] : Colors.grey[700],
                                    side: BorderSide(
                                      color: isDark ? Colors.white24 : Colors.grey[400]!,
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
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
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: EliteDopamineTheme.emeraldGreen.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.check_circle_rounded, color: EliteDopamineTheme.emeraldGreen, size: 16),
                                const SizedBox(width: 6),
                                Text(
                                  'Thank you! Voted: $_votedAction (+10 Points)',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: EliteDopamineTheme.emeraldGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 底部众包指标
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Community Decisions: $totalProposals',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      InkWell(
                        onTap: () => context.push('/deletion-proposal'),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Explore All',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: EliteDopamineTheme.neonCyan,
                              ),
                            ),
                            Icon(Icons.chevron_right, size: 14, color: EliteDopamineTheme.neonCyan),
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
