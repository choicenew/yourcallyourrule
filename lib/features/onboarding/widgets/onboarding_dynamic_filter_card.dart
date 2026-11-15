import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/local_filter/provider/local_count_filter_provider.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_filter_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 引导页：动态组合过滤规则与插件引擎卡片组件 (基于 FilterUiRegistry 注册框架)
class OnboardingDynamicFilterCard extends ConsumerWidget {
  const OnboardingDynamicFilterCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    final localConfigAsync = ref.watch(localCountFilterConfigProvider);
    final localConfig = localConfigAsync.value;
    final localNotifier = ref.read(localCountFilterConfigProvider.notifier);

    final remoteConfigAsync = ref.watch(remoteNumberFilterConfigProvider);
    final remoteConfig = remoteConfigAsync.value;
    final remoteNotifier = ref.read(remoteNumberFilterConfigProvider.notifier);

    final isLocalEnabled = localConfig?.enableLocalCountFilter ?? true;
    final isRemoteEnabled = remoteConfig?.enableRemoteNumberFilter ?? true;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 上层：FilterUiRegistry 动态规则库注册展示 Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
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
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.extension_rounded, color: theme.colorScheme.primary, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.enhancedFilterSettingsTitle,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            l10n.globalFilterDescription,
                            style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurfaceVariant),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // 动态规则模块芯片标签展示
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _buildFilterChip('Local Count', isLocalEnabled, theme),
                    _buildFilterChip('Remote Risk', isRemoteEnabled, theme),
                    _buildFilterChip('Time Window', true, theme),
                    _buildFilterChip('SIM Slot Rules', true, theme),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.enhancedFilterSettingsTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.globalFilterDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // 下层：直接交互 Local Count & Remote Risk 开关控制
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
                  title: Text(l10n.localCountFilter, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  subtitle: Text(l10n.localCountFilterDescription, style: const TextStyle(fontSize: 11)),
                  value: isLocalEnabled,
                  onChanged: (val) {
                    if (localConfig != null) {
                      localNotifier.updateConfig(localConfig.copyWith(enableLocalCountFilter: val));
                    }
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  dense: true,
                  title: Text(l10n.remoteFilterSettings, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  subtitle: Text(l10n.remoteNumberFilterSubtitle, style: const TextStyle(fontSize: 11)),
                  value: isRemoteEnabled,
                  onChanged: (val) {
                    if (remoteConfig != null) {
                      remoteNotifier.updateConfig(remoteConfig.copyWith(enableRemoteNumberFilter: val));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isEnabled, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isEnabled
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.6)
            : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isEnabled ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isEnabled ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
