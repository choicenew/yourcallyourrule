import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/features/call/time_interceptor/provider/time_interceptor_provider.dart';
import 'package:yourcallyourrule/features/device_profile/provider/sim_info_provider.dart';
import 'package:yourcallyourrule/features/local_filter/provider/local_count_filter_provider.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_filter_provider.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// [重构]: 导入所有需要的 Provider。


import 'package:yourcallyourrule/features/call/call_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/enhanced_filter_config_provider.dart';



import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_filter_service.dart';

class FilterManagementWidget extends ConsumerStatefulWidget {
  const FilterManagementWidget({super.key});

  @override
  ConsumerState<FilterManagementWidget> createState() => _FilterManagementWidgetState();
}

class _FilterManagementWidgetState extends ConsumerState<FilterManagementWidget> with TickerProviderStateMixin {
  bool _isExpanded = false;
  TabController? _tabController;

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final simCardsAsync = ref.watch(simCardsProvider);
    
    simCardsAsync.whenData((simCards) {
      final simCount = simCards.length;
      if (simCount > 0 && (_tabController == null || _tabController!.length != simCount)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _tabController?.dispose();
              _tabController = TabController(length: simCount, vsync: this);
            });
          }
        });
      } else if (simCount == 0 && _tabController != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _tabController?.dispose();
              _tabController = null;
            });
          }
        });
      }
    });

    return Card(
      color: _isExpanded ? null : const Color(0xFFFFA726),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Text(AppLocalizations.of(context)!.filterManagement),
        subtitle: Text(AppLocalizations.of(context)!.filterManagementDescription),
        leading: const Icon(Icons.filter_alt, color: Colors.blue),
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildFilterContent(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFilterContent() {
    final enhancedConfigAsync = ref.watch(enhancedFilterConfigProvider);

    // [注释]: 顶层仍然使用 .when 处理初始加载和致命错误。
    return enhancedConfigAsync.when(
      data: (enhancedConfig) {
        final isSimSlotRuleEnabled = enhancedConfig.filterEnabledMap['SimSlotRuleService'] ?? false;
        
        if (isSimSlotRuleEnabled) {
          return _buildSimSlotFilterContent();
        } else {
          return _buildGlobalFilterList();
        }
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, st) => Center(child: Text(AppLocalizations.of(context)!.dataLoadFailure(err.toString()))),
    );
  }
  
  Widget _buildGlobalFilterList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSimCardFilterRulesSwitch(),
        const SizedBox(height: 16),
        _buildCallFilterSwitch(),
        const SizedBox(height: 16),
        _buildLocalCountFilterSwitch(),
        const SizedBox(height: 16),
        _buildRemoteNumberFilterSwitch(),
        const SizedBox(height: 16),
        _buildTimeInterceptorSwitch(),
      ],
    );
  }
  
  Widget _buildSimSlotFilterContent() {
    final simCardsAsync = ref.watch(simCardsProvider);
    
    return simCardsAsync.when(
      data: (simCards) {
        if (simCards.isEmpty) {
          return Center(child: Text(AppLocalizations.of(context)!.noSimCardsDetected, style: TextStyle(fontSize: 16, color: Colors.grey[600])));
        }

        if (_tabController == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              controller: _tabController,
              tabs: simCards.map((simInfo) {
                final simSlot = simInfo.simSlotIndex ?? 0;
                return Tab(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.sim_card, color: simSlot == 0 ? Colors.red : Colors.green),
                      Text('SIM ${simSlot + 1}'),
                      Flexible(
                        child: Text(
                          simInfo.carrierName ?? '',
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            SizedBox(
              height: 600,
              child: TabBarView(
                controller: _tabController,
                children: simCards.map((simInfo) {
                  final simSlot = simInfo.simSlotIndex!;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                             padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                children: [
                                  const Icon(Icons.sim_card, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('SIM ${simSlot + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                        Text(simInfo.carrierName ?? AppLocalizations.of(context)!.unassignedSIMCard),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ),
                          const SizedBox(height: 16),
                          _buildCallFilterSwitch(),
                          const SizedBox(height: 16),
                          _buildSimSlotFilterItem(
                            title: AppLocalizations.of(context)!.localCountFilter,
                            subtitle: AppLocalizations.of(context)!.localCountFilterDescription,
                            icon: Icons.filter_list,
                            color: Colors.orange,
                            simSlot: simSlot,
                            serviceId: 'LocalCountFilterService',
                          ),
                          const SizedBox(height: 16),
                          _buildSimSlotFilterItem(
                            title: AppLocalizations.of(context)!.remoteNumberFilter,
                            subtitle: AppLocalizations.of(context)!.remoteNumberFilterDescription,
                            icon: Icons.filter,
                            color: Colors.purple,
                            simSlot: simSlot,
                            serviceId: 'RemoteNumberFilterService',
                          ),
                          const SizedBox(height: 16),
                          _buildSimSlotFilterItem(
                            title: AppLocalizations.of(context)!.timeInterceptor,
                            subtitle: AppLocalizations.of(context)!.timeInterceptorDescription,
                            icon: Icons.timer,
                            color: Colors.teal,
                            simSlot: simSlot,
                            serviceId: 'TimeInterceptorService',
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, st) => Center(child: Text(AppLocalizations.of(context)!.dataLoadFailure(err.toString()))),
    );
  }

  // ▼▼▼▼▼ 核心修正部分 ▼▼▼▼▼

  Widget _buildSimCardFilterRulesSwitch() {
    // [修正]: 我们只 select provider 的 data 部分。
    final config = ref.watch(enhancedFilterConfigProvider.select((asyncValue) => asyncValue.value));
    
    // [注释]: 如果初始数据还没加载好，config 会是 null，我们可以显示一个禁用的开关。
    if (config == null) {
      return _buildFilterSwitchItem(
        title: AppLocalizations.of(context)!.simCardFilterRules,
        subtitle: AppLocalizations.of(context)!.simCardFilterRulesDescription,
        icon: Icons.sim_card, color: Colors.blue, count: 0, isEnabled: false, onToggle: (_) {},
      );
    }

    // [注释]: 这里仍然可以使用 Consumer 来异步获取规则数，这不会影响主UI的重建。
    return Consumer(
      builder: (context, ref, _) {
        final allRulesCountProvider = FutureProvider<int>((ref) async {
            final service = ref.watch(simSlotRuleServiceProvider);
            final rules = await service.getAllSimSlotRules();
            return rules.length;
        });
        final rulesCount = ref.watch(allRulesCountProvider).value ?? 0;
        
        return _buildFilterSwitchItem(
          title: AppLocalizations.of(context)!.simCardFilterRules,
          subtitle: AppLocalizations.of(context)!.simCardFilterRulesDescription,
          icon: Icons.sim_card,
          color: Colors.blue,
          count: rulesCount,
          isEnabled: config.filterEnabledMap['SimSlotRuleService'] ?? false,
          onToggle: (value) {
            final notifier = ref.read(enhancedFilterConfigProvider.notifier);
            value ? notifier.enableFilter('SimSlotRuleService') : notifier.disableFilter('SimSlotRuleService');
          },
        );
      },
    );
  }

  Widget _buildLocalCountFilterSwitch() {
    // [修正]: 使用 .select 只监听数据。当状态为 loading/error 时，UI 不会重建为空白。
    final config = ref.watch(localCountFilterConfigProvider.select((asyncValue) => asyncValue.value));
    if (config == null) {
      return _buildFilterSwitchItem(
        title: AppLocalizations.of(context)!.localCountFilter,
        subtitle: AppLocalizations.of(context)!.localCountFilterDescription,
        icon: Icons.filter_list, color: Colors.orange, count: 0, isEnabled: false, onToggle: (_) {},
      );
    }
    
    return _buildFilterSwitchItem(
      title: AppLocalizations.of(context)!.localCountFilter,
      subtitle: AppLocalizations.of(context)!.localCountFilterDescription,
      icon: Icons.filter_list,
      color: Colors.orange,
      count: config.countThreshold,
      isEnabled: config.enableLocalCountFilter,
      onToggle: (value) => ref.read(localCountFilterConfigProvider.notifier).updateConfig(config.copyWith(enableLocalCountFilter: value)),
    );
  }
  
  Widget _buildRemoteNumberFilterSwitch() {
    // [修正]: 使用 .select 只监听数据。
    final config = ref.watch(remoteNumberFilterConfigProvider.select((asyncValue) => asyncValue.value));
    if (config == null) {
       return _buildFilterSwitchItem(
        title: AppLocalizations.of(context)!.remoteNumberFilter,
        subtitle: AppLocalizations.of(context)!.remoteNumberFilterDescription,
        icon: Icons.filter, color: Colors.purple, count: 0, isEnabled: false, onToggle: (_) {},
      );
    }

    return _buildFilterSwitchItem(
      title: AppLocalizations.of(context)!.remoteNumberFilter,
      subtitle: AppLocalizations.of(context)!.remoteNumberFilterDescription,
      icon: Icons.filter,
      color: Colors.purple,
      count: config.countThreshold,
      isEnabled: config.enableRemoteNumberFilter,
      onToggle: (value) => ref.read(remoteNumberFilterConfigProvider.notifier).updateConfig(config.copyWith(enableRemoteNumberFilter: value)),
    );
  }

  Widget _buildTimeInterceptorSwitch() {
    // [修正]: 使用 .select 只监听数据。
    final config = ref.watch(timeInterceptorConfigProvider.select((asyncValue) => asyncValue.value));
    if (config == null) {
       return _buildFilterSwitchItem(
        title: AppLocalizations.of(context)!.timeInterceptor,
        subtitle: AppLocalizations.of(context)!.timeInterceptorDescription,
        icon: Icons.timer, color: Colors.teal, count: 0, isEnabled: false, onToggle: (_) {},
      );
    }
    
    return _buildFilterSwitchItem(
      title: AppLocalizations.of(context)!.timeInterceptor,
      subtitle: AppLocalizations.of(context)!.timeInterceptorDescription,
      icon: Icons.timer,
      color: Colors.teal,
      count: config.duration.inMinutes,
      isEnabled: config.shouldIntercept,
      onToggle: (value) => ref.read(timeInterceptorConfigProvider.notifier).updateShouldIntercept(value),
    );
  }

  Widget _buildCallFilterSwitch() {
    // [修正]: 对两个 provider 都使用 .select。
    final callConfig = ref.watch(callFilterConfigProvider.select((v) => v.value));
    final enhancedConfig = ref.watch(enhancedFilterConfigProvider.select((v) => v.value));
    
    // [注释]: 只有当两个配置都加载完成后才构建UI。
    if (callConfig == null || enhancedConfig == null) {
      // [注释]: 在初始加载时，显示一个禁用的、收起的 ExpansionTile。
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color.fromARGB(255, 247, 32, 132).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Text(AppLocalizations.of(context)!.callFilterRules),
          subtitle: Text(AppLocalizations.of(context)!.callFilterRulesDescription),
          leading: const Icon(Icons.call_end, color: Colors.grey),
          enabled: false,
        ),
      );
    }

    final callNotifier = ref.read(callFilterConfigProvider.notifier);
    final enhancedNotifier = ref.read(enhancedFilterConfigProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color.fromARGB(255, 247, 32, 132).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Text(AppLocalizations.of(context)!.callFilterRules),
        subtitle: Text(AppLocalizations.of(context)!.callFilterRulesDescription),
        leading: const Icon(Icons.call_end, color: Colors.red),
        children: [
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.enableCallFilter),
            subtitle: Text(AppLocalizations.of(context)!.enableCallFilterDescription),
            value: enhancedConfig.filterEnabledMap['CallFilterService'] ?? true,
            onChanged: (value) => value ? enhancedNotifier.enableFilter('CallFilterService') : enhancedNotifier.disableFilter('CallFilterService'),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.rejectAllCalls),
            subtitle: Text(AppLocalizations.of(context)!.rejectAllCallsDescription),
            value: callConfig.rejectAllNumbers,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(rejectAllNumbers: value)),
          ),
          // ... [注释]: 所有其他 SwitchListTile 保持原样，它们会正确工作
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.allowAllowedNumbers),
            subtitle: Text(AppLocalizations.of(context)!.allowAllowedNumbersDesc),
            value: callConfig.allowAllAllowedNumbers,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(allowAllAllowedNumbers: value)),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.allowRegexAllowRules),
            subtitle: Text(AppLocalizations.of(context)!.allowRegexAllowRulesDescription),
            value: callConfig.allowRegexAllowRules,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(allowRegexAllowRules: value)),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.allowBlockedNumbers),
            subtitle: Text(AppLocalizations.of(context)!.allowBlockedNumbersDesc),
            value: callConfig.allowBlockedNumbers,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(allowBlockedNumbers: value)),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.allowAllAllowRules),
            subtitle: Text(AppLocalizations.of(context)!.allowAllAllowRulesDesc),
            value: callConfig.allowAllAllowRules,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(allowAllAllowRules: value)),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.allowRegexBlockRules),
            subtitle: Text(AppLocalizations.of(context)!.allowRegexBlockRulesDescription),
            value: callConfig.allowRegexBlockRules,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(allowRegexBlockRules: value)),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.allowAllBlockRules),
            subtitle: Text(AppLocalizations.of(context)!.allowAllBlockRulesDesc),
            value: callConfig.allowAllBlockRules,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(allowAllBlockRules: value)),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.enableMuteRules),
            subtitle: Text(AppLocalizations.of(context)!.enableMuteRulesDesc),
            value: callConfig.allowSilenceRules,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(allowSilenceRules: value)),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.enableNoneActionRules),
            subtitle: Text(AppLocalizations.of(context)!.enableNoneActionRulesDesc),
            value: callConfig.allowNoneRules,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(allowNoneRules: value)),
          ),
        ],
      ),
    );
  }

  Widget _buildSimSlotFilterItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required int simSlot,
    required String serviceId,
  }) {
    // [修正]: 使用 .select 只监听数据。
    final enhancedConfig = ref.watch(enhancedFilterConfigProvider.select((v) => v.value));
    if (enhancedConfig == null) {
      return Container(); // 返回一个空容器而不是 SizedBox.shrink()
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),
          Switch(
            value: enhancedConfig.simSlotFilterConfigMap[simSlot]?[serviceId] ?? enhancedConfig.filterEnabledMap[serviceId] ?? true,
            onChanged: (value) {
              final notifier = ref.read(enhancedFilterConfigProvider.notifier);
              value ? notifier.enableFilterForSimSlot(simSlot, serviceId) : notifier.disableFilterForSimSlot(simSlot, serviceId);
            },
            activeColor: color,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSwitchItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required int count,
    required bool isEnabled,
    required Function(bool) onToggle,
  }) {
     return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
            child: Text('$count', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          Switch(value: isEnabled, onChanged: onToggle, activeColor: color),
        ],
      ),
    );
  }
}