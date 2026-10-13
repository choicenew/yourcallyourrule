import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通知设置小部件
class NotificationSettingsWidget extends ConsumerWidget {
  const NotificationSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(callerIdConfigProvider);
    final notifier = ref.read(callerIdConfigProvider.notifier);
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
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
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.notifications_rounded, color: theme.colorScheme.primary, size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.notificationSettingsTitle,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(AppLocalizations.of(context)!.useLocalNotification, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: theme.colorScheme.onSurface)),
            subtitle: Text(AppLocalizations.of(context)!.useLocalNotificationDescription, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
            activeColor: theme.colorScheme.primary,
            value: config.useLocalNotification,
            onChanged: (value) => notifier.setUseLocalNotification(value),
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(AppLocalizations.of(context)!.cancelLocalNotification, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: theme.colorScheme.onSurface)),
            subtitle: Text(AppLocalizations.of(context)!.cancelLocalNotificationDescription, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
            activeColor: theme.colorScheme.primary,
            value: config.cancelLocalNotification,
            onChanged: (value) => notifier.setCancelLocalNotification(value),
          ),
          if (config.cancelLocalNotification)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.setDelayTime,
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
      ),
    );
  }
}
