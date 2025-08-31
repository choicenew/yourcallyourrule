import 'package:flutter/material.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';


/// 本地计数过滤器设置组件
/// 用于配置本地计数过滤器的相关参数
class LocalFilterSettingsWidget extends StatelessWidget {
  // 配置参数 - 与LocalCountFilterConfig保持一致
  final bool enableLocalCountFilter;
  final int countThreshold;
  final bool rejectExceededNumbers;
  final bool allowNonExceededNumbers;
  final bool logAllLocalQueries;
  
  // 回调函数
  final ValueChanged<bool> onEnableLocalCountFilterChanged;
  final ValueChanged<int> onCountThresholdChanged;
  final ValueChanged<bool> onRejectExceededNumbersChanged;
  final ValueChanged<bool> onAllowNonExceededNumbersChanged;
  final ValueChanged<bool> onLogAllLocalQueriesChanged;

  const LocalFilterSettingsWidget({
    super.key,
    required this.enableLocalCountFilter,
    required this.countThreshold,
    required this.rejectExceededNumbers,
    required this.allowNonExceededNumbers,
    required this.logAllLocalQueries,
    required this.onEnableLocalCountFilterChanged,
    required this.onCountThresholdChanged,
    required this.onRejectExceededNumbersChanged,
    required this.onAllowNonExceededNumbersChanged,
    required this.onLogAllLocalQueriesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildEnableSwitch(),
        const Divider(),
        _buildCountThresholdSetting(context),
        const SizedBox(height: 16),
          GoogleAdWidget(adInfo: AdManager.bannerAd),  
          const SizedBox(height: 16),
        _buildRejectExceededNumbersSetting(),
        const SizedBox(height: 16),
        _buildAllowNonExceededNumbersSetting(),
        const SizedBox(height: 16),
          GoogleAdWidget(adInfo: AdManager.bannerAd),  
        const SizedBox(height: 16),
        _buildLogAllLocalQueriesSetting(),
        const SizedBox(height: 32),
        _buildExplanationCard(),
        const SizedBox(height: 32),
        InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd,width: 400),
      ],
    );
  }

  /// 构建启用开关
  Widget _buildEnableSwitch() {
    return Builder(
      builder: (context) => SwitchListTile(
        title: Text(AppLocalizations.of(context)!.enableLocalCountFilter),
        subtitle: Text(AppLocalizations.of(context)!.enableLocalCountFilterDescription),
        value: enableLocalCountFilter,
        onChanged: onEnableLocalCountFilterChanged,
      ),
    );
  }

  /// 构建计数阈值设置
  Widget _buildCountThresholdSetting(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${AppLocalizations.of(context)!.countThresholdLabel}: $countThreshold', 
          style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Slider(
          value: countThreshold.toDouble(),
          min: 1,
          max: 10,
          divisions: 9,
          label: countThreshold.toString(),
          onChanged: (value) {
            onCountThresholdChanged(value.round());
          },
        ),
        Text(AppLocalizations.of(context)!.countThresholdDescription),
      ],
    );
  }

  /// 构建拒绝超过阈值的号码设置
  Widget _buildRejectExceededNumbersSetting() {
    return Builder(
      builder: (context) => SwitchListTile(
        title: Text(AppLocalizations.of(context)!.rejectExceededNumbers),
        subtitle: Text(AppLocalizations.of(context)!.rejectExceededNumbersDescription),
        value: rejectExceededNumbers,
        onChanged: onRejectExceededNumbersChanged,
      ),
    );
  }
  
  /// 构建允许未超过阈值的号码设置
  Widget _buildAllowNonExceededNumbersSetting() {
    return Builder(
      builder: (context) => SwitchListTile(
        title: Text(AppLocalizations.of(context)!.allowNonExceededNumbers),
        subtitle: Text(AppLocalizations.of(context)!.allowNonExceededNumbersDescription),
        value: allowNonExceededNumbers,
        onChanged: onAllowNonExceededNumbersChanged,
      ),
    );
  }
  
  /// 构建记录所有本地查询设置
  Widget _buildLogAllLocalQueriesSetting() {
    return Builder(
      builder: (context) => SwitchListTile(
        title: Text(AppLocalizations.of(context)!.logAllLocalQueries),
        subtitle: Text(AppLocalizations.of(context)!.logAllLocalQueriesDescription),
        value: logAllLocalQueries,
        onChanged: onLogAllLocalQueriesChanged,
      ),
    );
  }

  /// 构建说明卡片
  Widget _buildExplanationCard() {
    return Builder(
      builder: (context) => Card(
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
              Text(AppLocalizations.of(context)!.localCountFilterHowItWorksPoint1),
              Text(AppLocalizations.of(context)!.localCountFilterHowItWorksPoint2),
              Text(AppLocalizations.of(context)!.localCountFilterHowItWorksPoint3),
              Text(AppLocalizations.of(context)!.localCountFilterHowItWorksPoint4),
              const SizedBox(height: 8),
              Text(AppLocalizations.of(context)!.localCountFilterUseCases),
            ],
          ),
        ),
      ),
    );
  }
}