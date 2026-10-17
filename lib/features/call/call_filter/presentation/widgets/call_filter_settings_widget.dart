import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/call/call_filter/config/call_filter_config.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class CallFilterSettingsWidget extends ConsumerWidget {
  const CallFilterSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(callFilterConfigProvider.select((v) => v.value));
    final theme = Theme.of(context);
    
    if (config == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    final notifier = ref.read(callFilterConfigProvider.notifier);
    
    void onConfigChanged(String key, bool value) {
      final updatedMap = config.toMap()..[key] = value;
      notifier.updateConfig(CallFilterConfig.fromMap(updatedMap));
    }

    return Column(
      children: [
          const GoogleAdWidget(adInfo: AdManager.bannerAd),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
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
                Divider(height: 1, indent: 16, endIndent: 16, color: theme.colorScheme.outlineVariant),
                _buildSwitchListTile(
                  context,
                  AppLocalizations.of(context)!.allowAllowedNumbers,
                  AppLocalizations.of(context)!.allowAllowedNumbersDesc,
                  config.allowAllAllowedNumbers,
                  (value) => onConfigChanged(CallFilterConfig.keyAllowAllAllowedNumbers, value),
                ),
                Divider(height: 1, indent: 16, endIndent: 16, color: theme.colorScheme.outlineVariant),
                _buildSwitchListTile(
                  context,
                  AppLocalizations.of(context)!.allowBlockedNumbers,
                  AppLocalizations.of(context)!.allowBlockedNumbersDesc,
                  config.allowBlockedNumbers,
                  (value) => onConfigChanged(CallFilterConfig.keyAllowBlockedNumbers, value),
                ),
                Divider(height: 1, indent: 16, endIndent: 16, color: theme.colorScheme.outlineVariant),
                _buildSwitchListTile(
                  context,
                  AppLocalizations.of(context)!.allowRegexAllowRules,
                  AppLocalizations.of(context)!.allowRegexAllowRulesDesc,
                  config.allowRegexAllowRules,
                  (value) => onConfigChanged(CallFilterConfig.keyAllowRegexAllowRules, value),
                ),
                Divider(height: 1, indent: 16, endIndent: 16, color: theme.colorScheme.outlineVariant),
                _buildSwitchListTile(
                  context,
                  AppLocalizations.of(context)!.allowAllAllowRules,
                  AppLocalizations.of(context)!.allowAllAllowRulesDesc,
                  config.allowAllAllowRules,
                  (value) => onConfigChanged(CallFilterConfig.keyAllowAllAllowRules, value),
                ),
                Divider(height: 1, indent: 16, endIndent: 16, color: theme.colorScheme.outlineVariant),
                _buildSwitchListTile(
                  context,
                  AppLocalizations.of(context)!.allowRegexBlockRules,
                  AppLocalizations.of(context)!.allowRegexBlockRulesDesc,
                  config.allowRegexBlockRules,
                  (value) => onConfigChanged(CallFilterConfig.keyAllowRegexBlockRules, value),
                ),
                Divider(height: 1, indent: 16, endIndent: 16, color: theme.colorScheme.outlineVariant),
                _buildSwitchListTile(
                  context,
                  AppLocalizations.of(context)!.enableMuteRules,
                  AppLocalizations.of(context)!.enableMuteRulesDesc,
                  config.allowSilenceRules,
                  (value) => onConfigChanged(CallFilterConfig.keyAllowSilenceRules, value),
                ),
                Divider(height: 1, indent: 16, endIndent: 16, color: theme.colorScheme.outlineVariant),
                _buildSwitchListTile(
                  context,
                  AppLocalizations.of(context)!.enableNoneActionRules,
                  AppLocalizations.of(context)!.enableNoneActionRulesDesc,
                  config.allowNoneRules,
                  (value) => onConfigChanged(CallFilterConfig.keyAllowNoneRules, value),
                ),
                Divider(height: 1, indent: 16, endIndent: 16, color: theme.colorScheme.outlineVariant),
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
                backgroundColor: theme.colorScheme.primary,
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
          const InlineAdaptiveBannerAdWidget(adInfo: AdManager.adaptiveBannerAd, width: 400),
        ],
      );
  }

  Widget _buildSwitchListTile(
      BuildContext context, String title, String subtitle, bool value, Function(bool) onChanged) {
    final theme = Theme.of(context);
    return SwitchListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: theme.colorScheme.onSurface)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant, height: 1.3)),
      value: value,
      activeThumbColor: theme.colorScheme.primary,
      onChanged: onChanged,
    );
  }
}
