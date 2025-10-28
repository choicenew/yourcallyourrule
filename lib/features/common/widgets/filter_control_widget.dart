import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sim_reader/sim_reader.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/provider/time_interceptor_provider.dart';
import 'package:yourcallyourrule/features/device_profile/provider/sim_info_provider.dart';
import 'package:yourcallyourrule/features/local_filter/provider/local_count_filter_provider.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_filter_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// [重构]: 导入所有需要的 Provider。

import 'package:yourcallyourrule/features/call/call_filter/providers/call_filter_provider.dart';



import 'package:yourcallyourrule/features/call/call_filter/providers/enhanced_filter_config_provider.dart';


// [重构]: 将 StatefulWidget 改为 ConsumerStatefulWidget 以便访问 ref 和管理本地UI状态。
class FilterControlWidget extends ConsumerStatefulWidget {
  // [重构]: 移除所有构造函数参数，因为所有依赖都将从 ref 获取。
  const FilterControlWidget({super.key});

  @override
  ConsumerState<FilterControlWidget> createState() => _FilterControlWidgetState();
}

class _FilterControlWidgetState extends ConsumerState<FilterControlWidget> {
  // [重构]: 只保留与UI交互强相关的本地状态，例如当前选择的SIM卡索引。
  int _selectedSimSlotIndex = -1; // -1 表示全局设置

  // [重构]: 移除所有数据相关的本地状态变量和 initState/load 方法。
  
