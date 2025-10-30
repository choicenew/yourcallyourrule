import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/local_filter/provider/local_count_filter_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
// [重构]: 导入对应的 Notifier Provider。


/// [重构]: 将 StatelessWidget 改为 ConsumerWidget 以便访问 ref。
class LocalFilterSettingsWidget extends ConsumerWidget {
  // [重构]: 移除所有构造函数参数，因为 Widget 将自己管理状态。
  const LocalFilterSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [修正]: 使用 .select 只监听 provider 的数据部分 (`value`) 以避免UI闪烁。
    final config = ref.watch(localCountFilterConfigProvider.select((asyncValue) => asyncValue.value));
    
    // [修正]: 如果初始数据尚未加载（config 为 null），则显示一个加载指示器。
    if (config == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    // [注释]: 获取 notifier 以便调用更新方法。
    final notifier = ref.read(localCountFilterConfigProvider.notifier);

    return Column(
      children: [
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.enableLocalCountFilter),
          subtitle: Text(AppLocalizations.of(context)!.enableLocalCountFilterDescription),
          value: config.enableLocalCountFilter,
          onChanged: (value) => notifier.updateConfig(config.copyWith(enableLocalCountFilter: value)),
        ),
        const Divider(),
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
        const SizedBox(height: 16),
        GoogleAdWidget(adInfo: AdManager.bannerAd),  
        const SizedBox(height: 16),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.rejectExceededNumbers),
          subtitle: Text(AppLocalizations.of(context)!.rejectExceededNumbersDescription),
          value: config.rejectExceededNumbers,
          onChanged: (value) => notifier.updateConfig(config.copyWith(rejectExceededNumbers: value)),
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowNonExceededNumbers),
          subtitle: Text(AppLocalizations.of(context)!.allowNonExceededNumbersDescription),
          value: config.allowNonExceededNumbers,
          onChanged: (value) => notifier.updateConfig(config.copyWith(allowNonExceededNumbers: value)),
        ),
        const SizedBox(height: 16),
        GoogleAdWidget(adInfo: AdManager.bannerAd),  
        const SizedBox(height: 16),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.logAllLocalQueries),
          subtitle: Text(AppLocalizations.of(context)!.logAllLocalQueriesDescription),
          value: config.logAllLocalQueries,
          onChanged: (value) => notifier.updateConfig(config.copyWith(logAllLocalQueries: value)),
        ),
        const SizedBox(height: 32),
        _buildExplanationCard(context),
        const SizedBox(height: 32),
        InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd,width: 400),
      ],
    );
  }

  // [注释]: 说明卡片是一个纯静态UI，可以保持为私有辅助方法。
  Widget _buildExplanationCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.localCountFilterExplanationTitle, 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.localCountFilterExplanationContent),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.howItWorksTitle),
            Text("• ${AppLocalizations.of(context)!.localCountFilterHowItWorksPoint1}"),
            Text("• ${AppLocalizations.of(context)!.localCountFilterHowItWorksPoint2}"),
            Text("• ${AppLocalizations.of(context)!.localCountFilterHowItWorksPoint3}"),
            Text("• ${AppLocalizations.of(context)!.localCountFilterHowItWorksPoint4}"),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.localCountFilterUseCases),
          ],
        ),
      ),
    );
  }
}