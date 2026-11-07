import 'package:material_ui/material_ui.dart';
import 'package:pyro_sync_hub/pyro_sync_hub.dart';
import '../l10n/generated/app_localizations.dart';
import '../widgets/sync_status_widget.dart';

/// 零硬编码文本、多态自适应渲染的同步设置主页面 (100% AppLocalizations L10n Driven)
class SyncSettingsPage extends StatelessWidget {
  final String title;
  final String statusText;
  final bool isSyncing;
  final VoidCallback onSyncNow;

  const SyncSettingsPage({
    super.key,
    required this.title,
    required this.statusText,
    required this.isSyncing,
    required this.onSyncNow,
  });

  @override
  Widget build(BuildContext context) {
    final providers = SyncHub.instance.registeredProviders;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SyncStatusWidget(
            isSyncing: isSyncing,
            statusText: statusText,
            onSyncNow: onSyncNow,
          ),
          const SizedBox(height: 16),
          if (providers.isNotEmpty) ...[
            Text(
              l10n.mountedProvidersSectionTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            ...providers.map((entity) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: Icon(entity.icon, color: entity.themeColor),
                  // 🌟 100% 动态构建多语言标题 (0 硬编码，跨 Package 类型安全)
                  title: Text(entity.titleBuilder(context)),
                  trailing: OutlinedButton(
                    onPressed: () async {
                      final ok = await entity.testConnection();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(ok ? l10n.connectionSuccess : l10n.connectionFailed),
                          ),
                        );
                      }
                    },
                    child: Text(l10n.testConnectivity),
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}
