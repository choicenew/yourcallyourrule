import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/features/call_filter/providers/enhanced_filter_config_provider.dart';
import 'package:yourcallyourrule/features/local_filter/provider/local_count_filter_provider.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_filter_provider.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/call_time_interception/provider/time_interceptor_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

import 'filter_switch_tile.dart';

/// 全局单栏拦截规则组列表组件
class GlobalFilterListWidget extends ConsumerWidget {
  const GlobalFilterListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSimCardFilterRulesSwitch(context, ref),
        const SizedBox(height: 16),
        _buildCallFilterSwitch(context, ref),
        const SizedBox(height: 16),
        _buildLocalCountFilterSwitch(context, ref),
        const SizedBox(height: 16),
        _buildRemoteNumberFilterSwitch(context, ref),
        const SizedBox(height: 16),
        _buildTimeInterceptorSwitch(context, ref),
      ],
    );
  }

  Widget _buildSimCardFilterRulesSwitch(BuildContext context, WidgetRef ref) {
    final config = ref.watch(
      enhancedFilterConfigProvider.select((asyncValue) => asyncValue.value),
    );

    if (config == null) {
      return FilterSwitchTile(
        title: AppLocalizations.of(context).simCardFilterRules,
        subtitle: AppLocalizations.of(context).simCardFilterRulesDescription,
        icon: Icons.sim_card,
        color: Colors.blue,
        count: 0,
        isEnabled: false,
        onToggle: (_) {},
      );
    }

    return Consumer(
      builder: (context, ref, _) {
        final allRulesCountProvider = FutureProvider<int>((ref) async {
          final service = ref.watch(simSlotRuleServiceProvider);
          final rules = await service.getAllSimSlotRules();
          return rules.length;
        });
        final rulesCount = ref.watch(allRulesCountProvider).value ?? 0;

        return FilterSwitchTile(
          title: AppLocalizations.of(context).simCardFilterRules,
          subtitle: AppLocalizations.of(context).simCardFilterRulesDescription,
          icon: Icons.sim_card,
          color: Colors.blue,
          count: rulesCount,
          isEnabled: config.filterEnabledMap['SimSlotRuleService'] ?? false,
          onToggle: (value) {
            final notifier = ref.read(enhancedFilterConfigProvider.notifier);
            value
                ? notifier.enableFilter('SimSlotRuleService')
                : notifier.disableFilter('SimSlotRuleService');
          },
        );
      },
    );
  }

  Widget _buildLocalCountFilterSwitch(BuildContext context, WidgetRef ref) {
    final config = ref.watch(
      localCountFilterConfigProvider.select((asyncValue) => asyncValue.value),
    );
    if (config == null) {
      return FilterSwitchTile(
        title: AppLocalizations.of(context).localCountFilter,
        subtitle: AppLocalizations.of(context).localCountFilterDescription,
        icon: Icons.filter_list,
        color: Colors.orange,
        count: 0,
        isEnabled: false,
        onToggle: (_) {},
      );
    }

    return FilterSwitchTile(
      title: AppLocalizations.of(context).localCountFilter,
      subtitle: AppLocalizations.of(context).localCountFilterDescription,
      icon: Icons.filter_list,
      color: Colors.orange,
      count: config.countThreshold,
      isEnabled: config.enableLocalCountFilter,
      onToggle: (value) => ref
          .read(localCountFilterConfigProvider.notifier)
          .updateConfig(config.copyWith(enableLocalCountFilter: value)),
    );
  }

  Widget _buildRemoteNumberFilterSwitch(BuildContext context, WidgetRef ref) {
    final config = ref.watch(
      remoteNumberFilterConfigProvider.select((asyncValue) => asyncValue.value),
    );
    if (config == null) {
      return FilterSwitchTile(
        title: AppLocalizations.of(context).remoteNumberFilter,
        subtitle: AppLocalizations.of(context).remoteNumberFilterDescription,
        icon: Icons.filter,
        color: Colors.purple,
        count: 0,
        isEnabled: false,
        onToggle: (_) {},
      );
    }

    return FilterSwitchTile(
      title: AppLocalizations.of(context).remoteNumberFilter,
      subtitle: AppLocalizations.of(context).remoteNumberFilterDescription,
      icon: Icons.filter,
      color: Colors.purple,
      count: config.countThreshold,
      isEnabled: config.enableRemoteNumberFilter,
      onToggle: (value) => ref
          .read(remoteNumberFilterConfigProvider.notifier)
          .updateConfig(config.copyWith(enableRemoteNumberFilter: value)),
    );
  }

  Widget _buildTimeInterceptorSwitch(BuildContext context, WidgetRef ref) {
    final config = ref.watch(
      timeInterceptorConfigProvider.select((asyncValue) => asyncValue.value),
    );
    if (config == null) {
      return FilterSwitchTile(
        title: AppLocalizations.of(context).timeInterceptor,
        subtitle: AppLocalizations.of(context).timeInterceptorDescription,
        icon: Icons.timer,
        color: Colors.teal,
        count: 0,
        isEnabled: false,
        onToggle: (_) {},
      );
    }

    return FilterSwitchTile(
      title: AppLocalizations.of(context).timeInterceptor,
      subtitle: AppLocalizations.of(context).timeInterceptorDescription,
      icon: Icons.timer,
      color: Colors.teal,
      count: config.duration.inMinutes,
      isEnabled: config.shouldIntercept,
      onToggle: (value) => ref
          .read(timeInterceptorConfigProvider.notifier)
          .updateShouldIntercept(value),
    );
  }

  Widget _buildCallFilterSwitch(BuildContext context, WidgetRef ref) {
    final callConfig = ref.watch(callFilterConfigProvider.select((v) => v.value));
    final enhancedConfig = ref.watch(enhancedFilterConfigProvider.select((v) => v.value));

    if (callConfig == null || enhancedConfig == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 247, 32, 132).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(AppLocalizations.of(context).callFilterRules),
          subtitle: Text(AppLocalizations.of(context).callFilterRulesDescription),
          leading: const Icon(Icons.call_end, color: Colors.grey),
          enabled: false,
        ),
      );
    }

    final callNotifier = ref.read(callFilterConfigProvider.notifier);
    final enhancedNotifier = ref.read(enhancedFilterConfigProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 32, 132).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(AppLocalizations.of(context).callFilterRules),
        subtitle: Text(AppLocalizations.of(context).callFilterRulesDescription),
        leading: const Icon(Icons.call_end, color: Colors.red),
        children: [
          SwitchListTile(
            title: Text(AppLocalizations.of(context).enableCallFilter),
            subtitle: Text(AppLocalizations.of(context).enableCallFilterDescription),
            value: enhancedConfig.filterEnabledMap['CallFilterService'] ?? true,
            onChanged: (value) => value
                ? enhancedNotifier.enableFilter('CallFilterService')
                : enhancedNotifier.disableFilter('CallFilterService'),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context).rejectAllCalls),
            subtitle: Text(AppLocalizations.of(context).rejectAllCallsDescription),
            value: callConfig.rejectAllNumbers,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(rejectAllNumbers: value)),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context).allowAllowedNumbers),
            subtitle: Text(AppLocalizations.of(context).allowAllowedNumbersDesc),
            value: callConfig.allowAllAllowedNumbers,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(allowAllAllowedNumbers: value)),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context).allowRegexAllowRules),
            subtitle: Text(AppLocalizations.of(context).allowRegexAllowRulesDescription),
            value: callConfig.allowRegexAllowRules,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(allowRegexAllowRules: value)),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context).allowBlockedNumbers),
            subtitle: Text(AppLocalizations.of(context).allowBlockedNumbersDesc),
            value: callConfig.allowBlockedNumbers,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(allowBlockedNumbers: value)),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context).allowAllAllowRules),
            subtitle: Text(AppLocalizations.of(context).allowAllAllowRulesDesc),
            value: callConfig.allowAllAllowRules,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(allowAllAllowRules: value)),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context).allowRegexBlockRules),
            subtitle: Text(AppLocalizations.of(context).allowRegexBlockRulesDescription),
            value: callConfig.allowRegexBlockRules,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(allowRegexBlockRules: value)),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context).allowAllBlockRules),
            subtitle: Text(AppLocalizations.of(context).allowAllBlockRulesDesc),
            value: callConfig.allowAllBlockRules,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(allowAllBlockRules: value)),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context).enableMuteRules),
            subtitle: Text(AppLocalizations.of(context).enableMuteRulesDesc),
            value: callConfig.allowSilenceRules,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(allowSilenceRules: value)),
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context).enableNoneActionRules),
            subtitle: Text(AppLocalizations.of(context).enableNoneActionRulesDesc),
            value: callConfig.allowNoneRules,
            onChanged: (value) => callNotifier.updateConfig(callConfig.copyWith(allowNoneRules: value)),
          ),
        ],
      ),
    );
  }
}
