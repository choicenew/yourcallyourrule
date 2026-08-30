import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_app_bar.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_community_judge_card.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_hero_shield_card.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_primary_filter_card.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_quick_capsules.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_stats_insight_card.dart';

class EliteHomePage extends ConsumerStatefulWidget {
  const EliteHomePage({super.key});

  @override
  ConsumerState<EliteHomePage> createState() => _EliteHomePageState();
}

class _EliteHomePageState extends ConsumerState<EliteHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            EliteAppBar(
              onSwitchToPro: () {
                context.go('/');
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: const [
                    EliteHeroShieldCard(),
                    ElitePrimaryFilterCard(),
                    EliteCommunityJudgeCard(),
                    EliteStatsInsightCard(),
                    EliteQuickCapsules(),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          BottomNavigationHandler.handleNavigation(context, index);
        },
      ),
    );
  }
}
