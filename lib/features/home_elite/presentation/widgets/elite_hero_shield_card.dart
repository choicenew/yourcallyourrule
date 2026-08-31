// -----------------------------------------------------------------------------
// 文件: elite_hero_shield_card.dart
// 描述: Elite 能量脉冲防护盾牌卡片，集成安全指示、今日拦截指标与极速查号验证。
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/home/di/home_stats_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// ------------------- Widget 定义 -------------------

class EliteHeroShieldCard extends ConsumerStatefulWidget {
  const EliteHeroShieldCard({super.key});

  @override
  ConsumerState<EliteHeroShieldCard> createState() => _EliteHeroShieldCardState();
}

class _EliteHeroShieldCardState extends ConsumerState<EliteHeroShieldCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearchSubmit(String query) {
    final trimmed = query.trim();
    if (trimmed.isNotEmpty) {
      context.pushNamed(AppRouter.search, extra: trimmed);
    } else {
      context.pushNamed(AppRouter.verificationPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncStats = ref.watch(homeStatsProvider);
    final l10n = AppLocalizations.of(context)!;

    final blockedToday = asyncStats.value?.todayBlocked ?? 0;
    final totalRules = asyncStats.value?.totalRules ?? 0;

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
            color: EliteDopamineTheme.freshMint.withValues(alpha: 0.08),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // 柔和多巴胺光晕装饰
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: EliteDopamineTheme.skyAzure.withValues(alpha: 0.10),
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              left: -40,
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: EliteDopamineTheme.freshMint.withValues(alpha: 0.12),
                ),
              ),
            ),

            // 主体内容
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 上部：能量盾 + 防护引擎状态（去除与 App Bar 重复的标题）
                  Row(
                    children: [
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF2DD4BF), Color(0xFF10B981)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: EliteDopamineTheme.freshMint.withValues(alpha: 0.35),
                                    blurRadius: 16,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.verified_user_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: EliteDopamineTheme.freshMint.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.bolt_rounded,
                                    size: 13,
                                    color: EliteDopamineTheme.freshMint,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    l10n.enabledStatus,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      color: EliteDopamineTheme.freshMint,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              l10n.smartCallerId,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n.callFilterRulesDescription,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 中部：今日拦截与规则总数指标
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricTile(
                          label: l10n.blockedCalls,
                          value: '$blockedToday',
                          icon: Icons.shield_outlined,
                          accentColor: EliteDopamineTheme.vibrantCoral,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildMetricTile(
                          label: l10n.phoneRuleManagement,
                          value: '$totalRules',
                          icon: Icons.rule_folder_outlined,
                          accentColor: EliteDopamineTheme.sunsetTangerine,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // 底部：极速查号搜索框
                  Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F5F0),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: l10n.enterPhoneNumberToStartSearch,
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          size: 18,
                          color: EliteDopamineTheme.warmSunAmber,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 18,
                            color: EliteDopamineTheme.sunsetTangerine,
                          ),
                          onPressed: () => _handleSearchSubmit(_searchController.text),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      onSubmitted: _handleSearchSubmit,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile({
    required String label,
    required String value,
    required IconData icon,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF9F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accentColor, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------- Widget Previewer 支持 -------------------

@Preview(name: 'Hero Shield Card', group: 'Elite Showcase')
Widget previewEliteHeroShieldCard() {
  return const ProviderScope(
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        backgroundColor: EliteDopamineTheme.warmCanvasBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: EliteHeroShieldCard(),
          ),
        ),
      ),
    ),
  );
}
