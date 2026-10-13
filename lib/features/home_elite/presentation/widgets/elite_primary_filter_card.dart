import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/call/call_filter/config/call_filter_config.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/enhanced_filter_config_provider.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/provider/time_interceptor_provider.dart';
import 'package:yourcallyourrule/features/device_profile/provider/sim_info_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/features/local_filter/provider/local_count_filter_provider.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_filter_provider.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// ------------------- ElitePrimaryFilterCard 定义 -------------------

class ElitePrimaryFilterCard extends ConsumerStatefulWidget {
  const ElitePrimaryFilterCard({super.key});

  @override
  ConsumerState<ElitePrimaryFilterCard> createState() => _ElitePrimaryFilterCardState();
}

class _ElitePrimaryFilterCardState extends ConsumerState<ElitePrimaryFilterCard>
    with SingleTickerProviderStateMixin {
  int _selectedDefenseIndex = 0; // 当前选中的策略卡片（用于下方 info banner 实时展示）
  bool _separateSims = false; // 右上角分卡槽控制开关 (Separate SIMs)
  int _selectedSimSlot = 0; // 当前选中的 SIM 卡槽（0 为 SIM 1，1 为 SIM 2）
  bool _showAdvancedSettings = false; // 底部 Filter Management 展开状态

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
    final callConfig = ref.watch(
      callFilterConfigProvider.select((v) => v.value),
    );
    final callNotifier = ref.read(callFilterConfigProvider.notifier);

    // 5 个常用防御策略项 (Daily Defense Options)
    final dailyDefenseOptions = [
      _DefenseStrategyItem(
        index: 0,
        title: l10n.allowAllowedNumbers,
        subtitle: l10n.allowAllowedNumbersDesc,
        detailedDesc: l10n.allowAllowedNumbersDesc,
        icon: Icons.shield_rounded,
        activeColor: EliteDopamineTheme.freshMint,
        isEnabled: callConfig?.allowAllAllowedNumbers ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            callNotifier.updateConfig(callConfig.copyWith(allowAllAllowedNumbers: val));
          }
        },
      ),
      _DefenseStrategyItem(
        index: 1,
        title: l10n.allowRegexBlockRules,
        subtitle: l10n.allowRegexBlockRulesDesc,
        detailedDesc: l10n.allowRegexBlockRulesDesc,
        icon: Icons.gpp_bad_rounded,
        activeColor: EliteDopamineTheme.vibrantCoral,
        isEnabled: callConfig?.allowRegexBlockRules ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            callNotifier.updateConfig(callConfig.copyWith(allowRegexBlockRules: val));
          }
        },
      ),
      _DefenseStrategyItem(
        index: 2,
        title: l10n.enableMuteRules,
        subtitle: l10n.enableMuteRulesDesc,
        detailedDesc: l10n.enableMuteRulesDesc,
        icon: Icons.notifications_paused_rounded,
        activeColor: const Color(0xFF8B5CF6),
        isEnabled: callConfig?.allowSilenceRules ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            callNotifier.updateConfig(callConfig.copyWith(allowSilenceRules: val));
          }
        },
      ),
      _DefenseStrategyItem(
        index: 3,
        title: l10n.enableNoneActionRules,
        subtitle: l10n.enableNoneActionRulesDesc,
        detailedDesc: l10n.enableNoneActionRulesDesc,
        icon: Icons.visibility_rounded,
        activeColor: EliteDopamineTheme.sunsetTangerine,
        isEnabled: callConfig?.allowNoneRules ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            callNotifier.updateConfig(callConfig.copyWith(allowNoneRules: val));
          }
        },
      ),
      _DefenseStrategyItem(
        index: 4,
        title: l10n.rejectAllNumbers,
        subtitle: l10n.rejectAllNumbersDesc,
        detailedDesc: l10n.rejectAllNumbersDesc,
        icon: Icons.remove_circle_rounded,
        activeColor: const Color(0xFFE11D48),
        isEnabled: callConfig?.rejectAllNumbers ?? false,
        onToggle: (val) {
          if (callConfig != null) {
            callNotifier.updateConfig(callConfig.copyWith(rejectAllNumbers: val));
          }
        },
      ),
    ];

    // 4 个总控特例项 (Master & Overrides Options)
    final masterOverrideOptions = [
      _DefenseStrategyItem(
        index: 5,
        title: l10n.allowAllAllowRules,
        subtitle: l10n.allowAllAllowRulesDesc,
        detailedDesc: l10n.allowAllAllowRulesDesc,
        icon: Icons.settings_rounded,
        activeColor: const Color(0xFFD97706),
        isEnabled: callConfig?.allowAllAllowRules ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            callNotifier.updateConfig(callConfig.copyWith(allowAllAllowRules: val));
          }
        },
      ),
      _DefenseStrategyItem(
        index: 6,
        title: l10n.allowAllBlockRules,
        subtitle: l10n.allowAllBlockRulesDesc,
        detailedDesc: l10n.allowAllBlockRulesDesc,
        icon: Icons.settings_suggest_rounded,
        activeColor: const Color(0xFFEF4444),
        isEnabled: callConfig?.allowAllBlockRules ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            callNotifier.updateConfig(callConfig.copyWith(allowAllBlockRules: val));
          }
        },
      ),
      _DefenseStrategyItem(
        index: 7,
        title: l10n.allowBlockedNumbers,
        subtitle: l10n.allowBlockedNumbersDesc,
        detailedDesc: l10n.allowBlockedNumbersDesc,
        icon: Icons.warning_amber_rounded,
        activeColor: const Color(0xFFEAB308),
        isEnabled: callConfig?.allowBlockedNumbers ?? false,
        onToggle: (val) {
          if (callConfig != null) {
            callNotifier.updateConfig(callConfig.copyWith(allowBlockedNumbers: val));
          }
        },
      ),
      _DefenseStrategyItem(
        index: 8,
        title: l10n.allowRegexAllowRules,
        subtitle: l10n.allowRegexAllowRulesDesc,
        detailedDesc: l10n.allowRegexAllowRulesDesc,
        icon: Icons.code_rounded,
        activeColor: EliteDopamineTheme.skyAzure,
        isEnabled: callConfig?.allowRegexAllowRules ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            callNotifier.updateConfig(callConfig.copyWith(allowRegexAllowRules: val));
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
            color: currentOption.activeColor.withValues(alpha: 0.08),
            blurRadius: 24,
            spreadRadius: 1,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头部：标题与 Separate SIMs 独立开关
          _buildHeaderRow(l10n),

          const SizedBox(height: 12),

          // 分卡槽切换卡（受 Separate SIMs 开关控制）
          if (_separateSims) ...[
            _buildSimSlotTabBar(),
            const SizedBox(height: 14),
          ],

          // 第一层级：5 个常用策略大卡片 (Daily Defense Grid)
          _buildDailyDefenseSection(dailyDefenseOptions),

          const SizedBox(height: 12),

          // 选中的策略详情提示条 ((i) Info Banner)
          _buildInfoBanner(currentOption, l10n),

          const SizedBox(height: 16),

          // 第二层级：4 个总控与特例胶囊网格 (Master & Overrides)
          _buildMasterOverridesSection(masterOverrideOptions),

          const SizedBox(height: 12),

          // 底部折叠：Filter Management 入口
          _buildAdvancedExpandToggle(l10n),

          // 高级原生多巴胺拦截管理控件
          if (_showAdvancedSettings) ...[
            const SizedBox(height: 12),
            _buildAdvancedFilterSettingsSection(l10n),
          ],
        ],
      ),
    );
  }

  // --- 子组件拆分 (Clean Modular Sub-Components) ---

  Widget _buildHeaderRow(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                      l10n.callFilterRules,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      l10n.callFilterRulesDescription,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: _navigateToFilterSettings,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  children: [
                    const Icon(
                      Icons.settings_suggest_rounded,
                      size: 14,
                      color: EliteDopamineTheme.sunsetTangerine,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      l10n.filterSettingsTitle,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: EliteDopamineTheme.sunsetTangerine,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.signal_cellular_alt_rounded, size: 14, color: Color(0xFFD97706)),
            const SizedBox(width: 4),
            const Text(
              'Separate SIMs',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 6),
            Transform.scale(
              scale: 0.85,
              child: Switch.adaptive(
                value: _separateSims,
                activeColor: const Color(0xFFD97706),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (val) {
                  setState(() {
                    _separateSims = val;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSimSlotTabBar() {
    final simCardsAsync = ref.watch(simCardsProvider);

    return simCardsAsync.when(
      data: (simCards) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF7F5F0),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(3),
          child: Row(
            children: [
              Expanded(
                child: _buildSimTabButton(
                  slotIndex: 0,
                  label: 'SIM 1 (Active)',
                  color: EliteDopamineTheme.freshMint,
                  isSelected: _selectedSimSlot == 0,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildSimTabButton(
                  slotIndex: 1,
                  label: 'SIM 2 (Active)',
                  color: EliteDopamineTheme.sunsetTangerine,
                  isSelected: _selectedSimSlot == 1,
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildSimTabButton({
    required int slotIndex,
    required String label,
    required Color color,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedSimSlot = slotIndex;
        });
      },
      borderRadius: BorderRadius.circular(13),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(13),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.signal_cellular_alt_rounded, size: 14, color: color),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                color: isSelected ? Colors.black87 : Colors.grey[700],
              ),
            ),
            const SizedBox(width: 5),
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyDefenseSection(List<_DefenseStrategyItem> dailyOptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 第一行 3 个大卡片
        Row(
          children: [
            Expanded(child: _buildDailyCardItem(dailyOptions[0])),
            const SizedBox(width: 8),
            Expanded(child: _buildDailyCardItem(dailyOptions[1])),
            const SizedBox(width: 8),
            Expanded(child: _buildDailyCardItem(dailyOptions[2])),
          ],
        ),
        const SizedBox(height: 8),
        // 第二行 2 个大卡片
        Row(
          children: [
            Expanded(child: _buildDailyCardItem(dailyOptions[3])),
            const SizedBox(width: 8),
            Expanded(child: _buildDailyCardItem(dailyOptions[4])),
          ],
        ),
      ],
    );
  }

  Widget _buildDailyCardItem(_DefenseStrategyItem item) {
    final isSelected = _selectedDefenseIndex == item.index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDefenseIndex = item.index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? item.activeColor.withValues(alpha: 0.12)
              : const Color(0xFFFBF9F5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? item.activeColor : const Color(0xFFEDE8DF),
            width: isSelected ? 1.8 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: item.activeColor.withValues(alpha: 0.16),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? item.activeColor
                        : item.activeColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(
                    item.icon,
                    color: isSelected ? Colors.white : item.activeColor,
                    size: 15,
                  ),
                ),
                Transform.scale(
                  scale: 0.75,
                  child: Switch.adaptive(
                    value: item.isEnabled,
                    activeColor: item.activeColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: item.onToggle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              item.title,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                height: 1.1,
                fontWeight: FontWeight.w900,
                color: isSelected ? Colors.black87 : Colors.grey[800],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 9,
                height: 1.2,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBanner(_DefenseStrategyItem currentOption, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: currentOption.activeColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: currentOption.activeColor.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 16,
            color: currentOption.activeColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentOption.title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  currentOption.detailedDesc,
                  style: TextStyle(
                    fontSize: 9.5,
                    height: 1.2,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: _navigateToSimSlotRules,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: EliteDopamineTheme.sunsetTangerine.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.sim_card_outlined,
                    size: 12,
                    color: EliteDopamineTheme.sunsetTangerine,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    l10n.simSlotRules,
                    style: const TextStyle(
                      fontSize: 9.5,
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
    );
  }

  Widget _buildMasterOverridesSection(List<_DefenseStrategyItem> masterOptions) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FA),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '4 总控特例 (Master & Overrides)',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            'Advanced & Master Controls',
            style: TextStyle(
              fontSize: 9.5,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _buildMasterPillItem(masterOptions[0])),
              const SizedBox(width: 8),
              Expanded(child: _buildMasterPillItem(masterOptions[1])),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildMasterPillItem(masterOptions[2])),
              const SizedBox(width: 8),
              Expanded(child: _buildMasterPillItem(masterOptions[3])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMasterPillItem(_DefenseStrategyItem item) {
    final isSelected = _selectedDefenseIndex == item.index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDefenseIndex = item.index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? item.activeColor.withValues(alpha: 0.15)
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? item.activeColor : const Color(0xFFE2E8F0),
            width: isSelected ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: item.activeColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(item.icon, color: item.activeColor, size: 14),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    item.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 8.5,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: 0.7,
              child: Switch.adaptive(
                value: item.isEnabled,
                activeColor: item.activeColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: item.onToggle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedExpandToggle(AppLocalizations l10n) {
    return InkWell(
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
              ? EliteDopamineTheme.sunsetTangerine.withValues(alpha: 0.1)
              : const Color(0xFFF7F5F0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _showAdvancedSettings ? Icons.tune_rounded : Icons.tune_outlined,
              size: 14,
              color: _showAdvancedSettings ? EliteDopamineTheme.sunsetTangerine : Colors.grey[700],
            ),
            const SizedBox(width: 5),
            Text(
              _showAdvancedSettings ? l10n.closeButton : l10n.filterManagement,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: _showAdvancedSettings ? EliteDopamineTheme.sunsetTangerine : Colors.grey[800],
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              _showAdvancedSettings ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: _showAdvancedSettings ? EliteDopamineTheme.sunsetTangerine : Colors.grey[700],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedFilterSettingsSection(AppLocalizations l10n) {
    final enhancedConfigAsync = ref.watch(enhancedFilterConfigProvider);

    return enhancedConfigAsync.when(
      data: (enhancedConfig) {
        final isSimSlotRuleEnabled = enhancedConfig.filterEnabledMap['SimSlotRuleService'] ?? false;
        if (isSimSlotRuleEnabled) {
          return _buildDopamineSimSlotContent(l10n);
        } else {
          return _buildDopamineGlobalFilterList(l10n, enhancedConfig);
        }
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      error: (err, _) => Center(
        child: Text(
          l10n.dataLoadFailure(err.toString()),
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildDopamineGlobalFilterList(AppLocalizations l10n, dynamic enhancedConfig) {
    final isSimSlotEnabled = enhancedConfig.filterEnabledMap['SimSlotRuleService'] ?? false;

    // SIM 卡槽规则总开关
    final allRulesCountProvider = FutureProvider<int>((ref) async {
      final service = ref.watch(simSlotRuleServiceProvider);
      final rules = await service.getAllSimSlotRules();
      return rules.length;
    });
    final rulesCount = ref.watch(allRulesCountProvider).value ?? 0;

    // 本地计数过滤
    final localConfig = ref.watch(localCountFilterConfigProvider.select((v) => v.value));
    final isLocalCountEnabled = localConfig?.enableLocalCountFilter ?? false;

    // 云端远程库过滤
    final remoteConfig = ref.watch(remoteNumberFilterConfigProvider.select((v) => v.value));
    final isRemoteEnabled = remoteConfig?.enableRemoteNumberFilter ?? false;

    // 时间拦截器
    final timeConfig = ref.watch(timeInterceptorConfigProvider.select((v) => v.value));
    final isTimeEnabled = timeConfig?.shouldIntercept ?? false;

    return Column(
      children: [
        _buildDopamineSwitchTile(
          icon: Icons.sim_card_outlined,
          iconColor: EliteDopamineTheme.skyAzure,
          title: l10n.simCardFilterRules,
          subtitle: l10n.simCardFilterRulesDescription,
          badgeText: '$rulesCount',
          value: isSimSlotEnabled,
          onChanged: (val) {
            final notifier = ref.read(enhancedFilterConfigProvider.notifier);
            val ? notifier.enableFilter('SimSlotRuleService') : notifier.disableFilter('SimSlotRuleService');
          },
        ),
        const SizedBox(height: 8),
        _buildDopamineSwitchTile(
          icon: Icons.filter_alt_outlined,
          iconColor: EliteDopamineTheme.sunsetTangerine,
          title: l10n.localCountFilter,
          subtitle: l10n.localCountFilterDescription,
          badgeText: localConfig != null ? '${localConfig.countThreshold}' : null,
          value: isLocalCountEnabled,
          onChanged: (val) {
            if (localConfig != null) {
              ref.read(localCountFilterConfigProvider.notifier).updateConfig(
                    localConfig.copyWith(enableLocalCountFilter: val),
                  );
            }
          },
        ),
        const SizedBox(height: 8),
        _buildDopamineSwitchTile(
          icon: Icons.cloud_outlined,
          iconColor: EliteDopamineTheme.softLilac,
          title: l10n.remoteNumberFilter,
          subtitle: l10n.remoteNumberFilterDescription,
          badgeText: remoteConfig != null ? '${remoteConfig.countThreshold}' : null,
          value: isRemoteEnabled,
          onChanged: (val) {
            if (remoteConfig != null) {
              ref.read(remoteNumberFilterConfigProvider.notifier).updateConfig(
                    remoteConfig.copyWith(enableRemoteNumberFilter: val),
                  );
            }
          },
        ),
        const SizedBox(height: 8),
        _buildDopamineSwitchTile(
          icon: Icons.timer_outlined,
          iconColor: EliteDopamineTheme.freshMint,
          title: l10n.timeInterceptor,
          subtitle: l10n.timeInterceptorDescription,
          badgeText: timeConfig != null ? '${timeConfig.duration.inMinutes}m' : null,
          value: isTimeEnabled,
          onChanged: (val) {
            if (timeConfig != null) {
              ref.read(timeInterceptorConfigProvider.notifier).updateShouldIntercept(val);
            }
          },
        ),
      ],
    );
  }

  Widget _buildDopamineSimSlotContent(AppLocalizations l10n) {
    final simCardsAsync = ref.watch(simCardsProvider);

    return simCardsAsync.when(
      data: (simCards) {
        if (simCards.isEmpty) {
          return Center(
            child: Text(
              l10n.noSimCardsDetected,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          );
        }

        return Column(
          children: [
            _buildSimSlotRulesList(l10n, simCards[_selectedSimSlot < simCards.length ? _selectedSimSlot : 0].simSlotIndex ?? 0),
          ],
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      error: (err, _) => Center(child: Text(err.toString())),
    );
  }

  Widget _buildSimSlotRulesList(AppLocalizations l10n, int simSlot) {
    return Column(
      children: [
        _buildDopamineSwitchTile(
          icon: Icons.filter_alt_outlined,
          iconColor: EliteDopamineTheme.sunsetTangerine,
          title: l10n.localCountFilter,
          subtitle: l10n.localCountFilterDescription,
          value: true,
          onChanged: (_) {},
        ),
        const SizedBox(height: 8),
        _buildDopamineSwitchTile(
          icon: Icons.cloud_outlined,
          iconColor: EliteDopamineTheme.softLilac,
          title: l10n.remoteNumberFilter,
          subtitle: l10n.remoteNumberFilterDescription,
          value: true,
          onChanged: (_) {},
        ),
        const SizedBox(height: 8),
        _buildDopamineSwitchTile(
          icon: Icons.timer_outlined,
          iconColor: EliteDopamineTheme.freshMint,
          title: l10n.timeInterceptor,
          subtitle: l10n.timeInterceptorDescription,
          value: true,
          onChanged: (_) {},
        ),
      ],
    );
  }

  Widget _buildDopamineSwitchTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    String? badgeText,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF9F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: value ? iconColor.withValues(alpha: 0.35) : const Color(0xFFEDE8DF),
          width: 1.1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    if (badgeText != null) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: iconColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          badgeText,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: iconColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 9.5,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            activeColor: iconColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _DefenseStrategyItem {
  final int index;
  final String title;
  final String subtitle;
  final String detailedDesc;
  final IconData icon;
  final Color activeColor;
  final bool isEnabled;
  final ValueChanged<bool> onToggle;

  const _DefenseStrategyItem({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.detailedDesc,
    required this.icon,
    required this.activeColor,
    required this.isEnabled,
    required this.onToggle,
  });
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
