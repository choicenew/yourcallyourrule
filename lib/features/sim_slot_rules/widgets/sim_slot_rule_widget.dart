import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_sim_slot_rules_protocol/pyro_phone_sim_slot_rules_protocol.dart';
import 'package:pyro_phone_sim_slot_rules_ui/pyro_phone_sim_slot_rules_ui.dart';
import 'package:yourcallyourrule/features/call_filter/providers/sim_slot_config_provider.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

final simSlotRulesProvider = FutureProvider.family<List<SimSlotRuleEntity>, int>((ref, simSlotIndex) {
  final service = ref.watch(simSlotRuleServiceProvider);
  return service.getSimSlotRules(simSlotIndex);
});

/// SIM卡槽位规则管理组件 —— 100% 渲染包内 pyro_sim_slot_rules_ui 导出的 PyroSimSlotRuleCardWidget
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
                  title: Text('${AppLocalizations.of(context).simSlot} ${simSlotIndex + 1}'),
                  subtitle: Text(
                    isEnabled ? AppLocalizations.of(context).enabled : AppLocalizations.of(context).disabled,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${rules.length} ${AppLocalizations.of(context).simSlotRules}'),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: onTap,
                ),
                SwitchListTile(
                  title: Text(AppLocalizations.of(context).enableFiltering),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: rules
                          .take(3)
                          .map((rule) => PyroSimSlotRuleCardWidget(rule: rule))
                          .toList(),
                    ),
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
}
