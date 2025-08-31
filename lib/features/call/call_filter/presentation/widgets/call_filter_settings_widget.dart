import 'package:flutter/material.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_config.dart';
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
          (value) => onConfigChanged('rejectAllNumbers', value),
        ),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.allowAllowedNumbers,
          AppLocalizations.of(context)!.allowAllowedNumbersDesc,
          config.allowAllAllowedNumbers,
          (value) => onConfigChanged('allowAllAllowedNumbers', value),
        ),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.allowBlockedNumbers,
          AppLocalizations.of(context)!.allowBlockedNumbersDesc,
          config.allowBlockedNumbers,
          (value) => onConfigChanged('allowBlockedNumbers', value),
        ),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.allowRegexAllowRules,
          AppLocalizations.of(context)!.allowRegexAllowRulesDesc,
          config.allowRegexAllowRules,
          (value) => onConfigChanged('allowRegexAllowRules', value),
        ),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.allowAllAllowRules,
          AppLocalizations.of(context)!.allowAllAllowRulesDesc,
          config.allowAllAllowRules,
          (value) => onConfigChanged('allowAllAllowRules', value),
        ),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.allowRegexBlockRules,
          AppLocalizations.of(context)!.allowRegexBlockRulesDesc,
          config.allowRegexBlockRules,
          (value) => onConfigChanged('allowRegexBlockRules', value),
        ),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.enableMuteRules,
          AppLocalizations.of(context)!.enableMuteRulesDesc,
          config.allowSilenceRules,
          (value) => onConfigChanged('allowSilenceRules', value),
        ),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.enableNoneActionRules,
          AppLocalizations.of(context)!.enableNoneActionRulesDesc,
          config.allowNoneRules,
          (value) => onConfigChanged('allowNoneRules', value),
        ),
        _buildSwitchListTile(
          AppLocalizations.of(context)!.allowAllBlockRules,
          AppLocalizations.of(context)!.allowAllBlockRulesDesc,
          config.allowAllBlockRules,
          (value) => onConfigChanged('allowAllBlockRules', value),
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