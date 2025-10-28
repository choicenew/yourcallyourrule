import 'package:flutter/material.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/call/call_filter/config/call_filter_config.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通话过滤设置组件
/// 用于配置通话过滤规则
class CallFilterSettingsWidget extends StatelessWidget {
  // 配置参数
  final CallFilterConfig config;
  
  // 回调函数
  final Function(String, bool) onConfigChanged;
  final VoidCallback onSavePressed;

  const CallFilterSettingsWidget({
    super.key,
    required this.config,
    required this.onConfigChanged,
    required this.onSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          GoogleAdWidget(adInfo: AdManager.bannerAd),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.rejectAllNumbers,
          AppLocalizations.of(context)!.rejectAllNumbersDesc,
          config.rejectAllNumbers,
          (value) => onConfigChanged(CallFilterConfig.keyRejectAllNumbers, value),
        ),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.allowAllowedNumbers,
          AppLocalizations.of(context)!.allowAllowedNumbersDesc,
          config.allowAllAllowedNumbers,
          (value) => onConfigChanged(CallFilterConfig.keyAllowAllAllowedNumbers, value),
        ),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.allowBlockedNumbers,
          AppLocalizations.of(context)!.allowBlockedNumbersDesc,
          config.allowBlockedNumbers,
          (value) => onConfigChanged(CallFilterConfig.keyAllowBlockedNumbers, value),
        ),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.allowRegexAllowRules,
          AppLocalizations.of(context)!.allowRegexAllowRulesDesc,
          config.allowRegexAllowRules,
          (value) => onConfigChanged(CallFilterConfig.keyAllowRegexAllowRules, value),
        ),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.allowAllAllowRules,
          AppLocalizations.of(context)!.allowAllAllowRulesDesc,
          config.allowAllAllowRules,
          (value) => onConfigChanged(CallFilterConfig.keyAllowAllAllowRules, value),
        ),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.allowRegexBlockRules,
          AppLocalizations.of(context)!.allowRegexBlockRulesDesc,
          config.allowRegexBlockRules,
          (value) => onConfigChanged(CallFilterConfig.keyAllowRegexBlockRules, value),
        ),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.enableMuteRules,
          AppLocalizations.of(context)!.enableMuteRulesDesc,
          config.allowSilenceRules,
          (value) => onConfigChanged(CallFilterConfig.keyAllowSilenceRules, value),
        ),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.enableNoneActionRules,
          AppLocalizations.of(context)!.enableNoneActionRulesDesc,
          config.allowNoneRules,
          (value) => onConfigChanged(CallFilterConfig.keyAllowNoneRules, value),
        ),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.allowAllBlockRules,
          AppLocalizations.of(context)!.allowAllBlockRulesDesc,
          config.allowAllBlockRules,
          (value) => onConfigChanged(CallFilterConfig.keyAllowAllBlockRules, value),
        ),
         
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: onSavePressed,
            child: Text(AppLocalizations.of(context)!.saveSettings),
          ),
        ),
        InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd,width: 400),
      ],
    );
  }

  Widget _buildSwitchListTile(
      String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}