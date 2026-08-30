// -----------------------------------------------------------------------------
// 文件: elite_home_page.dart
// 描述: Elite 多巴胺极简主页，聚焦实时安全状态、一级拦截控制与社区判官投票。
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_app_bar.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_community_judge_card.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_floating_nav_bar.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_hero_shield_card.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_primary_filter_card.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_quick_capsules.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_stats_insight_card.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// ------------------- Widget 定义 -------------------

class EliteHomePage extends ConsumerStatefulWidget {
  const EliteHomePage({super.key});

  @override
  ConsumerState<EliteHomePage> createState() => _EliteHomePageState();
}

class _EliteHomePageState extends ConsumerState<EliteHomePage> {
  int _currentNavIndex = 0;

  void _navigateToProHome() {
    context.go('/${AppRouter.proHome}');
  }

  void _handleNavTap(int index) {
    if (_currentNavIndex == index) return;
    setState(() {
      _currentNavIndex = index;
    });
    EliteFloatingNavBar.handleEliteNavigation(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EliteDopamineTheme.warmCanvasBackground,
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
      bottomNavigationBar: EliteFloatingNavBar(
        currentIndex: _currentNavIndex,
        onTap: _handleNavTap,
      ),
    );
  }
}

// ------------------- Widget Previewer 支持 -------------------

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
