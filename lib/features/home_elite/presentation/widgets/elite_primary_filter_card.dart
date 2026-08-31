import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/enhanced_filter_config_provider.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/provider/time_interceptor_provider.dart';
import 'package:yourcallyourrule/features/device_profile/provider/sim_info_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/features/local_filter/provider/local_count_filter_provider.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_filter_provider.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// ------------------- Widget 定义 -------------------

class ElitePrimaryFilterCard extends ConsumerStatefulWidget {
  const ElitePrimaryFilterCard({super.key});

  @override
  ConsumerState<ElitePrimaryFilterCard> createState() => _ElitePrimaryFilterCardState();
}

class _ElitePrimaryFilterCardState extends ConsumerState<ElitePrimaryFilterCard>
    with SingleTickerProviderStateMixin {
  int _selectedDefenseLevel = 0; // 0: 智能防护, 1: 强力拦截, 2: 标记与静音
  bool _showAdvancedSettings = false;
  TabController? _simTabController;

  @override
  void dispose() {
    _simTabController?.dispose();
    super.dispose();
  }

  void _navigateToFilterSettings() {
    context.pushNamed(AppRouter.filterSettings);
  }

  void _navigateToSimSlotRules() {
    context.pushNamed(
      AppRouter.simSlotRuleWithAds,
      pathParameters: {'simSlotIndex': '0'},
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final callConfig = ref.watch(
      callFilterConfigProvider.select((v) => v.value),
    );
    final callNotifier = ref.read(callFilterConfigProvider.notifier);

    final defenseOptions = [
      _DefenseStrategyItem(
        index: 0,
        title: l10n.allowRules,
        subtitle: l10n.allowAllowedNumbersDesc,
        detailedDesc: l10n.allowAllowedNumbersDesc,
        icon: Icons.shield_rounded,
        activeColor: EliteDopamineTheme.freshMint,
        isEnabled: callConfig?.allowAllAllowedNumbers ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            callNotifier.updateConfig(
              callConfig.copyWith(allowAllAllowedNumbers: val),
            );
          }
        },
      ),
      _DefenseStrategyItem(
        index: 1,
        title: l10n.blockRules,
        subtitle: l10n.blockActionDescription,
        detailedDesc: l10n.blockActionDescription,
        icon: Icons.gpp_bad_rounded,
        activeColor: EliteDopamineTheme.vibrantCoral,
        isEnabled: callConfig?.allowRegexBlockRules ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            callNotifier.updateConfig(
              callConfig.copyWith(allowRegexBlockRules: val),
            );
          }
        },
      ),
      _DefenseStrategyItem(
        index: 2,
        title: l10n.silentRules,
        subtitle: l10n.silenceActionDescription,
        detailedDesc: l10n.silenceActionDescription,
        icon: Icons.notifications_paused_rounded,
        activeColor: EliteDopamineTheme.sunsetTangerine,
        isEnabled: callConfig?.allowSilenceRules ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            callNotifier.updateConfig(
              callConfig.copyWith(allowSilenceRules: val),
            );
          }
        },
      ),
      _DefenseStrategyItem(
        index: 3,
        title: l10n.rejectAllCalls,
        subtitle: l10n.rejectAllCallsDescription,
        detailedDesc: l10n.rejectAllCallsDescription,
        icon: Icons.phone_disabled_rounded,
        activeColor: const Color(0xFFE11D48),
        isEnabled: callConfig?.rejectAllNumbers ?? false,
        onToggle: (val) {
          if (callConfig != null) {
            callNotifier.updateConfig(
              callConfig.copyWith(rejectAllNumbers: val),
            );
          }
        },
      ),
      _DefenseStrategyItem(
        index: 4,
        title: l10n.allowRegexAllowRules,
        subtitle: l10n.allowRegexAllowRulesDescription,
        detailedDesc: l10n.allowRegexAllowRulesDescription,
        icon: Icons.code_rounded,
        activeColor: EliteDopamineTheme.skyAzure,
        isEnabled: callConfig?.allowRegexAllowRules ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            callNotifier.updateConfig(
              callConfig.copyWith(allowRegexAllowRules: val),
            );
          }
        },
      ),
      _DefenseStrategyItem(
        index: 5,
        title: l10n.enableNoneActionRules,
        subtitle: l10n.enableNoneActionRulesDesc,
        detailedDesc: l10n.enableNoneActionRulesDesc,
        icon: Icons.label_important_outline_rounded,
        activeColor: EliteDopamineTheme.softLilac,
        isEnabled: callConfig?.allowNoneRules ?? true,
        onToggle: (val) {
          if (callConfig != null) {
            callNotifier.updateConfig(callConfig.copyWith(allowNoneRules: val));
          }
        },
      ),
    ];

    final currentOption = defenseOptions.firstWhere(
      (opt) => opt.index == _selectedDefenseLevel,
      orElse: () => defenseOptions.first,
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
              TextButton.icon(
                onPressed: _navigateToFilterSettings,
                icon: const Icon(Icons.settings_suggest_rounded, size: 15),
                label: Text(
                  l10n.filterSettingsTitle,
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

          // 横向左右滑动的大卡片矩阵（支持完整描述展示与横滑浏览全部过滤模式）
          SizedBox(
            height: 128,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: defenseOptions.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, idx) {
                final item = defenseOptions[idx];
                final isSelected = _selectedDefenseLevel == item.index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDefenseLevel = item.index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    width: 156,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? item.activeColor.withValues(alpha: 0.12)
                          : const Color(0xFFFBF9F5),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected
                            ? item.activeColor
                            : const Color(0xFFEDE8DF),
                        width: isSelected ? 1.8 : 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: item.activeColor.withValues(alpha: 0.20),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
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
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? item.activeColor
                                    : item.activeColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                item.icon,
                                color: isSelected
                                    ? Colors.white
                                    : item.activeColor,
                                size: 16,
                              ),
                            ),
                            Switch.adaptive(
                              value: item.isEnabled,
                              activeColor: item.activeColor,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onChanged: item.onToggle,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: isSelected
                                ? Colors.black87
                                : Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Expanded(
                          child: Text(
                            item.subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 9.5,
                              height: 1.25,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // 底部当前选中策略的完整详情阐述条与 SIM 卡快捷直达
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: currentOption.activeColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: currentOption.activeColor.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        currentOption.detailedDesc,
                        style: TextStyle(
                          fontSize: 10,
                          height: 1.3,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: _navigateToSimSlotRules,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: EliteDopamineTheme.sunsetTangerine.withValues(
                          alpha: 0.3,
                        ),
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
          ),

          const SizedBox(height: 10),

          // 展开/收起完整高级过滤规则总控按钮
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
          ),

          // 高级原生多巴胺拦截管理控件
          if (_showAdvancedSettings) ...[
            const SizedBox(height: 12),
            _buildAdvancedFilterSettingsSection(l10n),
          ],
        ],
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

        if (_simTabController == null || _simTabController!.length != simCards.length) {
          _simTabController?.dispose();
          _simTabController = TabController(length: simCards.length, vsync: this);
        }

        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7F5F0),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TabBar(
                controller: _simTabController,
                indicator: BoxDecoration(
                  gradient: EliteDopamineTheme.heroWarmGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[700],
                labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11),
                tabs: simCards.map((sim) {
                  final slot = sim.simSlotIndex ?? 0;
                  return Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.sim_card_outlined, size: 14),
                        const SizedBox(width: 4),
                        Text('SIM ${slot + 1} (${sim.carrierName ?? ""})'),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            _buildSimSlotRulesList(l10n, simCards[_simTabController?.index ?? 0].simSlotIndex ?? 0),
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
            color: isSelected ? activeColor.withValues(alpha: 0.12) : const Color(0xFFFBF9F5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? activeColor : const Color(0xFFEDE8DF),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.18),
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
