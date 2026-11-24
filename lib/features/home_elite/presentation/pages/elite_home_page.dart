import 'package:material_ui/material_ui.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import '../widgets/elite_app_bar.dart';
import '../widgets/elite_community_judge_card.dart';
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';
import '../widgets/elite_hero_shield_card.dart';
import '../widgets/elite_primary_filter_card.dart';
import '../widgets/elite_quick_capsules.dart';
import '../widgets/elite_stats_insight_card.dart';
import 'package:yourcallyourrule/features/phone_evaluators/presentation/widgets/expected_call_card.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

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
                  children: [
                    const EliteHeroShieldCard(),
                    const ExpectedCallCard(),
                    const ElitePrimaryFilterCard(),
                    const EliteCommunityJudgeCard(),
                    const EliteStatsInsightCard(),
                    const EliteQuickCapsules(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'rule_library_setup_fab',
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 4,
        tooltip: AppLocalizations.of(context).ruleStoreTitle,
        onPressed: () => context.pushNamed(AppRouter.initialSetup),
        icon: const Icon(Icons.storefront_rounded),
        label: Text(
          AppLocalizations.of(context).ruleStoreTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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
