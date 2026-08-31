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
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFEDE8DF),
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.enableLocalCountFilter, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5)),
                subtitle: Text(AppLocalizations.of(context)!.enableLocalCountFilterDescription, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                activeColor: const Color(0xFFFF9500),
                value: config.enableLocalCountFilter,
                onChanged: (value) => notifier.updateConfig(config.copyWith(enableLocalCountFilter: value)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFEDE8DF),
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
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
                activeColor: const Color(0xFFFF9500),
                inactiveColor: const Color(0xFFEDE8DF),
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
        const SizedBox(height: 14),
        GoogleAdWidget(adInfo: AdManager.bannerAd),  
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFEDE8DF),
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.rejectExceededNumbers, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5)),
                subtitle: Text(AppLocalizations.of(context)!.rejectExceededNumbersDescription, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                activeColor: const Color(0xFFFF9500),
                value: config.rejectExceededNumbers,
                onChanged: (value) => notifier.updateConfig(config.copyWith(rejectExceededNumbers: value)),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFF0ECE3)),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.allowNonExceededNumbers, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5)),
                subtitle: Text(AppLocalizations.of(context)!.allowNonExceededNumbersDescription, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                activeColor: const Color(0xFFFF9500),
                value: config.allowNonExceededNumbers,
                onChanged: (value) => notifier.updateConfig(config.copyWith(allowNonExceededNumbers: value)),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFF0ECE3)),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.logAllLocalQueries, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5)),
                subtitle: Text(AppLocalizations.of(context)!.logAllLocalQueriesDescription, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                activeColor: const Color(0xFFFF9500),
                value: config.logAllLocalQueries,
                onChanged: (value) => notifier.updateConfig(config.copyWith(logAllLocalQueries: value)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        GoogleAdWidget(adInfo: AdManager.bannerAd),  
        const SizedBox(height: 14),
        _buildExplanationCard(context),
        const SizedBox(height: 14),
        InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd, width: 400),
      ],
    );
  }

  Widget _buildExplanationCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.info_outline_rounded, color: Color(0xFF6C5CE7), size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.localCountFilterExplanationTitle, 
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15.5, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.localCountFilterExplanationContent,
            style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.4),
          ),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)!.howItWorksTitle,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text("• ${AppLocalizations.of(context)!.localCountFilterHowItWorksPoint1}", style: const TextStyle(fontSize: 12.5, color: Colors.black54)),
          Text("• ${AppLocalizations.of(context)!.localCountFilterHowItWorksPoint2}", style: const TextStyle(fontSize: 12.5, color: Colors.black54)),
          Text("• ${AppLocalizations.of(context)!.localCountFilterHowItWorksPoint3}", style: const TextStyle(fontSize: 12.5, color: Colors.black54)),
          Text("• ${AppLocalizations.of(context)!.localCountFilterHowItWorksPoint4}", style: const TextStyle(fontSize: 12.5, color: Colors.black54)),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)!.localCountFilterUseCases,
            style: const TextStyle(fontSize: 12.5, color: Colors.black54, height: 1.4),
          ),
        ],
      ),
    );
  }
}