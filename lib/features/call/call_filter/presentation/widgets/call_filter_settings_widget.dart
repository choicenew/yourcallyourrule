import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/call/call_filter/config/call_filter_config.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// [重构]: 转换为自包含的 ConsumerWidget。
class CallFilterSettingsWidget extends ConsumerWidget {
  // [重构]: 移除所有构造函数参数。
  const CallFilterSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [修正]: 使用 .select 只监听数据，避免UI闪烁。
    final config = ref.watch(callFilterConfigProvider.select((v) => v.value));
    
    // [修正]: 初始加载时显示加载指示器。
    if (config == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    final notifier = ref.read(callFilterConfigProvider.notifier);
    
    // [注释]: 定义一个统一的回调函数，以保持代码整洁。
    void onConfigChanged(String key, bool value) {
      final updatedMap = config.toMap()..[key] = value;
      notifier.updateConfig(CallFilterConfig.fromMap(updatedMap));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: [
          const GoogleAdWidget(adInfo: AdManager.bannerAd),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            decoration: EliteDopamineTheme.warmCardDecoration(
              context: context,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                _buildSwitchListTile(
                  context,
                  AppLocalizations.of(context)!.rejectAllNumbers,
                  AppLocalizations.of(context)!.rejectAllNumbersDesc,
                  config.rejectAllNumbers,
                  (value) => onConfigChanged(CallFilterConfig.keyRejectAllNumbers, value),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEDE8DF)),
                _buildSwitchListTile(
                  context,
                  AppLocalizations.of(context)!.allowAllowedNumbers,
                  AppLocalizations.of(context)!.allowAllowedNumbersDesc,
                  config.allowAllAllowedNumbers,
                  (value) => onConfigChanged(CallFilterConfig.keyAllowAllAllowedNumbers, value),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEDE8DF)),
                _buildSwitchListTile(
                  context,
                  AppLocalizations.of(context)!.allowBlockedNumbers,
                  AppLocalizations.of(context)!.allowBlockedNumbersDesc,
                  config.allowBlockedNumbers,
                  (value) => onConfigChanged(CallFilterConfig.keyAllowBlockedNumbers, value),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEDE8DF)),
                _buildSwitchListTile(
                  context,
                  AppLocalizations.of(context)!.allowRegexAllowRules,
                  AppLocalizations.of(context)!.allowRegexAllowRulesDesc,
                  config.allowRegexAllowRules,
                  (value) => onConfigChanged(CallFilterConfig.keyAllowRegexAllowRules, value),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEDE8DF)),
                _buildSwitchListTile(
                  context,
                  AppLocalizations.of(context)!.allowAllAllowRules,
                  AppLocalizations.of(context)!.allowAllAllowRulesDesc,
                  config.allowAllAllowRules,
                  (value) => onConfigChanged(CallFilterConfig.keyAllowAllAllowRules, value),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEDE8DF)),
                _buildSwitchListTile(
                  context,
                  AppLocalizations.of(context)!.allowRegexBlockRules,
                  AppLocalizations.of(context)!.allowRegexBlockRulesDesc,
                  config.allowRegexBlockRules,
                  (value) => onConfigChanged(CallFilterConfig.keyAllowRegexBlockRules, value),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEDE8DF)),
                _buildSwitchListTile(
                  context,
                  AppLocalizations.of(context)!.enableMuteRules,
                  AppLocalizations.of(context)!.enableMuteRulesDesc,
                  config.allowSilenceRules,
                  (value) => onConfigChanged(CallFilterConfig.keyAllowSilenceRules, value),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEDE8DF)),
                _buildSwitchListTile(
                  context,
                  AppLocalizations.of(context)!.enableNoneActionRules,
                  AppLocalizations.of(context)!.enableNoneActionRulesDesc,
                  config.allowNoneRules,
                  (value) => onConfigChanged(CallFilterConfig.keyAllowNoneRules, value),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEDE8DF)),
                _buildSwitchListTile(
                  context,
                  AppLocalizations.of(context)!.allowAllBlockRules,
                  AppLocalizations.of(context)!.allowAllBlockRulesDesc,
                  config.allowAllBlockRules,
                  (value) => onConfigChanged(CallFilterConfig.keyAllowAllBlockRules, value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D9CDB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.settingsSaved)),
                );
              },
              child: Text(AppLocalizations.of(context)!.saveSettings, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
            ),
          ),
          const SizedBox(height: 14),
          const InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd, width: 400),
        ],
      ),
    );
  }

  Widget _buildSwitchListTile(
      BuildContext context, String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Colors.black87)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600], height: 1.3)),
      value: value,
      activeThumbColor: const Color(0xFF2D9CDB),
      onChanged: onChanged,
    );
  }
}