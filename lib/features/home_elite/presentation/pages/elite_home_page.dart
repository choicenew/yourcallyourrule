import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_app_bar.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_community_judge_card.dart';
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_hero_shield_card.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_primary_filter_card.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_quick_capsules.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_stats_insight_card.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// Elite 多巴胺极简主页
class EliteHomePage extends ConsumerStatefulWidget {
  const EliteHomePage({super.key});

  @override
  ConsumerState<EliteHomePage> createState() => _EliteHomePageState();
}

class _EliteHomePageState extends ConsumerState<EliteHomePage> {
  final int _currentNavIndex = 0;

  void _navigateToProHome() {
    context.goNamed(AppRouter.proHome);
  }

  void _handleNavTap(int index) {
    if (index == 0) return;
    AppRouter.navigateToTab(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            EliteAppBar(
              onSwitchToPro: _navigateToProHome,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  children: const [
                    EliteHeroShieldCard(),
                    ElitePrimaryFilterCard(),
                    EliteCommunityJudgeCard(),
                    EliteStatsInsightCard(),
                    EliteQuickCapsules(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentNavIndex,
        onTap: _handleNavTap,
      ),
    );
  }
}

@Preview(name: 'Elite Home Page', group: 'Elite Showcase')
Widget previewEliteHomePage() {
  return const ProviderScope(
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: EliteHomePage(),
    ),
  );
}
