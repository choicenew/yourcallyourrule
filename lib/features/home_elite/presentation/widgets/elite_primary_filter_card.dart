// -----------------------------------------------------------------------------
// 文件: elite_primary_filter_card.dart
// 描述: Elite 基础过滤规则高质感控制卡片（已完全解耦拆分，保持主文件清爽连贯）。
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/call/call_filter/config/call_filter_config.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/primary_filter/defense_strategy_item.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/primary_filter/primary_filter_advanced_section.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/primary_filter/primary_filter_daily_grid.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/primary_filter/primary_filter_header.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/primary_filter/primary_filter_info_banner.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/primary_filter/primary_filter_master_section.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/primary_filter/primary_filter_sim_bar.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// ------------------- ElitePrimaryFilterCard 模块协调主卡片 -------------------

class ElitePrimaryFilterCard extends ConsumerStatefulWidget {
  const ElitePrimaryFilterCard({super.key});

  @override
  ConsumerState<ElitePrimaryFilterCard> createState() => _ElitePrimaryFilterCardState();
}

class _ElitePrimaryFilterCardState extends ConsumerState<ElitePrimaryFilterCard> {
  int _selectedDefenseIndex = 0;
  int _selectedSimSlot = 0;
  bool _showAdvancedSettings = false;

  void _navigateToFilterSettings() {
    context.pushNamed(AppRouter.filterSettings);
  }

