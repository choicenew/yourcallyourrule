import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';
import 'package:yourcallyourrule/features/phone_evaluators/config/label_action_config_provider.dart';
import 'package:yourcallyourrule/features/labels/utils/predefined_labels.dart';
import 'package:yourcallyourrule/features/phone_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/features/phone_filter/providers/sim_slot_config_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 引导页 5：强力骚扰拦截与双卡 (SIM 1/2) 规则演示卡片组件
class OnboardingSpamBlockCard extends ConsumerWidget {
  const OnboardingSpamBlockCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    final filterConfigAsync = ref.watch(callFilterConfigProvider);
    final filterConfig = filterConfigAsync.value;
    final isFilterEnabled = filterConfig?.enabled ?? true;

    final simSlotAsync = ref.watch(simSlotConfigProvider);
    final simState = simSlotAsync.value;
    final simNotifier = ref.read(simSlotConfigProvider.notifier);

    final sim1Enabled = simState?.simSlotFilterEnabled[0] ?? true;
    final sim2Enabled = simState?.simSlotFilterEnabled[1] ?? true;

    final labelActionMap = ref.watch(labelActionConfigProvider);
    final labelActionNotifier = ref.read(labelActionConfigProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
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
                      onChanged: (bool isEnabled) {
                        if (filterConfig != null) {
                          ref.read(callFilterConfigProvider.notifier).updateConfig(
                                filterConfig.copyWith(rejectAllNumbers: isEnabled),
                              );
                        }
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
          const SizedBox(height: 12),

          // 中层：常见高频分类自主勾选拦截区（用户主权，可自由多选或留空）
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.labelCategories,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
                    ),
                    Text(
                      l10n.selectedItems(labelActionMap.length),
                      style: TextStyle(fontSize: 11, color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: predefinedLabelEntities.map((labelEntity) {
                    final labelText = labelEntity.text;
                      final currentAction = labelActionMap[labelText];
                      final isSelected = currentAction != null;
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          // 直接点击弹出清晰的动作选择菜单（放行、立即挂断、静音），避免长按不明显
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) => SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: Text(
                                      labelText.translate(context),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      l10n.incomingCallInterceptAction,
                                    ),
                                  ),
                                  const Divider(height: 1),
                                  ListTile(
                                    leading: const Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                    ),
                                    title: Text(l10n.actionAllow),
                                    selected:
                                        currentAction == InterceptAction.allow,
                                    onTap: () {
                                      labelActionNotifier.setActionForLabel(
                                        labelText,
                                        InterceptAction.allow,
                                      );
                                      Navigator.pop(ctx);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(
                                      Icons.call_end,
                                      color: Colors.red,
                                    ),
                                    title: Text(l10n.endCallImmediately),
                                    selected:
                                        currentAction ==
                                        InterceptAction.endCall,
                                    onTap: () {
                                      labelActionNotifier.setActionForLabel(
                                        labelText,
                                        InterceptAction.endCall,
                                      );
                                      Navigator.pop(ctx);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(
                                      Icons.notifications_off,
                                      color: Colors.amber,
                                    ),
                                    title: Text(l10n.silenceAndNoAnswer),
                                    selected:
                                        currentAction ==
                                        InterceptAction.silenceNoAnswer,
                                    onTap: () {
                                      labelActionNotifier.setActionForLabel(
                                        labelText,
                                        InterceptAction.silenceNoAnswer,
                                      );
                                      Navigator.pop(ctx);
                                    },
                                  ),
                                  if (isSelected) ...[
                                    const Divider(height: 1),
                                    ListTile(
                                      leading: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.grey,
                                      ),
                                      title: Text(l10n.actionNone),
                                      onTap: () {
                                        labelActionNotifier
                                            .removeActionForLabel(labelText);
                                        Navigator.pop(ctx);
                                      },
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                      },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (currentAction == InterceptAction.allow
                                      ? Colors.green.withValues(alpha: 0.15)
                                      : (currentAction ==
                                                InterceptAction.silenceNoAnswer
                                            ? Colors.amber.withValues(
                                                alpha: 0.15,
                                              )
                                            : theme.colorScheme.primaryContainer
                                                  .withValues(alpha: 0.6)))
                                : theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? (currentAction == InterceptAction.allow
                                        ? Colors.green
                                        : (currentAction ==
                                                  InterceptAction
                                                      .silenceNoAnswer
                                              ? Colors.amber
                                              : theme.colorScheme.primary))
                                  : theme.colorScheme.outlineVariant,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                labelText.translate(context),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? theme.colorScheme.onSurface
                                      : theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              if (isSelected) ...[
                                const SizedBox(width: 4),
                                Icon(
                                  currentAction == InterceptAction.allow
                                      ? Icons.check
                                      : (currentAction ==
                                                InterceptAction.silenceNoAnswer
                                            ? Icons.volume_off
                                            : Icons.block),
                                  size: 12,
                                  color: currentAction == InterceptAction.allow
                                      ? Colors.green
                                      : (currentAction ==
                                                InterceptAction.silenceNoAnswer
                                            ? Colors.amber
                                            : Colors.red),
                                ),
                              ],
                            ],
                          ),
                        ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

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
                    Text(l10n.simSlotTitle(1), style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface)),
                    ChoiceChip(
                      label: Text(sim1Enabled ? l10n.enabled : l10n.disabled),
                      selected: sim1Enabled,
                      onSelected: (bool isSelected) {
                        if (isSelected) {
                          simNotifier.enableSimSlotFilter(0);
                        } else {
                          simNotifier.disableSimSlotFilter(0);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l10n.simSlotTitle(2), style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface)),
                    ChoiceChip(
                      label: Text(sim2Enabled ? l10n.enabled : l10n.disabled),
                      selected: sim2Enabled,
                      onSelected: (bool isSelected) {
                        if (isSelected) {
                          simNotifier.enableSimSlotFilter(1);
                        } else {
                          simNotifier.disableSimSlotFilter(1);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
