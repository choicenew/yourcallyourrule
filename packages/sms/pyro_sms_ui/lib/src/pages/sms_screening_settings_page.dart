import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/sms_localizations.dart';
import '../providers/sms_settings_provider.dart';
import 'protected_apps_selector_sheet.dart';
import 'sms_evidence_log_sheet.dart';

/// Riverpod 3.0 ConsumerStatefulWidget for configuring SMS protection options
class SmsScreeningSettingsPage extends ConsumerStatefulWidget {
  const SmsScreeningSettingsPage({super.key});

  @override
  ConsumerState<SmsScreeningSettingsPage> createState() => _SmsScreeningSettingsPageState();
}

class _SmsScreeningSettingsPageState extends ConsumerState<SmsScreeningSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = SmsLocalizations.of(context);
    final settings = ref.watch(smsSettingsProvider);
    final notifier = ref.read(smsSettingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.smsProtectionSettingsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(l10n.permissionFreeScreeningTitle),
                  subtitle: Text(l10n.permissionFreeScreeningSubtitle),
                  value: settings.notificationListenerEnabled,
                  onChanged: notifier.toggleNotificationListener,
                ),
                ListTile(
                  title: Text(l10n.protectedMessagingAppsTitle),
                  subtitle: Text(l10n.protectedMessagingAppsSubtitle),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => ProtectedAppsSelectorSheet.show(context),
                ),
                SwitchListTile(
                  title: Text(l10n.telephonyFallbackTitle),
                  subtitle: Text(l10n.telephonyFallbackSubtitle),
                  value: settings.telephonyFallbackEnabled,
                  onChanged: notifier.toggleTelephonyFallback,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(l10n.googleSafeBrowsingTitle),
                  subtitle: Text(l10n.googleSafeBrowsingSubtitle),
                  value: settings.googleSafeBrowsingEnabled,
                  onChanged: notifier.toggleGoogleSafeBrowsing,
                ),
                SwitchListTile(
                  title: Text(l10n.phishTankOpenPhishTitle),
                  subtitle: Text(l10n.phishTankOpenPhishSubtitle),
                  value: settings.openPhishEnabled,
                  onChanged: notifier.toggleOpenPhish,
                ),
                SwitchListTile(
                  title: Text(l10n.virusTotalTitle),
                  subtitle: Text(l10n.virusTotalSubtitle),
                  value: settings.virusTotalEnabled,
                  onChanged: notifier.toggleVirusTotal,
                ),
                SwitchListTile(
                  title: Text(l10n.otpGuardTitle),
                  subtitle: Text(l10n.otpGuardSubtitle),
                  value: settings.otpGuardEnabled,
                  onChanged: notifier.toggleOtpGuard,
                ),
                SwitchListTile(
                  title: Text(l10n.bloomFilterTitle),
                  subtitle: Text(l10n.bloomFilterSubtitle),
                  value: settings.bloomFilterEnabled,
                  onChanged: notifier.toggleBloomFilter,
                ),
                SwitchListTile(
                  title: Text(l10n.botAutomationTitle),
                  subtitle: Text(l10n.botAutomationSubtitle),
                  value: settings.botAutomationEnabled,
                  onChanged: notifier.toggleBotAutomation,
                ),
                SwitchListTile(
                  title: Text(l10n.mlSpamScorerTitle),
                  subtitle: Text(l10n.mlSpamScorerSubtitle),
                  value: settings.mlScorerEnabled,
                  onChanged: notifier.toggleMlScorer,
                ),
                SwitchListTile(
                  title: Text(l10n.smsBurstProtectionTitle),
                  subtitle: Text(l10n.smsBurstProtectionSubtitle),
                  value: settings.burstProtectionEnabled,
                  onChanged: notifier.toggleBurstProtection,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: Text(l10n.viewEvidenceLogsTitle),
            leading: const Icon(Icons.assignment),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => SmsEvidenceLogSheet.show(context),
          ),
        ],
      ),
    );
  }
}
