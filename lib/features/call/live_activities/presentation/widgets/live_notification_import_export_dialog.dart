import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

Future<String?> showLiveNotificationImportExportDialog(BuildContext context) async {
  final result = await showDialog<String?>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.configManagement),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.upload_file),
            title: Text(AppLocalizations.of(context)!.importConfig),
            onTap: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['json'],
              );
              Navigator.pop(context, result?.files.single.path);
            },
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: Text(AppLocalizations.of(context)!.exportConfig),
            onTap: () async {
              final directory = await getDownloadsDirectory();
              final path = '${directory?.path}/live_notification_config.json';
              Navigator.pop(context, path);
            },
          )
        ],
      ),
    ),
  );
  return result;
}
