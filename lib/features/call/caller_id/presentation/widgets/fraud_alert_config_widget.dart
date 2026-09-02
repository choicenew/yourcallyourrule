import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
// 【核心修正】: 导入新的 Notifier Provider
import 'package:yourcallyourrule/features/call/caller_id/providers/fraud_alert_config_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
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
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              padding: const EdgeInsets.all(16),
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
                        child: const Icon(Icons.warning_amber_rounded, size: 20, color: Color(0xFFFF9500)),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context)!.fraudAlerSettingTitle,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // 启用开关
                  SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.enableFraudAlert, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Colors.black87)),
                    subtitle: Text(AppLocalizations.of(context)!.enableFraudAlertDescription, style: TextStyle(fontSize: 12, color: Colors.grey[600], height: 1.3)),
                    value: config.isEnabled,
                    activeThumbColor: const Color(0xFF2D9CDB),
                    onChanged: (value) {
                      // 调用 Notifier 的方法来更新状态
                      notifier.updateConfig(config.copyWith(isEnabled: value));
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEDE8DF)),
                  // 震动开关
                  SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.enableVibration, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Colors.black87)),
                    subtitle: Text(AppLocalizations.of(context)!.enableVibrationDescription, style: TextStyle(fontSize: 12, color: Colors.grey[600], height: 1.3)),
                    value: config.isVibrationEnabled,
                    activeThumbColor: const Color(0xFF2D9CDB),
                    onChanged: (value) {
                      notifier.updateConfig(config.copyWith(isVibrationEnabled: value));
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEDE8DF)),
                  // 【新增】自动取消开关
                  SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.autoCancelNotification, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Colors.black87)), // 需要在您的 l10n 文件中添加
                    subtitle: Text(AppLocalizations.of(context)!.autoCancelNotificationDescription, style: TextStyle(fontSize: 12, color: Colors.grey[600], height: 1.3)), // 需要在您的 l10n 文件中添加
                    value: config.isAutoCancelEnabled,
                    activeThumbColor: const Color(0xFF2D9CDB),
                    onChanged: (value) {
                      notifier.updateConfig(config.copyWith(isAutoCancelEnabled: value));
                    },
                  ),
                  // 【新增】如果自动取消已启用，则显示延迟时间滑块
                  if (config.isAutoCancelEnabled) ...[
                    const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEDE8DF)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        children: [
                          Text(AppLocalizations.of(context)!.setDelayTime, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)), // 需要在您的 l10n 文件中添加
                          Expanded(
                            child: Slider(
                              value: config.autoCancelDelaySeconds.toDouble(),
                              min: 3,
                              max: 30,
                              divisions: 9, // (30-3)/3 = 9 steps
                              label: '${config.autoCancelDelaySeconds}s',
                              activeColor: const Color(0xFF2D9CDB),
                              onChanged: (value) {
                                // 只有在用户停止拖动时才更新，以避免过于频繁的重建
                              },
                              onChangeEnd: (value) {
                                notifier.updateConfig(config.copyWith(autoCancelDelaySeconds: value.toInt()));
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2D9CDB).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text('${config.autoCancelDelaySeconds}s', style: const TextStyle(color: Color(0xFF2D9CDB), fontWeight: FontWeight.w800, fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            const InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd, width: 400),
          ],
        );
      },
    );
  }
}