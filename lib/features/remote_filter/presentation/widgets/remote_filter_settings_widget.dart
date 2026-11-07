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
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
              width: 1.1,
            ),
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.enableRemoteNumberFilter, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Theme.of(context).colorScheme.onSurface)),
                subtitle: Text(AppLocalizations.of(context)!.enableRemoteNumberFilterDescription, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                activeColor: Theme.of(context).colorScheme.primary,
                value: config.enableRemoteNumberFilter,
                onChanged: (value) => notifier.updateConfig(config.copyWith(enableRemoteNumberFilter: value)),
              ),
              Divider(height: 1, indent: 16, endIndent: 16, color: Theme.of(context).colorScheme.outlineVariant),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.rejectExceededNumbers, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Theme.of(context).colorScheme.onSurface)),
                subtitle: Text(AppLocalizations.of(context)!.rejectExceededNumbersDescription, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                activeColor: Theme.of(context).colorScheme.primary,
                value: config.rejectExceededNumbers,
                onChanged: (value) => notifier.updateConfig(config.copyWith(rejectExceededNumbers: value)),
              ),
              Divider(height: 1, indent: 16, endIndent: 16, color: Theme.of(context).colorScheme.outlineVariant),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.prioritizeRemoteAction, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Theme.of(context).colorScheme.onSurface)),
                subtitle: Text(AppLocalizations.of(context)!.prioritizeRemoteActionDescription, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                activeColor: Theme.of(context).colorScheme.primary,
                value: config.prioritizeRemoteAction,
                onChanged: (value) => notifier.updateConfig(config.copyWith(prioritizeRemoteAction: value)),
              ),
              Divider(height: 1, indent: 16, endIndent: 16, color: Theme.of(context).colorScheme.outlineVariant),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.logAllRemoteQueries, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Theme.of(context).colorScheme.onSurface)),
                subtitle: Text(AppLocalizations.of(context)!.logAllRemoteQueriesDescription, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                activeColor: Theme.of(context).colorScheme.primary,
                value: config.logAllRemoteQueries,
                onChanged: (value) => notifier.updateConfig(config.copyWith(logAllRemoteQueries: value)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
              width: 1.1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.countThresholdLabel,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9500).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${config.countThreshold}',
                      style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFFFF9500), fontSize: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Slider(
                value: config.countThreshold.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                activeColor: Theme.of(context).colorScheme.primary,
                inactiveColor: Theme.of(context).colorScheme.outlineVariant,
                label: config.countThreshold.toString(),
                onChanged: (value) => notifier.updateConfig(config.copyWith(countThreshold: value.round())),
              ),
              Text(
                AppLocalizations.of(context)!.countThresholdDescription,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}