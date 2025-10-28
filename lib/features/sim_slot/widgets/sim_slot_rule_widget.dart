import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/features/rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/features/sim_slot/services/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// SIM卡槽位规则管理组件
/// 用于在设置页面中显示SIM卡槽位规则的简要信息和管理入口
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
    final l10n = AppLocalizations.of(context)!;
    final service = ref.watch(simSlotRuleServiceProvider);
    final isEnabledAsyncValue = ref.watch(isSimSlotFilterEnabledProvider(simSlotIndex));

    return FutureBuilder<List<SimSlotRule>>(
      future: service.getSimSlotRules(simSlotIndex),
      builder: (context, snapshot) {
        final rules = snapshot.data ?? [];
        return isEnabledAsyncValue.when(
          data: (isEnabled) => Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                ListTile(
                  title: Text('${l10n.simSlot} ${simSlotIndex + 1}'),
                  subtitle: Text(
                    isEnabled ? l10n.enabled : l10n.disabled,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${rules.length} ${l10n.simSlotRules}'),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: onTap,
                ),
                SwitchListTile(
                  title: Text(l10n.enableFiltering),
                  value: isEnabled,
                  onChanged: (value) async {
                    if (value) {
                      await service.enableSimSlotFilter(simSlotIndex);
                    } else {
                      await service.disableSimSlotFilter(simSlotIndex);
                    }
                    service.invalidateFilterProvider(ref, simSlotIndex);
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
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
        );
      },
    );
  }

  Widget _buildRuleSummary(BuildContext context, List<SimSlotRule> rules) {
    // 显示前3条规则的简要信息
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
              color: RuleActionDisplayUtils.getActionTypeColor(
                  rule.action.type),
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