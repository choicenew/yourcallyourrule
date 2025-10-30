import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/sim_slot_config_provider.dart';
import 'package:yourcallyourrule/features/rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// [重构]: 导入我们需要的 Provider


// [重构]: 创建一个专门用于获取特定 SIM 卡规则列表的 Provider
final simSlotRulesProvider = FutureProvider.family<List<SimSlotRule>, int>((ref, simSlotIndex) {
  final service = ref.watch(simSlotRuleServiceProvider);
  return service.getSimSlotRules(simSlotIndex);
});

/// [重构]: SIM卡槽位规则管理组件，现在完全由 Riverpod 驱动。
class SimSlotRuleWidget extends ConsumerWidget {
  final int simSlotIndex;
  final VoidCallback onTap;

  const SimSlotRuleWidget({
    super.key,
    required this.simSlotIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [重构]: 监听 SIM 卡启用/禁用状态。使用 .select 防止不必要的重建。
    final isEnabledAsync = ref.watch(simSlotConfigProvider.select((state) {
      return state.whenData((data) => data.simSlotFilterEnabled[simSlotIndex] ?? false);
    }));
    
    // [重构]: 监听特定 SIM 卡的规则列表。
    final rulesAsync = ref.watch(simSlotRulesProvider(simSlotIndex));
    
    // [注释]: 获取 Notifier 以便调用更新方法。
    final notifier = ref.read(simSlotConfigProvider.notifier);

    // [注释]: 我们将两个异步状态组合起来处理。首先处理规则的加载。
    return rulesAsync.when(
      data: (rules) {
        // [注释]: 规则加载成功后，再处理启用/禁用状态的加载。
        return isEnabledAsync.when(
          data: (isEnabled) => Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                ListTile(
                  title: Text('${AppLocalizations.of(context)!.simSlot} ${simSlotIndex + 1}'),
                  subtitle: Text(
                    isEnabled ? AppLocalizations.of(context)!.enabled : AppLocalizations.of(context)!.disabled,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${rules.length} ${AppLocalizations.of(context)!.simSlotRules}'),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: onTap,
                ),
                SwitchListTile(
                  title: Text(AppLocalizations.of(context)!.enableFiltering),
                  value: isEnabled,
                  onChanged: (value) async {
                    // [重构]: 调用 Notifier 的方法来更新状态。
                    // UI 会自动响应变化，不再需要手动 invalidate。
                    if (value) {
                      await notifier.enableSimSlotFilter(simSlotIndex);
                    } else {
                      await notifier.disableSimSlotFilter(simSlotIndex);
                    }
                  },
                ),
                if (rules.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildRuleSummary(context, rules),
                  ),
              ],
            ),
          ),
          // [注释]: 如果任一 Provider 正在加载，显示统一的加载指示器。
          loading: () => const Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Center(heightFactor: 3, child: CircularProgressIndicator()),
          ),
          error: (error, stackTrace) => Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(title: Text('Error: $error')),
          ),
        );
      },
      loading: () => const Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Center(heightFactor: 3, child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(title: Text('Error: $error')),
      ),
    );
  }

  /// [注释]: UI 构建辅助方法保持不变。
  Widget _buildRuleSummary(BuildContext context, List<SimSlotRule> rules) {
    final displayRules = rules.take(3).toList();
    final hasMore = rules.length > 3;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...displayRules.map((rule) => _buildRuleItem(context, rule)),
        if (hasMore)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              AppLocalizations.of(context)!.andMoreItems(rules.length - 3),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }

  Widget _buildRuleItem(BuildContext context, SimSlotRule rule) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Chip(
            avatar: Icon(
              RuleActionDisplayUtils.getActionTypeIcon(rule.action.type),
              color: RuleActionDisplayUtils.getActionTypeColor(rule.action.type),
              size: 16,
            ),
            label: Text(
                '${AppLocalizations.of(context)!.action}: ${rule.action.type.toString().split('.').last}'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              rule.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            rule.phoneNumber.value,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}