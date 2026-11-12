import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_type.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/widgets/sim_slot_rule_widget.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/enhanced_filter_config_provider.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/providers/sim_slot_rule_page_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class SimSlotRuleFilterPage extends ConsumerWidget {
  final int simSlotIndex;

  const SimSlotRuleFilterPage({
    super.key,
    required this.simSlotIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageStateAsync = ref.watch((simSlotRulePageProvider as dynamic)(simSlotIndex) as dynamic);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.simSlotTitle(simSlotIndex + 1)),
        actions: [
          pageStateAsync.when(
            data: (state) {
              final isEnabled = ref.watch(
                enhancedFilterConfigProvider.select((configAsync) {
                  return configAsync.value
                          ?.simSlotFilterConfigMap[simSlotIndex]?[
                      CallFilterType.simSlotRule] ??
                      true;
                }),
              );

              return Switch(
                value: isEnabled,
                onChanged: (value) {
                  final notifier = ref.read(enhancedFilterConfigProvider.notifier);
                  if (value) {
                    notifier.enableFilterForSimSlot(
                      simSlotIndex,
                      CallFilterType.simSlotRule,
                    );
                  } else {
                    notifier.disableFilterForSimSlot(
                      simSlotIndex,
                      CallFilterType.simSlotRule,
                    );
                  }
                },
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: SimSlotRuleWidget(simSlotIndex: simSlotIndex, onTap: () {}),
    );
  }
}
