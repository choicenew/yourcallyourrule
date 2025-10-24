import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通知设置小部件
/// 允许用户配置来电通知的相关设置
class NotificationSettingsWidget extends ConsumerWidget {
  const NotificationSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(callerIdConfigProvider);
    final notifier = ref.read(callerIdConfigProvider.notifier);
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.notifications, size: 20),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.notificationSettingsTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.useLocalNotification),
              subtitle: Text(AppLocalizations.of(context)!.useLocalNotificationDescription),
              value: config.useLocalNotification,
              onChanged: (value) => notifier.setUseLocalNotification(value),
            ),
            const Divider(),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.cancelLocalNotification),
              subtitle: Text(AppLocalizations.of(context)!.cancelLocalNotificationDescription),
              value: config.cancelLocalNotification,
              onChanged: (value) => notifier.setCancelLocalNotification(value),
            ),
                        // 【新增】: 只有当“自动取消”开启时，才显示延迟时间设置
            if (config.cancelLocalNotification)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.setDelayTime, // 需要在 .arb 文件中添加
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            value: config.notificationAutoCancelDelay.inSeconds.toDouble(),
                            min: 1,
                            max: 30,
                            divisions: 29, // 30 - 1
                            label: "${config.notificationAutoCancelDelay.inSeconds} s",
                            onChanged: (value) {
                              notifier.setNotificationAutoCancelDelay(Duration(seconds: value.toInt()));
                            },
                          ),
                        ),
                        Text("${config.notificationAutoCancelDelay.inSeconds} s"),
                      ],
                    ),
                  ],
                ),
              ),
              /*
            const Divider(),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.useStirNotification),
              subtitle: Text(AppLocalizations.of(context)!.useStirNotificationDescription),
              value: config.useStirNotification,
              onChanged: (value) => notifier.setUseStirNotification(value),
            ),
*/


          ],
        ),
      ),
    );
  }
}