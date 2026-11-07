import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_cloud_drive_protocol/pyro_cloud_drive_protocol.dart';
import '../state/cloud_drive_state.dart';
import '../widgets/cloud_sync_status_widget.dart';
import '../widgets/encryption_password_dialog.dart';

import 'package:pyro_cloud_drive_ui/src/l10n/generated/app_localizations.dart';
import '../l10n/generated/app_localizations_en.dart';

class CloudSettingsPage extends ConsumerWidget {
  const CloudSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations) ?? AppLocalizationsEn();
    final hub = ref.watch(cloudDriveHubProvider);
    final providers = ref.watch(availableCloudProvidersProvider);
    final isEncryptedAsync = ref.watch(encryptionEnabledProvider);
    final cryptoStorage = ref.watch(cloudDriveCryptoStorageProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.cloudSettingsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          // Security Section
          ListTile(
            leading: const Icon(Icons.security, color: Colors.blue),
            title: Text(l10n.encryptionTitle),
            subtitle: Text(isEncryptedAsync.value == true ? l10n.encryptionEnabled : l10n.encryptionDisabled),
            trailing: Switch(
              value: isEncryptedAsync.value ?? false,
              onChanged: (val) async {
                if (val) {
                  await showDialog(
                    context: context,
                    builder: (_) => EncryptionPasswordDialog(storage: cryptoStorage),
                  );
                } else {
                  await cryptoStorage.setEncryptionEnabled(false);
                }
                ref.invalidate(encryptionEnabledProvider);
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(l10n.configuredDrives, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          if (providers.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(child: Text(l10n.noDrivesRegistered)),
            )
          else
            ...providers.map((pToken) {
              final uiConfig = hub.getUIConfig(pToken);
              final isConnectedAsync = ref.watch(providerConnectionStateProvider(pToken));
              final displayName = uiConfig?.getTitle(context) ?? pToken.toString();
              return CloudSyncStatusWidget(
                providerName: displayName,
                icon: uiConfig?.icon ?? Icons.cloud,
                themeColor: uiConfig?.themeColor ?? Colors.blue,
                isConnected: isConnectedAsync.value ?? false,
                onSyncPressed: () {},
                onSettingsPressed: () {
                  if (uiConfig != null && uiConfig.fields.isNotEmpty) {
                    _showDriveConfigDialog(context, ref, uiConfig, l10n);
                  }
                },
              );
            }),
        ],
      ),
    );
  }

  void _showDriveConfigDialog(BuildContext context, WidgetRef ref, CloudServiceUIConfig uiConfig, AppLocalizations l10n) {
    final values = <String, dynamic>{};
    for (final f in uiConfig.fields) {
      if (f.defaultValue != null) {
        values[f.key] = f.defaultValue!;
      }
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(uiConfig.icon, color: uiConfig.themeColor),
            const SizedBox(width: 8),
            Text(uiConfig.getTitle(context)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: uiConfig.fields.map((f) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: TextField(
                  obscureText: f.type == CloudConfigFieldType.password,
                  decoration: InputDecoration(
                    labelText: f.label,
                    hintText: f.hint,
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (val) {
                    values[f.key] = val;
                  },
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.cancel)),
          FilledButton(
            onPressed: () async {
              final hub = ref.read(cloudDriveHubProvider);
              final driver = hub.getDriver(uiConfig.driverToken);
              if (driver != null) {
                try {
                  final success = await driver.connect(values);
                  if (success) {
                    hub.setActiveProvider(uiConfig.driverToken);
                  }
                } catch (e) {
                  debugPrint('Failed to connect to ${uiConfig.driverToken}: $e');
                }
                ref.invalidate(providerConnectionStateProvider(uiConfig.driverToken));
              }
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }
}
