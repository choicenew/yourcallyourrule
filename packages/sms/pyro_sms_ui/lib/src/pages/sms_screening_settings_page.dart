import 'package:flutter/material.dart';
import '../l10n/sms_localizations.dart';
import 'protected_apps_selector_sheet.dart';
import 'sms_evidence_log_sheet.dart';

/// Full settings page for configuring SMS protection options
class SmsScreeningSettingsPage extends StatefulWidget {
  const SmsScreeningSettingsPage({super.key});

  @override
  State<SmsScreeningSettingsPage> createState() => _SmsScreeningSettingsPageState();
}

class _SmsScreeningSettingsPageState extends State<SmsScreeningSettingsPage> {
  bool _notificationListenerEnabled = true;
  bool _googleSafeBrowsingEnabled = true;
  bool _openPhishEnabled = true;
  bool _virusTotalEnabled = true;
  bool _otpGuardEnabled = true;
  bool _bloomFilterEnabled = true;
  bool _botAutomationEnabled = true;
  bool _telephonyFallbackEnabled = false;
  bool _mlScorerEnabled = true;
  bool _burstProtectionEnabled = true;

  @override
  Widget build(BuildContext context) {
    final l10n = SmsLocalizations.of(context);
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
                  value: _notificationListenerEnabled,
                  onChanged: (val) => setState(() => _notificationListenerEnabled = val),
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
                  value: _telephonyFallbackEnabled,
                  onChanged: (val) => setState(() => _telephonyFallbackEnabled = val),
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
                  value: _googleSafeBrowsingEnabled,
                  onChanged: (val) => setState(() => _googleSafeBrowsingEnabled = val),
                ),
                SwitchListTile(
                  title: Text(l10n.phishTankOpenPhishTitle),
                  subtitle: Text(l10n.phishTankOpenPhishSubtitle),
                  value: _openPhishEnabled,
                  onChanged: (val) => setState(() => _openPhishEnabled = val),
                ),
                SwitchListTile(
                  title: Text(l10n.virusTotalTitle),
                  subtitle: Text(l10n.virusTotalSubtitle),
                  value: _virusTotalEnabled,
                  onChanged: (val) => setState(() => _virusTotalEnabled = val),
                ),
                SwitchListTile(
                  title: Text(l10n.otpGuardTitle),
                  subtitle: Text(l10n.otpGuardSubtitle),
                  value: _otpGuardEnabled,
                  onChanged: (val) => setState(() => _otpGuardEnabled = val),
                ),
                SwitchListTile(
                  title: Text(l10n.bloomFilterTitle),
                  subtitle: Text(l10n.bloomFilterSubtitle),
                  value: _bloomFilterEnabled,
                  onChanged: (val) => setState(() => _bloomFilterEnabled = val),
                ),
                SwitchListTile(
                  title: Text(l10n.botAutomationTitle),
                  subtitle: Text(l10n.botAutomationSubtitle),
                  value: _botAutomationEnabled,
                  onChanged: (val) => setState(() => _botAutomationEnabled = val),
                ),
                SwitchListTile(
                  title: Text(l10n.mlSpamScorerTitle),
                  subtitle: Text(l10n.mlSpamScorerSubtitle),
                  value: _mlScorerEnabled,
                  onChanged: (val) => setState(() => _mlScorerEnabled = val),
                ),
                SwitchListTile(
                  title: Text(l10n.smsBurstProtectionTitle),
                  subtitle: Text(l10n.smsBurstProtectionSubtitle),
                  value: _burstProtectionEnabled,
                  onChanged: (val) => setState(() => _burstProtectionEnabled = val),
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
