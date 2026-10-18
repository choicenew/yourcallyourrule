import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通知子设置小部件（嵌入在来电显示模式选项卡内部）
class NotificationSettingsWidget extends ConsumerWidget {
  const NotificationSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(callerIdConfigProvider);
    final notifier = ref.read(callerIdConfigProvider.notifier);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            l10n.useLocalNotification,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: theme.colorScheme.onSurface),
          ),
          subtitle: Text(
            l10n.useLocalNotificationDescription,
            style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
          ),
          activeThumbColor: theme.colorScheme.primary,
          value: config.useLocalNotification,
          onChanged: (value) => notifier.setUseLocalNotification(value),
        ),
        Divider(height: 1, color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6)),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            l10n.cancelLocalNotification,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: theme.colorScheme.onSurface),
          ),
          subtitle: Text(
            l10n.cancelLocalNotificationDescription,
            style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
          ),
          activeThumbColor: theme.colorScheme.primary,
          value: config.cancelLocalNotification,
          onChanged: (value) => notifier.setCancelLocalNotification(value),
        ),
        if (config.cancelLocalNotification)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.setDelayTime,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: theme.colorScheme.onSurface),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: config.notificationAutoCancelDelay.inSeconds.toDouble(),
                        min: 1,
                        max: 30,
                        divisions: 29,
                        activeColor: theme.colorScheme.primary,
                        inactiveColor: theme.colorScheme.outlineVariant,
                        label: "${config.notificationAutoCancelDelay.inSeconds} s",
                        onChanged: (value) {
                          notifier.setNotificationAutoCancelDelay(Duration(seconds: value.toInt()));
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "${config.notificationAutoCancelDelay.inSeconds} s",
                        style: TextStyle(fontWeight: FontWeight.w900, color: theme.colorScheme.primary, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
