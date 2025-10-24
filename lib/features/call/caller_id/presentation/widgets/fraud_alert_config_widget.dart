import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
// 【核心修正】: 导入新的 Notifier Provider
import 'package:yourcallyourrule/features/call/caller_id/providers/fraud_alert_config_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 诈骗提醒配置小部件
/// 允许用户配置诈骗提醒的启用状态、震动和自动取消功能。
class FraudAlertConfigWidget extends ConsumerWidget {
  const FraudAlertConfigWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. 直接 watch 新的 AsyncNotifierProvider 来获取异步状态
    final asyncConfig = ref.watch(fraudAlertConfigProvider);
    // 2. read Notifier 实例，以便调用其上的方法（如 updateConfig）
   final notifier = ref.read(fraudAlertConfigProvider.notifier);

    // 3. 使用 .when 来优雅地处理加载、错误和数据三种状态
    return asyncConfig.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading config: $err')),
      data: (config) {
        // 当数据成功加载后，构建 UI
        return Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded, size: 20, color: Colors.amber),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context)!.fraudAlerSettingTitle,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // 启用开关
                    SwitchListTile(
                      title: Text(AppLocalizations.of(context)!.enableFraudAlert),
                      subtitle: Text(AppLocalizations.of(context)!.enableFraudAlertDescription),
                      value: config.isEnabled,
                      onChanged: (value) {
                        // 调用 Notifier 的方法来更新状态
                        notifier.updateConfig(config.copyWith(isEnabled: value));
                      },
                    ),
                    const Divider(),
                    // 震动开关
                    SwitchListTile(
                      title: Text(AppLocalizations.of(context)!.enableVibration),
                      subtitle: Text(AppLocalizations.of(context)!.enableVibrationDescription),
                      value: config.isVibrationEnabled,
                      onChanged: (value) {
                        notifier.updateConfig(config.copyWith(isVibrationEnabled: value));
                      },
                    ),
                    const Divider(),
                    // 【新增】自动取消开关
                    SwitchListTile(
                      title: Text(AppLocalizations.of(context)!.autoCancelNotification), // 需要在您的 l10n 文件中添加
                      subtitle: Text(AppLocalizations.of(context)!.autoCancelNotificationDescription), // 需要在您的 l10n 文件中添加
                      value: config.isAutoCancelEnabled,
                      onChanged: (value) {
                        notifier.updateConfig(config.copyWith(isAutoCancelEnabled: value));
                      },
                    ),
                    // 【新增】如果自动取消已启用，则显示延迟时间滑块
                    if (config.isAutoCancelEnabled)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Text(AppLocalizations.of(context)!.setDelayTime), // 需要在您的 l10n 文件中添加
                            Expanded(
                              child: Slider(
                                value: config.autoCancelDelaySeconds.toDouble(),
                                min: 3,
                                max: 30,
                                divisions: 9, // (30-3)/3 = 9 steps
                                label: '${config.autoCancelDelaySeconds}s',
                                onChanged: (value) {
                                  // 只有在用户停止拖动时才更新，以避免过于频繁的重建
                                },
                                onChangeEnd: (value) {
                                  notifier.updateConfig(config.copyWith(autoCancelDelaySeconds: value.toInt()));
                                },
                              ),
                            ),
                            Text('${config.autoCancelDelaySeconds}s'),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd, width: 400),
          ],
        );
      },
    );
  }
}