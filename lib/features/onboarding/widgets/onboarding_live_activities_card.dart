import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/live_activities/providers/live_notification_config_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 引导页 3：主力来电提醒 - 实时通知/动态胶囊卡片组件
class OnboardingLiveActivitiesCard extends ConsumerWidget {
  const OnboardingLiveActivitiesCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final configAsync = ref.watch(liveNotificationConfigProvider);
    final config = configAsync.value;
    final notifier = ref.read(liveNotificationConfigProvider.notifier);

    final isAvatarVisible = config?.avatar.visible ?? true;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 上层：Live Activity / 动态胶囊模拟卡片
          Container(
            padding: const EdgeInsets.all(16),
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
                // 模拟 Live Activity 横幅
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      if (isAvatarVisible) ...[
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.notifications_active_rounded, color: theme.colorScheme.onPrimary, size: 20),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '+1 (800) ***-0***',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n.smartCallerId,
                              style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Live Activity',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildFeatureTag(Icons.bolt_rounded, 'Fast Alert', theme),
                    _buildFeatureTag(Icons.notifications_rounded, 'Heads-up', theme),
                    _buildFeatureTag(Icons.security_rounded, 'Safe & Clean', theme),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.liveNotificationCustomizationTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.liveNotificationCustomizationSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // 下层：直接交互控制面板
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                l10n.liveNotificationCustomizationTitle,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                l10n.liveNotificationCustomizationSubtitle,
                style: const TextStyle(fontSize: 11),
              ),
              value: isAvatarVisible,
              onChanged: (val) {
                notifier.updateElementVisibility('avatar', val);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTag(IconData icon, String label, ThemeData theme) {
    return Row(
      children: [
        Icon(icon, size: 14, color: theme.colorScheme.primary),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }
}
