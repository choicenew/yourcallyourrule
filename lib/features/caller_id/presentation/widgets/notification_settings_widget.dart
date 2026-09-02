import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通知设置小部件
/// 允许用户配置来电通知的相关设置
class NotificationSettingsWidget extends ConsumerWidget {
  const NotificationSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(callerIdConfigProvider);
    final notifier = ref.read(callerIdConfigProvider.notifier);
    
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: EliteDopamineTheme.warmCardDecoration(
        context: context,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.notifications_rounded, color: Color(0xFFFF9500), size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.notificationSettingsTitle,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(AppLocalizations.of(context)!.useLocalNotification, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5)),
            subtitle: Text(AppLocalizations.of(context)!.useLocalNotificationDescription, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            activeColor: const Color(0xFFFF9500),
            value: config.useLocalNotification,
            onChanged: (value) => notifier.setUseLocalNotification(value),
          ),
          const Divider(height: 1, color: Color(0xFFF0ECE3)),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(AppLocalizations.of(context)!.cancelLocalNotification, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5)),
            subtitle: Text(AppLocalizations.of(context)!.cancelLocalNotificationDescription, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            activeColor: const Color(0xFFFF9500),
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
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: config.notificationAutoCancelDelay.inSeconds.toDouble(),
                          min: 1,
                          max: 30,
                          divisions: 29,
                          activeColor: const Color(0xFFFF9500),
                          inactiveColor: const Color(0xFFEDE8DF),
                          label: "${config.notificationAutoCancelDelay.inSeconds} s",
                          onChanged: (value) {
                            notifier.setNotificationAutoCancelDelay(Duration(seconds: value.toInt()));
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF9500).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "${config.notificationAutoCancelDelay.inSeconds} s",
                          style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFFFF9500), fontSize: 13),
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