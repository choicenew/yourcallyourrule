import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/labels/utils/predefined_labels.dart';
import 'package:yourcallyourrule/features/phone_evaluators/config/outbound_blocked_labels_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 呼出/去电重定向防诈拦截标签管理卡片组件 (嵌入 Settings 与 CallRedirectionPage)
class OutboundBlockedLabelsSettingCard extends ConsumerWidget {
  const OutboundBlockedLabelsSettingCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final blockedLabels = ref.watch(outboundBlockedLabelsProvider);
    final notifier = ref.read(outboundBlockedLabelsProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.shield_outlined, color: theme.colorScheme.error, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.callRedirectionSettingsTitle,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface),
                    ),
                    Text(
                      l10n.selectedItems(blockedLabels.length),
                      style: TextStyle(fontSize: 12, color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            l10n.callRedirectionSettingsSubtitle,
            style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: theme.colorScheme.error.withValues(alpha: 0.25)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.shield_outlined, size: 16, color: theme.colorScheme.error),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '呼出防伪/外呼保护说明：当您拨打电话或点击回拨时，系统将检测目标号码是否属于勾选的高危/吸费标签。若命中将主动拦截并弹出二次确认预警，防止意外误拨与回拨吸费诈骗陷阱。',
                    style: TextStyle(fontSize: 12, color: theme.colorScheme.onErrorContainer, height: 1.35),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: predefinedLabelEntities.map((labelEntity) {
              final labelText = labelEntity.text;
              final isSelected = blockedLabels.contains(labelText);
              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  notifier.toggleLabel(labelText);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.colorScheme.errorContainer.withValues(alpha: 0.6)
                        : theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? theme.colorScheme.error : theme.colorScheme.outlineVariant,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        labelText.translate(context),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? theme.colorScheme.onErrorContainer : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: 4),
                        Icon(Icons.block, size: 12, color: theme.colorScheme.error),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

