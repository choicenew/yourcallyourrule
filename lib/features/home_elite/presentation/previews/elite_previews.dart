import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/pages/elite_home_page.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_app_bar.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_community_judge_card.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_hero_shield_card.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_primary_filter_card.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_quick_capsules.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/elite_stats_insight_card.dart';

/// Elite 组件独立预览展示脚手架（可在 Widget Previewer 或测试容器中独立渲染）
class ElitePreviewWrapper extends StatelessWidget {
  final Widget child;
  final Brightness brightness;

  const ElitePreviewWrapper({
    super.key,
    required this.child,
    this.brightness = Brightness.dark,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        themeMode: brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(0xFFF6F8FA),
          fontFamily: 'Roboto',
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF12121E),
          fontFamily: 'Roboto',
        ),
        home: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

// --- 各组件独立渲染预览入口 ---

Widget previewEliteFullPageDark() => const ElitePreviewWrapper(
      brightness: Brightness.dark,
      child: EliteHomePage(),
    );

Widget previewEliteFullPageLight() => const ElitePreviewWrapper(
      brightness: Brightness.light,
      child: EliteHomePage(),
    );

Widget previewEliteHeroCard() => const ElitePreviewWrapper(
      child: EliteHeroShieldCard(),
    );

Widget previewElitePrimaryFilter() => const ElitePreviewWrapper(
      child: ElitePrimaryFilterCard(),
    );

Widget previewEliteCommunityJudge() => const ElitePreviewWrapper(
      child: EliteCommunityJudgeCard(),
    );

Widget previewEliteStatsInsight() => const ElitePreviewWrapper(
      child: EliteStatsInsightCard(),
    );

Widget previewEliteQuickCapsules() => const ElitePreviewWrapper(
      child: EliteQuickCapsules(),
    );
