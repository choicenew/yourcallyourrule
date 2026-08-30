import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_app_bar.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_community_judge_card.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_floating_nav_bar.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_hero_shield_card.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_primary_filter_card.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_quick_capsules.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_stats_insight_card.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';

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
      backgroundColor: EliteDopamineTheme.warmCanvasBackground,
      body: SafeArea(
        child: Column(
          children: [
            EliteAppBar(
              onSwitchToPro: () {
                context.go('/pro-home');
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
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: EliteFloatingNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          EliteFloatingNavBar.handleEliteNavigation(context, index);
        },
      ),
    );
  }
}

@Preview(name: 'Elite Home Page (Full)', group: 'Elite Home')
Widget previewEliteHomePage() {
  return const ProviderScope(
    child: MaterialApp(
      home: EliteHomePage(),
    ),
  );
}
