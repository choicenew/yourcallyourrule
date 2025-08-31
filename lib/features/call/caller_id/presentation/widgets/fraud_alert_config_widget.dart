import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/fraud_alert_config.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 诈骗提醒配置小部件
/// 允许用户配置诈骗提醒的启用状态和震动功能
class FraudAlertConfigWidget extends ConsumerStatefulWidget {
  const FraudAlertConfigWidget({super.key});

  @override
  ConsumerState<FraudAlertConfigWidget> createState() => _FraudAlertConfigWidgetState();
}

class _FraudAlertConfigWidgetState extends ConsumerState<FraudAlertConfigWidget> {
  late FraudAlertConfigService _configService;
  late FraudAlertConfig _config;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initConfig();
  }

  Future<void> _initConfig() async {
    _configService = ref.read(fraudAlertConfigProvider);
    _config = await _configService.getConfig();
    
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveConfig() async {
    await _configService.saveConfig(_config);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return  Column(
    children: [
    
    Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_amber_rounded, size: 20, color: Colors.amber),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.fraudAlerSettingTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.enableFraudAlert),
              subtitle: Text(AppLocalizations.of(context)!.enableFraudAlertDescription),
              value: _config.isEnabled,
              onChanged: (value) {
                setState(() {
                  _config.isEnabled = value;
                });
                _saveConfig();
              },
            ),
            const Divider(),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.enableVibration),
              subtitle: Text(AppLocalizations.of(context)!.enableVibrationDescription),
              value: _config.isVibrationEnabled,
              onChanged: (value) {
                setState(() {
                  _config.isVibrationEnabled = value;
                });
                _saveConfig();
              },
            ),
            
          ],
        ),
      ),
    ),
    const SizedBox(height: 16),
InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd,width: 400),
  ],
  );

  }
}

/// 诈骗提醒配置Provider
final fraudAlertConfigProvider = Provider<FraudAlertConfigService>((ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return FraudAlertConfigService(configRepository);
});