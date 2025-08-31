import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 来电显示模式选择器小部件
/// 允许用户选择来电信息的显示方式：浮窗或通知
class CallerIdDisplayModeSelector extends ConsumerWidget {
  const CallerIdDisplayModeSelector({super.key});

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
                const Icon(Icons.call, size: 20),
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
            const SizedBox(height: 16),
            InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd,width: 400),
          ],
        ),
      ),
    );
  }
  
  /// 构建单选项
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