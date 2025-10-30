import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/provider/time_interceptor_provider.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

// [重构]: 将 StatelessWidget 改为 ConsumerWidget 以便访问 ref。
class TimeInterceptorSettingsWidget extends ConsumerWidget {
  
  // [重构]: 移除所有构造函数参数，因为 Widget 将自己管理状态。
  const TimeInterceptorSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ▼▼▼▼▼ 核心修正部分 ▼▼▼▼▼
    // [修正]: 使用 .select 只监听 provider 的 data 部分。
    // 这将防止 widget 在 provider 进入 loading/error 状态时重建为一个占位符。
    // 我们只关心配置数据本身 `asyncValue.value`。
    final config = ref.watch(timeInterceptorConfigProvider.select((asyncValue) => asyncValue.value));
    
    
    
    
    // [修正]: 仅在初始加载时显示加载指示器。
    // 如果 config 为 null，意味着数据从未成功加载过。
    if (config == null) {
      // 检查是否有错误状态
      final configAsync = ref.watch(timeInterceptorConfigProvider);
      if (configAsync.hasError) {
        return Center(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Error: ${configAsync.error}'),
        ));
      }
      return const Center(child: CircularProgressIndicator());
    }
    // ▲▲▲▲▲ 修正结束 ▲▲▲▲▲

    // [注释]: 获取 notifier 以便调用更新方法。
    final notifier = ref.read(timeInterceptorConfigProvider.notifier);

    // [注释]: UI 部分现在总是能获取到 config 数据（即使是旧的），不会再闪烁。
    return Column(
      children: [
        // [注释]: isUpdating 可以在这里用于显示一个不明显的加载指示，例如在 AppBar 中。
        // 为了保持 UI 简洁，我们暂时不在这里显示它，但这个状态是可用的。
        _buildEnableSwitch(context, config.shouldIntercept, (value) {
            // [注释]: 在 onChanged 回调中直接调用 notifier 的方法。
          notifier.updateShouldIntercept(value);
        }),
        const Divider(),
          // [注释]: 当开关关闭时，禁用下面的设置以提供更好的用户体验。
        Opacity(
          opacity: config.shouldIntercept ? 1.0 : 0.5,
          child: IgnorePointer(
            ignoring: !config.shouldIntercept,
            child: _buildDurationSetting(context, config.duration.inMinutes, (value) {
              notifier.updateDuration(value);
            }),
          ),
        ),
        const SizedBox(height: 32),
        _buildExplanationCard(context),
      ],
    );
  }

  /// [注释]: 辅助构建方法保持不变。
  Widget _buildEnableSwitch(BuildContext context, bool isEnabled, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(AppLocalizations.of(context)!.enableTimeInterceptor),
      subtitle: Text(AppLocalizations.of(context)!.timeInterceptorDescription),
      value: isEnabled,
      onChanged: onChanged,
    );
  }

  /// [注释]: 辅助构建方法保持不变。
  Widget _buildDurationSetting(BuildContext context, int durationMinutes, ValueChanged<int> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            AppLocalizations.of(context)!.timeWindowLabel(durationMinutes), 
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 8),
        Slider(
          value: durationMinutes.toDouble(),
          min: 5,
          max: 120,
          divisions: 23,
          label: durationMinutes.toString(),
          onChanged: (value) {
            onChanged(value.round());
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(AppLocalizations.of(context)!.timeWindowDescription),
        ),
      ],
    );
  }

  /// [注释]: 说明卡片是一个纯静态UI，保持不变。
  Widget _buildExplanationCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.timeInterceptorExplanationTitle, 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.timeInterceptorExplanationContent),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.howItWorksTitle),
            Text("• ${AppLocalizations.of(context)!.howItWorksPoint1}"),
            Text("• ${AppLocalizations.of(context)!.howItWorksPoint2}"),
            Text("• ${AppLocalizations.of(context)!.howItWorksPoint3}"),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.useCasesTitle),
            Text("• ${AppLocalizations.of(context)!.useCasesPoint1}"),
            Text("• ${AppLocalizations.of(context)!.useCasesPoint2}"),
            Text("• ${AppLocalizations.of(context)!.useCasesPoint3}"),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.differentFromLocalCounter),
          ],
        ),
      ),
    );
  }
}