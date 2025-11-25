import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/call/live_activities/presentation/widgets/live_notification_import_export_dialog.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class LiveNotificationConfigImportExportButton extends StatelessWidget {
  final Future<void> Function(String) onImport;
  final Future<void> Function(String) onExport;

  const LiveNotificationConfigImportExportButton({
    super.key,
    required this.onImport,
    required this.onExport,
  });

  Future<void> _handleOperation(BuildContext context, String? path) async {
    if (path == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.processingOperation),
          ],
        ),
      ),
    );

    try {
      if (path.contains('import')) {
        await onImport(path);
      } else {
        await onExport(path);
      }
      Navigator.pop(context);
      _showResultDialog(context, success: true);
    } catch (e) {
      Navigator.pop(context);
      _showResultDialog(context, success: false);
    }
  }

  void _showResultDialog(BuildContext context, {required bool success}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(success ? AppLocalizations.of(context)!.operationSuccess : AppLocalizations.of(context)!.operationFailure),
        content: Text(success ? AppLocalizations.of(context)!.configUpdated : AppLocalizations.of(context)!.checkFileFormat),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.confirmButton),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings_backup_restore),
      onPressed: () async {
        final path = await showLiveNotificationImportExportDialog(context);
        if (path != null) {
          await _handleOperation(context, path);
        }
      },
    );
  }
}
