import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_filter_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';


/// [重构]: 转换为自包含的 ConsumerWidget。
class RemoteFilterSettingsWidget extends ConsumerWidget {
  // [重构]: 移除所有构造函数参数。
  const RemoteFilterSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [修正]: 使用 .select 只监听数据，避免UI闪烁。
    final config = ref.watch(remoteNumberFilterConfigProvider.select((v) => v.value));
    
    // [修正]: 初始加载时显示加载指示器。
    if (config == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    final notifier = ref.read(remoteNumberFilterConfigProvider.notifier);

    return Column(
      children: [
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.enableRemoteNumberFilter),
          subtitle: Text(AppLocalizations.of(context)!.enableRemoteNumberFilterDescription),
          value: config.enableRemoteNumberFilter,
          onChanged: (value) => notifier.updateConfig(config.copyWith(enableRemoteNumberFilter: value)),
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.rejectExceededNumbers),
          subtitle: Text(AppLocalizations.of(context)!.rejectExceededNumbersDescription),
          value: config.rejectExceededNumbers,
          onChanged: (value) => notifier.updateConfig(config.copyWith(rejectExceededNumbers: value)),
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.prioritizeRemoteAction),
          subtitle: Text(AppLocalizations.of(context)!.prioritizeRemoteActionDescription),
          value: config.prioritizeRemoteAction,
          onChanged: (value) => notifier.updateConfig(config.copyWith(prioritizeRemoteAction: value)),
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.logAllRemoteQueries),
          subtitle: Text(AppLocalizations.of(context)!.logAllRemoteQueriesDescription),
          value: config.logAllRemoteQueries,
          onChanged: (value) => notifier.updateConfig(config.copyWith(logAllRemoteQueries: value)),
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${AppLocalizations.of(context)!.countThresholdLabel}: ${config.countThreshold}', 
              style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Slider(
              value: config.countThreshold.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: config.countThreshold.toString(),
              onChanged: (value) => notifier.updateConfig(config.copyWith(countThreshold: value.round())),
            ),
            Text(AppLocalizations.of(context)!.countThresholdDescription),
          ],
        ),
      ],
    );
  }
}