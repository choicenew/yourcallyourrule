// lib/features/caller_id/ui/widgets/caller_id_display_mode_selector.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 来电显示模式选择器小部件
/// 允许用户选择来电信息的显示方式：浮窗、通知或 Live Activity
class CallerIdDisplayModeSelector extends ConsumerWidget {
  const CallerIdDisplayModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 你的 provider 是 callerIdConfigProvider，而不是 callerIdStyleSecurityProvider
    // 我将严格使用你在这里定义的 provider
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
                const Icon(Icons.dvr, size: 20), // 使用一个更通用的图标
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.callerIdDisplayMode,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildRadioOption(
              context: context,
              title: AppLocalizations.of(context)!.overlayMode,
              subtitle: AppLocalizations.of(context)!.overlayModeDescription,
              value: 'overlay',
              groupValue: config.displayMode,
              onChanged: (value) => notifier.setDisplayMode(value!),
            ),
            const Divider(),
            _buildRadioOption(
              context: context,
              title: AppLocalizations.of(context)!.notificationMode,
              subtitle: AppLocalizations.of(context)!.notificationModeDescription,
              value: 'notification',
              groupValue: config.displayMode,
              onChanged: (value) => notifier.setDisplayMode(value!),
            ),
            const Divider(), // --- 新增分割线 ---
            // --- 新增：Live Activity 选项 ---
            _buildRadioOption(
              context: context,
              title: AppLocalizations.of(context)!.liveActivityMode, // <-- 需要在国际化文件中添加
              subtitle: AppLocalizations.of(context)!.liveActivityModeDescription, // <-- 需要在国际化文件中添加
              value: 'live_activity',
              groupValue: config.displayMode,
              onChanged: (value) => notifier.setDisplayMode(value!),
            ),
            const SizedBox(height: 16),
            InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd,width: 400),
          ],
        ),
      ),
    );
  }
  
  /// 构建单选项 (你的代码，无需修改)
  Widget _buildRadioOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String value,
    required String groupValue,
    required void Function(String?) onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}