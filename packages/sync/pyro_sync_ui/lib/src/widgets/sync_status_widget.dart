import 'package:material_ui/material_ui.dart';

/// Status indicator widget displaying real-time sync state.
class SyncStatusWidget extends StatelessWidget {
  final bool isSyncing;
  final String statusText;
  final VoidCallback? onSyncNow;

  const SyncStatusWidget({
    super.key,
    required this.isSyncing,
    required this.statusText,
    this.onSyncNow,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(
          isSyncing ? Icons.sync : Icons.cloud_done,
          color: isSyncing ? theme.colorScheme.primary : Colors.green,
        ),
        title: Text(statusText, style: theme.textTheme.bodyMedium),
        trailing: onSyncNow != null
            ? IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: onSyncNow,
              )
            : null,
      ),
    );
  }
}
