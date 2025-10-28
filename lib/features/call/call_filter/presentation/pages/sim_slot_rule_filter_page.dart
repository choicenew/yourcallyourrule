import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/widgets/sim_slot_rule_filter_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// [重构]: 导入所有需要的 Provider，而不是 Service 实例。
import 'package:yourcallyourrule/features/call/call_filter/providers/enhanced_filter_config_provider.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_filter_service.dart';

// [重构]: 创建一个专门用于获取特定SIM卡规则的 provider。
// 它使用 .family 修饰符来接收 simSlotIndex 参数，并会自动缓存结果。
final simSlotRulesProvider = FutureProvider.family<List<Map<String, dynamic>>, int>((ref, simSlotIndex) async {
  // 从 ref 获取 service 实例。
  final service = ref.watch(simSlotRuleServiceProvider);
  final rules = await service.getSimSlotRules(simSlotIndex);
  // 将实体转换为 Map，以匹配 widget 的要求。
  return rules.map((r) => r.toMap()).toList();
});

// [重构]: 从 StatefulWidget 改为 ConsumerWidget。
class SimSlotRuleFilterPage extends ConsumerWidget {
  final int simSlotIndex;

  // [重构]: 构造函数现在只接收必要的参数 simSlotIndex。
  const SimSlotRuleFilterPage({
    super.key,
    required this.simSlotIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [重构]: 监听特定于SIM卡的配置状态。
    final enhancedConfigAsync = ref.watch(enhancedFilterConfigProvider);
    // [重构]: 监听特定SIM卡的规则列表。
    final simRulesAsync = ref.watch(simSlotRulesProvider(simSlotIndex));

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.simSlotTitle(simSlotIndex + 1)),
      ),
      // [重构]: 使用 .when 组合处理两个异步状态。首先处理配置加载。
      body: enhancedConfigAsync.when(
        data: (config) {
          // [注释]: 构建当前SIM卡的过滤器启用状态Map，这部分逻辑是同步的。
          final filterEnabledMap = {
            'LocalCountFilterService': config.simSlotFilterConfigMap[simSlotIndex]?['LocalCountFilterService'] ?? config.filterEnabledMap['LocalCountFilterService'] ?? true,
            'RemoteNumberFilterService': config.simSlotFilterConfigMap[simSlotIndex]?['RemoteNumberFilterService'] ?? config.filterEnabledMap['RemoteNumberFilterService'] ?? true,
            'CallFilterService': config.simSlotFilterConfigMap[simSlotIndex]?['CallFilterService'] ?? config.filterEnabledMap['CallFilterService'] ?? true,
          };

          // [重构]: 内部再用一个 .when 来处理规则列表的异步状态。
          return simRulesAsync.when(
            data: (rules) => SimSlotRuleFilterWidget(
              // [重构]: 移除 simSlotRuleService 和 enhancedCompositeFilterService 参数，因为逻辑已移入 provider 和回调。
              simSlotIndex: simSlotIndex,
              filterEnabledMap: filterEnabledMap,
              simSlotRules: rules,
              onToggleFilterEnabled: (filterName, isEnabled) {
                // [重构]: 通过 notifier 更新状态，UI会自动响应。
                final notifier = ref.read(enhancedFilterConfigProvider.notifier);
                if (isEnabled) {
                  notifier.enableFilterForSimSlot(simSlotIndex, filterName);
                } else {
                  notifier.disableFilterForSimSlot(simSlotIndex, filterName);
                }
                 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.filterToggleStatus(isEnabled ? AppLocalizations.of(context)!.enabled : AppLocalizations.of(context)!.disabled, filterName))),
                );
              },
              // [注释]: 添加和删除规则的逻辑现在通过调用 service 并 invalidate provider 来实现刷新。
              // onAddSimSlotRule: (number, name, labelId) async {
              //   await ref.read(simSlotRuleServiceProvider).addSimSlotRule(...);
              //   ref.invalidate(simSlotRulesProvider(simSlotIndex));
              // },
              // onDeleteSimSlotRule: (ruleId) async {
              //   await ref.read(simSlotRuleServiceProvider).removeSimSlotRule(ruleId);
              //   ref.invalidate(simSlotRulesProvider(simSlotIndex));
              // },
            ),
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