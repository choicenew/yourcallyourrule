import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/fraud_alert_config_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 诈骗提醒配置小部件
class FraudAlertConfigWidget extends ConsumerWidget {
  const FraudAlertConfigWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncConfig = ref.watch(fraudAlertConfigProvider);
    final notifier = ref.read(fraudAlertConfigProvider.notifier);
    final theme = Theme.of(context);

    return asyncConfig.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading config: $err')),
      data: (config) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              padding: const EdgeInsets.all(16),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.warning_amber_rounded, size: 20, color: theme.colorScheme.primary),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context)!.fraudAlerSettingTitle,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.enableFraudAlert, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: theme.colorScheme.onSurface)),
                    subtitle: Text(AppLocalizations.of(context)!.enableFraudAlertDescription, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant, height: 1.3)),
                    value: config.isEnabled,
                    activeThumbColor: theme.colorScheme.primary,
                    onChanged: (value) {
                      notifier.updateConfig(config.copyWith(isEnabled: value));
                    },
                  ),
                  Divider(height: 1, indent: 16, endIndent: 16, color: theme.colorScheme.outlineVariant),
                  SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.enableVibration, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: theme.colorScheme.onSurface)),
                    subtitle: Text(AppLocalizations.of(context)!.enableVibrationDescription, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant, height: 1.3)),
                    value: config.isVibrationEnabled,
                    activeThumbColor: theme.colorScheme.primary,
                    onChanged: (value) {
                      notifier.updateConfig(config.copyWith(isVibrationEnabled: value));
                    },
                  ),
                  Divider(height: 1, indent: 16, endIndent: 16, color: theme.colorScheme.outlineVariant),
                  SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.autoCancelNotification, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: theme.colorScheme.onSurface)),
                    subtitle: Text(AppLocalizations.of(context)!.autoCancelNotificationDescription, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant, height: 1.3)),
                    value: config.isAutoCancelEnabled,
                    activeThumbColor: theme.colorScheme.primary,
                    onChanged: (value) {
                      notifier.updateConfig(config.copyWith(isAutoCancelEnabled: value));
                    },
                  ),
                  if (config.isAutoCancelEnabled) ...[
                    Divider(height: 1, indent: 16, endIndent: 16, color: theme.colorScheme.outlineVariant),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        children: [
                          Text(AppLocalizations.of(context)!.setDelayTime, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: theme.colorScheme.onSurface)),
                          Expanded(
                            child: Slider(
                              value: config.autoCancelDelaySeconds.toDouble(),
                              min: 3,
                              max: 30,
                              divisions: 9,
                              label: '${config.autoCancelDelaySeconds}s',
                              activeColor: theme.colorScheme.primary,
                              onChanged: (value) {},
                              onChangeEnd: (value) {
                                notifier.updateConfig(config.copyWith(autoCancelDelaySeconds: value.toInt()));
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text('${config.autoCancelDelaySeconds}s', style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w800, fontSize: 12)),
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