  void _navigateToSimSlotRules() {
    context.pushNamed(
      AppRouter.simSlotRuleWithAds,
      pathParameters: {'simSlotIndex': '$_selectedSimSlot'},
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final separateSims = ref.watch(separateSimsProvider).value ?? false;

    // 当开启分卡槽控制时，根据当前选中的卡槽读取对应卡槽的 CallFilterConfig；否则读取全局配置
    final callConfig = separateSims
        ? ref.watch(simSlotCallFilterConfigProvider(_selectedSimSlot).select((v) => v.value))
        : ref.watch(callFilterConfigProvider.select((v) => v.value));

    void updateCurrentConfig(CallFilterConfig newConfig) {
      if (separateSims) {
        ref.read(simSlotCallFilterConfigProvider(_selectedSimSlot).notifier).updateConfig(newConfig);
      } else {
        ref.read(callFilterConfigProvider.notifier).updateConfig(newConfig);
      }
    }

    final dailyDefenseOptions = [
      DefenseStrategyItem(
        index: 0,
        title: l10n.allowAllowedNumbers,
        subtitle: l10n.allowAllowedNumbersDesc,
        detailedDesc: l10n.allowAllowedNumbersDesc,
        icon: Icons.shield_rounded,
        activeColor: theme.colorScheme.secondary,
        isEnabled: callConfig?.allowAllAllowedNumbers ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            updateCurrentConfig(callConfig.copyWith(allowAllAllowedNumbers: val));
          }
        },
      ),
      DefenseStrategyItem(
        index: 1,
        title: l10n.allowRegexBlockRules,
        subtitle: l10n.allowRegexBlockRulesDesc,
        detailedDesc: l10n.allowRegexBlockRulesDesc,
        icon: Icons.gpp_bad_rounded,
        activeColor: theme.colorScheme.error,
        isEnabled: callConfig?.allowRegexBlockRules ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            updateCurrentConfig(callConfig.copyWith(allowRegexBlockRules: val));
          }
        },
      ),
      DefenseStrategyItem(
        index: 2,
        title: l10n.enableMuteRules,
        subtitle: l10n.enableMuteRulesDesc,
        detailedDesc: l10n.enableMuteRulesDesc,
        icon: Icons.notifications_paused_rounded,
        activeColor: theme.colorScheme.tertiary,
        isEnabled: callConfig?.allowSilenceRules ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            updateCurrentConfig(callConfig.copyWith(allowSilenceRules: val));
          }
        },
      ),
      DefenseStrategyItem(
        index: 3,
        title: l10n.enableNoneActionRules,
        subtitle: l10n.enableNoneActionRulesDesc,
        detailedDesc: l10n.enableNoneActionRulesDesc,
        icon: Icons.visibility_rounded,
        activeColor: theme.colorScheme.primary,
        isEnabled: callConfig?.allowNoneRules ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            updateCurrentConfig(callConfig.copyWith(allowNoneRules: val));
          }
        },
      ),
      DefenseStrategyItem(
        index: 4,
        title: l10n.rejectAllNumbers,
        subtitle: l10n.rejectAllNumbersDesc,
        detailedDesc: l10n.rejectAllNumbersDesc,
        icon: Icons.remove_circle_rounded,
        activeColor: theme.colorScheme.error,
        isEnabled: callConfig?.rejectAllNumbers ?? false,
        onToggle: (val) {
          if (callConfig != null) {
            updateCurrentConfig(callConfig.copyWith(rejectAllNumbers: val));
          }
        },
      ),
    ];

    final masterOverrideOptions = [
      DefenseStrategyItem(
        index: 5,
        title: l10n.allowAllAllowRules,
        subtitle: l10n.allowAllAllowRulesDesc,
        detailedDesc: l10n.allowAllAllowRulesDesc,
        icon: Icons.settings_rounded,
        activeColor: theme.colorScheme.primary,
        isEnabled: callConfig?.allowAllAllowRules ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            updateCurrentConfig(callConfig.copyWith(allowAllAllowRules: val));
          }
        },
      ),
      DefenseStrategyItem(
        index: 6,
        title: l10n.allowAllBlockRules,
        subtitle: l10n.allowAllBlockRulesDesc,
        detailedDesc: l10n.allowAllBlockRulesDesc,
        icon: Icons.settings_suggest_rounded,
        activeColor: theme.colorScheme.error,
        isEnabled: callConfig?.allowAllBlockRules ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            updateCurrentConfig(callConfig.copyWith(allowAllBlockRules: val));
          }
        },
      ),
      DefenseStrategyItem(
        index: 7,
        title: l10n.allowBlockedNumbers,
        subtitle: l10n.allowBlockedNumbersDesc,
        detailedDesc: l10n.allowBlockedNumbersDesc,
        icon: Icons.warning_amber_rounded,
        activeColor: theme.colorScheme.primary,
        isEnabled: callConfig?.allowBlockedNumbers ?? false,
        onToggle: (val) {
          if (callConfig != null) {
            updateCurrentConfig(callConfig.copyWith(allowBlockedNumbers: val));
          }
        },
      ),
      DefenseStrategyItem(
        index: 8,
        title: l10n.allowRegexAllowRules,
        subtitle: l10n.allowRegexAllowRulesDesc,
        detailedDesc: l10n.allowRegexAllowRulesDesc,
        icon: Icons.code_rounded,
        activeColor: theme.colorScheme.secondary,
        isEnabled: callConfig?.allowRegexAllowRules ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            updateCurrentConfig(callConfig.copyWith(allowRegexAllowRules: val));
          }
        },
      ),
    ];

    final allOptions = [...dailyDefenseOptions, ...masterOverrideOptions];
    final currentOption = allOptions.firstWhere(
      (opt) => opt.index == _selectedDefenseIndex,
      orElse: () => dailyDefenseOptions.first,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryFilterHeaderTile(
            l10n: l10n,
            separateSims: separateSims,
            onSeparateSimsChanged: (val) {
              ref.read(separateSimsProvider.notifier).setSeparateSims(val);
            },
            onNavigateSettings: _navigateToFilterSettings,
          ),

          const SizedBox(height: 12),

          if (separateSims) ...[
            PrimaryFilterSimSlotBar(
              l10n: l10n,
              selectedSimSlot: _selectedSimSlot,
              onSimSlotSelected: (slot) {
                setState(() {
                  _selectedSimSlot = slot;
                });
              },
            ),
            const SizedBox(height: 14),
          ],

          PrimaryFilterDailyGrid(
            dailyOptions: dailyDefenseOptions,
            selectedIndex: _selectedDefenseIndex,
            onCardSelected: (idx) {
              setState(() {
                _selectedDefenseIndex = idx;
              });
            },
          ),

          const SizedBox(height: 12),

          PrimaryFilterInfoBanner(
            currentOption: currentOption,
            l10n: l10n,
            onNavigateSimRules: _navigateToSimSlotRules,
          ),

          const SizedBox(height: 16),

          PrimaryFilterMasterOverridesSection(
            masterOptions: masterOverrideOptions,
            selectedIndex: _selectedDefenseIndex,
            l10n: l10n,
            onCardSelected: (idx) {
              setState(() {
                _selectedDefenseIndex = idx;
              });
            },
          ),

          const SizedBox(height: 12),

          InkWell(
            onTap: () {
              setState(() {
                _showAdvancedSettings = !_showAdvancedSettings;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              decoration: BoxDecoration(
                color: _showAdvancedSettings
                    ? theme.colorScheme.primary.withValues(alpha: 0.1)
                    : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _showAdvancedSettings ? Icons.tune_rounded : Icons.tune_outlined,
                    size: 14,
                    color: _showAdvancedSettings ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    _showAdvancedSettings ? l10n.closeButton : l10n.filterManagement,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: _showAdvancedSettings ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _showAdvancedSettings ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    size: 16,
                    color: _showAdvancedSettings ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),

          if (_showAdvancedSettings) ...[
            const SizedBox(height: 12),
            PrimaryFilterAdvancedSection(
              selectedSimSlot: _selectedSimSlot,
              l10n: l10n,
            ),
          ],
        ],
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: ElitePrimaryFilterCard(),
          ),
        ),
      ),
    ),
  );
}
