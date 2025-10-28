import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/local_filter/presentation/widgets/local_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/local_filter/provider/local_count_filter_provider.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

// [重构]: 从 StatefulWidget 改为 ConsumerWidget，不再需要手动传递依赖。
class LocalFilterSettingsPage extends ConsumerWidget {
  const LocalFilterSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [重构]: 使用 ref.watch 监听配置状态。UI 会在状态变化时自动重建。
    final configAsync = ref.watch(localCountFilterConfigProvider);
    // [重构]: 使用 ref.read 获取 Notifier 实例，用于调用其更新方法。
    final notifier = ref.read(localCountFilterConfigProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.localCountFilterSettings),
        actions: [
          // [重构]: 保存按钮现在只提供用户反馈，因为状态是实时更新的。
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
      // [重构]: 使用 .when 优雅地处理加载、错误和成功三种UI状态。
      body: configAsync.when(
        data: (config) => ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // [重构]: 将从 provider 获取的数据和 notifier 的更新方法传递给纯UI子组件。
            LocalFilterSettingsWidget(
              enableLocalCountFilter: config.enableLocalCountFilter,
              countThreshold: config.countThreshold,
              rejectExceededNumbers: config.rejectExceededNumbers,
              allowNonExceededNumbers: config.allowNonExceededNumbers,
              logAllLocalQueries: config.logAllLocalQueries,
              onEnableLocalCountFilterChanged: (value) => notifier.updateConfig(config.copyWith(enableLocalCountFilter: value)),
              onCountThresholdChanged: (value) => notifier.updateConfig(config.copyWith(countThreshold: value)),
              onRejectExceededNumbersChanged: (value) => notifier.updateConfig(config.copyWith(rejectExceededNumbers: value)),
              onAllowNonExceededNumbersChanged: (value) => notifier.updateConfig(config.copyWith(allowNonExceededNumbers: value)),
              onLogAllLocalQueriesChanged: (value) => notifier.updateConfig(config.copyWith(logAllLocalQueries: value)),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text(AppLocalizations.of(context)!.dataLoadFailure(err))),
      ),
    );
  }
}