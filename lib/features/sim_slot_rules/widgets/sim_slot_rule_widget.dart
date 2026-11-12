import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/sim_slot_config_provider.dart';
import 'package:yourcallyourrule/features/phone_rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

final simSlotRulesProvider = FutureProvider.family<List<SimSlotRule>, int>((ref, simSlotIndex) {
  final service = ref.watch(simSlotRuleServiceProvider);
  return service.getSimSlotRules(simSlotIndex);
});

/// SIM卡槽位规则管理组件
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
    final isEnabledAsync = ref.watch(simSlotConfigProvider.select((state) {
      return state.whenData((data) => data.simSlotFilterEnabled[simSlotIndex] ?? false);
    }));
    
    final rulesAsync = ref.watch(simSlotRulesProvider(simSlotIndex));
    
    final notifier = ref.read(simSlotConfigProvider.notifier);

    return rulesAsync.when(
      data: (rules) {
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
