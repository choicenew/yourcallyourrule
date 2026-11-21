import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_call_redirection_ui/pyro_call_redirection_ui.dart';
import 'package:yourcallyourrule/features/labels/utils/predefined_labels.dart';
import 'package:yourcallyourrule/features/phone_evaluators/config/outbound_blocked_labels_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 引导页：去电重定向与防回拨欺诈保护卡片 (Outbound Protection)
class OnboardingOutboundProtectionCard extends ConsumerWidget {
  const OnboardingOutboundProtectionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(callRedirectionSettingsProvider);
    final notifier = ref.read(callRedirectionSettingsProvider.notifier);

    final isEnabled = settings.enableRedirection;
    final blockedLabels = ref.watch(outboundBlockedLabelsProvider);
    final outboundNotifier = ref.read(outboundBlockedLabelsProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          // 上层 Banner：去电拦截演示
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isEnabled
                    ? theme.colorScheme.primary.withValues(alpha: 0.4)
                    : theme.colorScheme.outlineVariant,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.08),
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
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isEnabled
                            ? theme.colorScheme.primaryContainer
                            : theme.colorScheme.surfaceContainerHighest,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.phone_forwarded_rounded,
                        color: isEnabled ? theme.colorScheme.primary : theme.colorScheme.outline,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.callRedirectionSettingsTitle,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.callRedirectionSettingsSubtitle,
                            style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // 演示高危号码防护提醒卡
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.colorScheme.error.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.shield_outlined, color: theme.colorScheme.error, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l10n.fraudAlert,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onErrorContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.callRedirectionSettingsTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.callRedirectionSettingsSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant, height: 1.4),
          ),
          const SizedBox(height: 16),

          // 下层交互控制卡片
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  dense: true,
                  title: Text(l10n.callRedirectionSettingsTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  subtitle: Text(l10n.callRedirectionSettingsSubtitle, style: const TextStyle(fontSize: 11)),
                  value: isEnabled,
                  onChanged: (val) => notifier.toggleRedirection(val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  dense: true,
                  title: Text(l10n.fraudAlertTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  subtitle: Text(l10n.fraudAlertsDescription, style: const TextStyle(fontSize: 11)),
                  value: settings.enableAutoBlockHighRisk,
                  onChanged: (val) => notifier.toggleAutoBlockHighRisk(val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 核心：自主勾选呼出重定向/防诈拦截的标签分类 (Outbound Label Redirection Selection)
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
                      l10n.selectedItems(blockedLabels.length),
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
                    final isSelected = blockedLabels.contains(labelText);
                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        outboundNotifier.toggleLabel(labelText);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                                fontSize: 11,
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
          ),
        ],
      ),
      ),
    );
  }
}

