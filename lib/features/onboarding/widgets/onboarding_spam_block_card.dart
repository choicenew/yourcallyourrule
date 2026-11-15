import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/features/call_filter/providers/sim_slot_config_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 引导页 5：强力骚扰拦截与双卡 (SIM 1/2) 规则演示卡片组件
class OnboardingSpamBlockCard extends ConsumerWidget {
  const OnboardingSpamBlockCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    final isFilterEnabled = ref.watch(callFilterProvider);
    final simSlotConfig = ref.watch(simSlotConfigProvider);
    final simNotifier = ref.read(simSlotConfigProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 上层：拦截演示 Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: theme.colorScheme.error.withValues(alpha: 0.3)),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.error.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.block_rounded, color: theme.colorScheme.error, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.powerfulSpamBlocking,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            l10n.onboardingPowerfulSpamBlockingDescription,
                            style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: isFilterEnabled,
                      onChanged: (val) {
                        ref.read(callFilterProvider.notifier).toggleCallFilter(val);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n.blockedSpamCalls, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
                      Text('1,280+', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: theme.colorScheme.error)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.powerfulSpamBlocking,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.onboardingPowerfulSpamBlockingDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // 下层：双卡 (SIM 1 / SIM 2) 独立拦截规则控制面板
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('SIM 1 Rule', style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface)),
                    ChoiceChip(
                      label: Text(simSlotConfig.sim1Enabled ? 'Enabled' : 'Disabled'),
                      selected: simSlotConfig.sim1Enabled,
                      onSelected: (val) {
                        simNotifier.setSim1Enabled(val);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('SIM 2 Rule', style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface)),
                    ChoiceChip(
                      label: Text(simSlotConfig.sim2Enabled ? 'Enabled' : 'Disabled'),
                      selected: simSlotConfig.sim2Enabled,
                      onSelected: (val) {
                        simNotifier.setSim2Enabled(val);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
