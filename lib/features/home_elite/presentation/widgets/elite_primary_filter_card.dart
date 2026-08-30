// -----------------------------------------------------------------------------
// 文件: elite_primary_filter_card.dart
// 描述: Elite 一级拦截控制中心，提供直观的防护档位切换与卡槽规则直达。
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// ------------------- Widget 定义 -------------------

class ElitePrimaryFilterCard extends ConsumerStatefulWidget {
  const ElitePrimaryFilterCard({super.key});

  @override
  ConsumerState<ElitePrimaryFilterCard> createState() => _ElitePrimaryFilterCardState();
}

class _ElitePrimaryFilterCardState extends ConsumerState<ElitePrimaryFilterCard> {
  int _selectedDefenseLevel = 0; // 0: 智能防护, 1: 强力拦截, 2: 标记与静音

  void _navigateToFilterSettings() {
    context.push('/${AppRouter.filterSettings}');
  }

  void _navigateToSimSlotRules() {
    context.push('/${AppRouter.simSlotRuleWithAds}/0');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: EliteDopamineTheme.warmCardDecoration(
        context: context,
        glowColor: EliteDopamineTheme.sunsetTangerine,
      ),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题与管理跳转
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      gradient: EliteDopamineTheme.coralSunsetGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.tune_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.filterControlTitle,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        l10n.filterManagementDescription,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: _navigateToFilterSettings,
                icon: const Icon(Icons.settings_suggest_rounded, size: 15),
                label: Text(
                  l10n.advancedRuleSettingsTitle,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: EliteDopamineTheme.sunsetTangerine,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // 三大直观防御档位选择器（去折叠化一级 UI）
          Row(
            children: [
              Expanded(
                child: _buildDefenseOption(
                  index: 0,
                  title: l10n.smartFilterTitle,
                  subtitle: l10n.filterModeAuto,
                  icon: Icons.shield_rounded,
                  activeColor: EliteDopamineTheme.freshMint,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDefenseOption(
                  index: 1,
                  title: l10n.strictFilterTitle,
                  subtitle: l10n.filterModeStrict,
                  icon: Icons.gpp_bad_rounded,
                  activeColor: EliteDopamineTheme.vibrantCoral,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDefenseOption(
                  index: 2,
                  title: l10n.silenceModeTitle,
                  subtitle: l10n.filterModeSilence,
                  icon: Icons.notifications_paused_rounded,
                  activeColor: EliteDopamineTheme.warmSunAmber,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 底部当前生效策略简报与 SIM 卡快捷入口
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F5F0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  size: 15,
                  color: EliteDopamineTheme.sunsetTangerine,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _selectedDefenseLevel == 0
                        ? l10n.smartFilterDescription
                        : _selectedDefenseLevel == 1
                            ? l10n.strictFilterDescription
                            : l10n.silenceModeDescription,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                InkWell(
                  onTap: _navigateToSimSlotRules,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.sim_card_outlined, size: 13, color: EliteDopamineTheme.sunsetTangerine),
                        const SizedBox(width: 2),
                        Text(
                          l10n.simSlotRules,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: EliteDopamineTheme.sunsetTangerine,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefenseOption({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color activeColor,
  }) {
    final isSelected = _selectedDefenseLevel == index;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedDefenseLevel = index;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? activeColor.withValues(alpha: 0.12)
                : const Color(0xFFFBF9F5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? activeColor
                  : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? activeColor : Colors.grey[600],
                size: 22,
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: isSelected ? Colors.black87 : Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 1),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 8.5,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- Widget Previewer 支持 -------------------

@Preview(name: 'Primary Filter Card', group: 'Elite Showcase')
Widget previewElitePrimaryFilterCard() {
  return const ProviderScope(
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        backgroundColor: EliteDopamineTheme.warmCanvasBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: ElitePrimaryFilterCard(),
          ),
        ),
      ),
    ),
  );
}
