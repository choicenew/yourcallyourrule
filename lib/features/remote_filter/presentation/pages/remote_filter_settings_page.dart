import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/remote_filter/config/remote_number_filter_config.dart';
import 'package:yourcallyourrule/features/remote_filter/presentation/widgets/remote_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_filter_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// [重构]: 从 StatefulWidget 改为 ConsumerWidget。
class RemoteFilterSettingsPage extends ConsumerWidget {
  const RemoteFilterSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [重构]: 监听配置状态。
    final configAsync = ref.watch(remoteNumberFilterConfigProvider);
    // [重构]: 获取 Notifier 实例。
    final notifier = ref.read(remoteNumberFilterConfigProvider.notifier);
    
    // [注释]: 在 AppBar 中增加一个加载指示器，当配置正在保存时显示。
    final isLoading = configAsync.isReloading || (configAsync.isLoading && !configAsync.hasValue);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.remoteFilterSettingsPageTitle),
        actions: [
          // [重构]: 根据加载状态显示进度条或保存按钮。
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white)),
            )
          else
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.settingsSaved)),
                );
              },
              tooltip: AppLocalizations.of(context)!.saveSettings,
            ),
        ],
      ),
      // [重构]: 使用 .when 处理UI状态。
      body: configAsync.when(
        data: (config) => ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            RemoteFilterSettingsWidget(
              enableRemoteNumberFilter: config.enableRemoteNumberFilter,
              countThreshold: config.countThreshold,
              rejectExceededNumbers: config.rejectExceededNumbers,
              allowNonExceededNumbers: config.allowNonExceededNumbers,
              prioritizeRemoteAction: config.prioritizeRemoteAction,
              // [修正]: 确保所有必需的参数都被传递，不遗漏任何一个。
              logAllRemoteQueries: config.logAllRemoteQueries,
              isLoading: isLoading,
              onEnableRemoteNumberFilterChanged: (value) => notifier.updateConfig(config.copyWith(enableRemoteNumberFilter: value)),
              onCountThresholdChanged: (value) => notifier.updateConfig(config.copyWith(countThreshold: value)),
              onRejectExceededNumbersChanged: (value) => notifier.updateConfig(config.copyWith(rejectExceededNumbers: value)),
              onAllowNonExceededNumbersChanged: (value) => notifier.updateConfig(config.copyWith(allowNonExceededNumbers: value)),
              onPrioritizeRemoteActionChanged: (value) => notifier.updateConfig(config.copyWith(prioritizeRemoteAction: value)),
              onLogAllRemoteQueriesChanged: (value) => notifier.updateConfig(config.copyWith(logAllRemoteQueries: value)),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text(AppLocalizations.of(context)!.loadSettingsFailed(err.toString()))),
      ),
    );
  }
}