import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/call_filter/config/call_filter_config.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/widgets/call_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/call_filter_provider.dart'; // 导入 Notifier Provider
import 'package:yourcallyourrule/generated/app_localizations.dart';

// [重构]: 从 StatefulWidget 改为 ConsumerWidget，不再需要通过构造函数传递依赖。
class CallFilterSettingsPage extends ConsumerWidget {
  const CallFilterSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [重构]: 监听配置的异步状态。
    final configAsync = ref.watch(callFilterConfigProvider);
    // [重构]: 获取 notifier 以便调用更新方法。
    final notifier = ref.read(callFilterConfigProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.callFilterSettings),
      ),
      // [重构]: 使用 .when 优雅地处理UI状态。
      body: configAsync.when(
        data: (config) => ListView(
          children: [
          // 使用提取的组件
            CallFilterSettingsWidget(
              config: config,
              // [重构]: onConfigChanged 回调现在直接调用 notifier.updateConfig。
              // 这里的逻辑保持了原有 map -> object 的转换，以完全匹配原始行为。
              onConfigChanged: (key, value) {
                final updatedMap = config.toMap()..[key] = value;
                notifier.updateConfig(CallFilterConfig.fromMap(updatedMap));
              },
              // [重构]: onSavePressed 现在仅用于用户反馈。
              onSavePressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.settingsSaved)),
                );
              },
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text(AppLocalizations.of(context)!.dataLoadFailure(err))),
      ),
    );
  }
}