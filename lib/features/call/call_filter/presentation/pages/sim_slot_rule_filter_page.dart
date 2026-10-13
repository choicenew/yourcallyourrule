import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_type.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/widgets/sim_slot_rule_filter_widget.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/enhanced_filter_config_provider.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/providers/sim_slot_rule_page_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// [重构]: 从 StatefulWidget 改为 ConsumerWidget。
class SimSlotRuleFilterPage extends ConsumerWidget {
  final int simSlotIndex;

  // [重构]: 构造函数只接收必要的参数 simSlotIndex。
  const SimSlotRuleFilterPage({
    super.key,
    required this.simSlotIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [重构]: 监听特定于SIM卡的配置状态。
    final enhancedConfigAsync = ref.watch(enhancedFilterConfigProvider);
    // [重构]: 直接复用 sim_slot_rules 的官方标准 Provider，消除旧版手写 family
    final pageStateAsync = ref.watch(simSlotRulePageProvider(simSlotIndex));

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.simSlotTitle(simSlotIndex + 1)),
      ),
      // [重构]: 组合处理异步状态
      body: enhancedConfigAsync.when(
        data: (config) {
          // [强类型]: 使用 CallFilterType 构建当前卡槽的过滤器启用状态，零字符串
          final filterEnabledMap = {
            CallFilterType.simSlotRule: config.simSlotFilterConfigMap[simSlotIndex]?[CallFilterType.simSlotRule] ?? config.filterEnabledMap[CallFilterType.simSlotRule] ?? true,
            CallFilterType.basicRule: config.simSlotFilterConfigMap[simSlotIndex]?[CallFilterType.basicRule] ?? config.filterEnabledMap[CallFilterType.basicRule] ?? true,
            CallFilterType.localCount: config.simSlotFilterConfigMap[simSlotIndex]?[CallFilterType.localCount] ?? config.filterEnabledMap[CallFilterType.localCount] ?? true,
            CallFilterType.remoteNumber: config.simSlotFilterConfigMap[simSlotIndex]?[CallFilterType.remoteNumber] ?? config.filterEnabledMap[CallFilterType.remoteNumber] ?? true,
          };

          return pageStateAsync.when(
            data: (pageState) {
              final rulesMap = pageState.rules.map((r) => r.toMap()).toList();
              return SimSlotRuleFilterWidget(
                simSlotIndex: simSlotIndex,
                filterEnabledMap: filterEnabledMap,
                simSlotRules: rulesMap,
                onToggleFilterEnabled: (filterType, isEnabled) {
                  final notifier = ref.read(enhancedFilterConfigProvider.notifier);
                  if (isEnabled) {
                    notifier.enableFilterForSimSlot(simSlotIndex, filterType);
                  } else {
                    notifier.disableFilterForSimSlot(simSlotIndex, filterType);
                  }
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, st) => Center(child: Text(AppLocalizations.of(context)!.dataLoadFailure(err))),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text(AppLocalizations.of(context)!.dataLoadFailure(err))),
      ),
    );
  }
}