  @override
  Widget build(BuildContext context) {
    // [重构]: 在 build 方法的顶部监听所有需要的数据。
    final simCardsAsync = ref.watch(simCardsProvider);
    final callConfigAsync = ref.watch(callFilterConfigProvider);
    final localConfigAsync = ref.watch(localCountFilterConfigProvider);
    final remoteConfigAsync = ref.watch(remoteNumberFilterConfigProvider);
    final timeConfigAsync = ref.watch(timeInterceptorConfigProvider);

    // [注释]: 将所有异步状态合并到一个列表中，方便统一处理。
    final asyncStates = [
      simCardsAsync,
      callConfigAsync,
      localConfigAsync,
      remoteConfigAsync,
      timeConfigAsync,
    ];

    // [注释]: 如果有任何一个 provider 正在加载且没有旧数据，则显示加载指示器。
    if (asyncStates.any((s) => s.isLoading && !s.hasValue)) {
      return const Center(child: CircularProgressIndicator());
    }

    // ▼▼▼▼▼ 核心修正部分 ▼▼▼▼▼
        // [修正]: 直接在循环中检查并返回错误，避免任何复杂的类型转换问题。
    // AsyncValue 基类都有 .hasError 和 .error 属性，这是最安全的方式。
    for (final state in asyncStates) {
      if (state.hasError) {
        return Center(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(AppLocalizations.of(context)!.dataLoadFailure(state.error.toString())),
        ));
      }
    }
    // ▲▲▲▲▲ 修正结束 ▲▲▲▲▲
    //    
    // [注释]: 安全地获取所有数据。到这里可以确定 .value 不为 null。
    final availableSimSlots = simCardsAsync.value!;
    final supportSimSlotConfig = availableSimSlots.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(AppLocalizations.of(context)!.filterControlPanelTitle),
        const SizedBox(height: 16),
        if (supportSimSlotConfig) _buildSimSlotSelector(availableSimSlots),
        const SizedBox(height: 16),
        _buildCallFilterSection(ref),
        const Divider(),
        _buildLocalCountFilterSection(ref),
        const Divider(),
        _buildRemoteNumberFilterSection(ref),
        const Divider(),
        _buildTimeInterceptorSection(ref),
        const SizedBox(height: 32),
        _buildExplanationCard(supportSimSlotConfig),
      ],
    );
  }

  /// [重构]: 构建SIM卡选择器。
  Widget _buildSimSlotSelector(List<SimInfo> availableSimSlots) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.configureSimCardFilterRules,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            // [修正]: 使用 DropdownButton 来避免 'value' 废弃警告，并更好地控制状态。
            DropdownButton<int>(
              value: _selectedSimSlotIndex,
              isExpanded: true,
              items: [
                DropdownMenuItem<int>(
                  value: -1,
                  child: Text(AppLocalizations.of(context)!.globalSettings),
                ),
                ...availableSimSlots
                    .map((simInfo) => DropdownMenuItem<int>(
                          value: simInfo.simSlotIndex,
                          child: Text(simInfo.carrierName ?? AppLocalizations.of(context)!.unassignedSIMCard),
                        ))
                    .toList(),
              ],
              onChanged: (value) {
                // [重构]: 更新UI状态，onChanged 回调中的 setState 是允许且正确的。
                setState(() {
                  _selectedSimSlotIndex = value ?? -1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }

  /// [重构]: 构建基本规则过滤部分。
  Widget _buildCallFilterSection(WidgetRef ref) {
    // [注释]: 安全地获取数据和 notifier
    final config = ref.watch(callFilterConfigProvider).value!;
    final notifier = ref.read(callFilterConfigProvider.notifier);
    
    // [修正]: 彻底移除未被使用的局部 `updateConfig` 方法。

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubSectionTitle(AppLocalizations.of(context)!.basicRuleFiltering),
        // [注释]: 这是一个完整的、无删减的列表。
        // [注释]: onChanged 回调直接调用 notifier 的方法来更新状态。
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.rejectAllCalls),
          subtitle: Text(AppLocalizations.of(context)!.rejectAllCallsDescription),
          value: config.rejectAllNumbers,
          onChanged: (value) => notifier.updateConfig(config.copyWith(rejectAllNumbers: value)),
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowAllowedNumbers),
          subtitle: Text(AppLocalizations.of(context)!.allowAllowedNumbersDesc),
          value: config.allowAllAllowedNumbers,
          onChanged: (value) => notifier.updateConfig(config.copyWith(allowAllAllowedNumbers: value)),
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowRegexAllowRules),
          subtitle: Text(AppLocalizations.of(context)!.allowRegexAllowRulesDescription),
          value: config.allowRegexAllowRules,
          onChanged: (value) => notifier.updateConfig(config.copyWith(allowRegexAllowRules: value)),
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowBlockedNumbers),
          subtitle: Text(AppLocalizations.of(context)!.allowBlockedNumbersDesc),
          value: config.allowBlockedNumbers,
          onChanged: (value) => notifier.updateConfig(config.copyWith(allowBlockedNumbers: value)),
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowAllAllowRules),
          subtitle: Text(AppLocalizations.of(context)!.allowAllAllowRulesDesc),
          value: config.allowAllAllowRules,
          onChanged: (value) => notifier.updateConfig(config.copyWith(allowAllAllowRules: value)),
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowRegexBlockRules),
          subtitle: Text(AppLocalizations.of(context)!.allowRegexBlockRulesDescription),
          value: config.allowRegexBlockRules,
          onChanged: (value) => notifier.updateConfig(config.copyWith(allowRegexBlockRules: value)),
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowAllBlockRules),
          subtitle: Text(AppLocalizations.of(context)!.allowAllBlockRulesDesc),
          value: config.allowAllBlockRules,
          onChanged: (value) => notifier.updateConfig(config.copyWith(allowAllBlockRules: value)),
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.enableMuteRules),
          subtitle: Text(AppLocalizations.of(context)!.enableMuteRulesDesc),
          value: config.allowSilenceRules,
          onChanged: (value) => notifier.updateConfig(config.copyWith(allowSilenceRules: value)),
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.enableNoneActionRules),
          subtitle: Text(AppLocalizations.of(context)!.enableNoneActionRulesDesc),
          value: config.allowNoneRules,
          onChanged: (value) => notifier.updateConfig(config.copyWith(allowNoneRules: value)),
        ),
      ],
    );
  }

  /// [重构]: 构建本地计数过滤部分。
  Widget _buildLocalCountFilterSection(WidgetRef ref) {
    final config = ref.watch(localCountFilterConfigProvider).value!;
    final notifier = ref.read(localCountFilterConfigProvider.notifier);
    final enhancedNotifier = ref.read(enhancedFilterConfigProvider.notifier);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubSectionTitle(AppLocalizations.of(context)!.localCountFiltering),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.enableLocalCountFilter),
          subtitle: Text(AppLocalizations.of(context)!.enableLocalCountFilterDescription),
          value: config.enableLocalCountFilter,
          onChanged: (value) {
            notifier.updateConfig(config.copyWith(enableLocalCountFilter: value));
            // [注释]: 如果当前选择了某个SIM卡，则同步更新该SIM卡的特定配置。
            if (_selectedSimSlotIndex != -1) {
              const filterName = 'LocalCountFilterService';
              value ? enhancedNotifier.enableFilterForSimSlot(_selectedSimSlotIndex, filterName)
                    : enhancedNotifier.disableFilterForSimSlot(_selectedSimSlotIndex, filterName);
            }
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.rejectExceededNumbers),
          subtitle: Text(AppLocalizations.of(context)!.rejectExceededNumbersDescription),
          value: config.rejectExceededNumbers,
          onChanged: (value) => notifier.updateConfig(config.copyWith(rejectExceededNumbers: value)),
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowNonExceededNumbers),
          subtitle: Text(AppLocalizations.of(context)!.allowNonExceededNumbersDescription),
          value: config.allowNonExceededNumbers,
          onChanged: (value) => notifier.updateConfig(config.copyWith(allowNonExceededNumbers: value)),
        ),
      ],
    );
  }

  /// [重构]: 构建远程号码过滤部分。
  Widget _buildRemoteNumberFilterSection(WidgetRef ref) {
    final config = ref.watch(remoteNumberFilterConfigProvider).value!;
    final notifier = ref.read(remoteNumberFilterConfigProvider.notifier);
    final enhancedNotifier = ref.read(enhancedFilterConfigProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubSectionTitle(AppLocalizations.of(context)!.remoteNumberFiltering),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.enableRemoteNumberFilter),
          subtitle: Text(AppLocalizations.of(context)!.enableRemoteNumberFilterDescription),
          value: config.enableRemoteNumberFilter,
          onChanged: (value) {
            notifier.updateConfig(config.copyWith(enableRemoteNumberFilter: value));
            if (_selectedSimSlotIndex != -1) {
              const filterName = 'RemoteNumberFilterService';
              value ? enhancedNotifier.enableFilterForSimSlot(_selectedSimSlotIndex, filterName)
                    : enhancedNotifier.disableFilterForSimSlot(_selectedSimSlotIndex, filterName);
            }
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.rejectExceededNumbers),
          subtitle: Text(AppLocalizations.of(context)!.rejectExceededNumbersDescription),
          value: config.rejectExceededNumbers,
          onChanged: (value) => notifier.updateConfig(config.copyWith(rejectExceededNumbers: value)),
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.prioritizeRemoteAction),
          subtitle: Text(AppLocalizations.of(context)!.prioritizeRemoteActionDescription),
          value: config.prioritizeRemoteAction,
          onChanged: (value) => notifier.updateConfig(config.copyWith(prioritizeRemoteAction: value)),
        ),
      ],
    );
  }

  /// [重构]: 构建时间拦截器部分。
  Widget _buildTimeInterceptorSection(WidgetRef ref) {
    final config = ref.watch(timeInterceptorConfigProvider).value!;
    final notifier = ref.read(timeInterceptorConfigProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubSectionTitle(AppLocalizations.of(context)!.timeInterceptor),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.enableTimeInterception),
          subtitle: Text(AppLocalizations.of(context)!.enableTimeInterceptionDescription),
          value: config.shouldIntercept,
          onChanged: (value) => notifier.updateShouldIntercept(value),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Text('${AppLocalizations.of(context)!.interceptionTimeInterval}: '),
              Text('${config.duration.inMinutes} ${AppLocalizations.of(context)!.minutes}'),
            ],
          ),
        ),
        Slider(
          value: config.duration.inMinutes.toDouble(),
          min: 5,
          max: 60,
          divisions: 11,
          label: '${config.duration.inMinutes} ${AppLocalizations.of(context)!.minutes}',
          onChanged: (value) => notifier.updateDuration(value.round()),
        ),
      ],
    );
  }

  Widget _buildSubSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }

  Widget _buildExplanationCard(bool supportSimSlotConfig) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.filterExplanation, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.basicRuleFilteringExplanation),
            Text(AppLocalizations.of(context)!.localCountFilteringExplanation),
            Text(AppLocalizations.of(context)!.remoteNumberFilteringExplanation),
            Text(AppLocalizations.of(context)!.timeInterceptorExplanation),
            if (supportSimSlotConfig) Text(AppLocalizations.of(context)!.simCardConfigurationExplanation),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.filterPriorityNote),
          ],
        ),
      ),
    );
  }
}