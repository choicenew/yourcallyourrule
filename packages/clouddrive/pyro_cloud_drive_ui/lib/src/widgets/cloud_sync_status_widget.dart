import 'package:material_ui/material_ui.dart';
import 'package:pyro_cloud_drive_ui/src/l10n/generated/app_localizations.dart';
import '../l10n/generated/app_localizations_en.dart';

class CloudSyncStatusWidget extends StatelessWidget {
  final String providerName;
  final IconData icon;
  final Color themeColor;
  final bool isConnected;
  final DateTime? lastSyncTime;
  final VoidCallback? onSyncPressed;
  final VoidCallback? onSettingsPressed;

  const CloudSyncStatusWidget({
    super.key,
    required this.providerName,
    this.icon = Icons.cloud,
    this.themeColor = Colors.blue,
    required this.isConnected,
    this.lastSyncTime,
    this.onSyncPressed,
    this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations) ?? AppLocalizationsEn();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: themeColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: themeColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(providerName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    isConnected
                        ? (lastSyncTime != null
                            ? l10n.lastSynced(lastSyncTime!.toLocal().toString().split(".")[0])
                            : l10n.connected)
                        : l10n.disconnected,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            if (onSyncPressed != null)
              IconButton(
                icon: const Icon(Icons.sync),
                onPressed: onSyncPressed,
                tooltip: l10n.syncNow,
              ),
            if (onSettingsPressed != null)
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: onSettingsPressed,
                tooltip: l10n.settings,
              ),
          ],
        ),
      ),
    );
  }
}


