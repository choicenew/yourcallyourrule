import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yourcallyourrule/features/contacts/provider/contact_service_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';


/// 联系人导入与导出对话框组件
class ContactImportExportDialog extends ConsumerWidget {
  final Future<void> Function() onImportSuccess;

  const ContactImportExportDialog({
    super.key,
    required this.onImportSuccess,
  });

  static Future<void> show(BuildContext context, {required Future<void> Function() onImportSuccess}) {
    return showDialog(
      context: context,
      builder: (context) => ContactImportExportDialog(onImportSuccess: onImportSuccess),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.importExportContacts),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.file_upload),
            title: Text(AppLocalizations.of(context)!.importContacts),
            onTap: () async {
              Navigator.pop(context);
              try {
                final result = await FilePicker.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['vcf', 'csv', 'yaml', 'json'],
                );
                if (result != null) {
                  final file = File(result.files.single.path!);
                  final content = await file.readAsString();
                  final extension = result.files.single.extension?.toLowerCase();
                  final contactService = ref.read(contactServiceProvider);
                  final directory = await getExternalStorageDirectory();
                  switch (extension) {
                    case 'vcf':
                      await contactService.importContactsFromVcf(content, directory!);
                      break;
                    case 'csv':
                      await contactService.importContactsFromCsv(content);
                      break;
                    case 'yaml':
                      await contactService.importContactsFromYaml(content);
                      break;
                    case 'json':
                      final jsonData = jsonDecode(content) as List<dynamic>;
                      await contactService.importContactsFromJson(jsonData);
                      break;
                    default:
                      throw Exception(AppLocalizations.of(context)!.unsupportedFileFormat);
                  }
                  await onImportSuccess();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context)!.importSuccess), backgroundColor: Colors.green),
                    );
                  }
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${AppLocalizations.of(context)!.importFailed}: $e'), backgroundColor: Colors.red),
                  );
                }
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_download),
            title: Text(AppLocalizations.of(context)!.exportContacts),
            onTap: () async {
              Navigator.pop(context);
              try {
                final contactService = ref.read(contactServiceProvider);
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (dialogCtx) => AlertDialog(
                      title: Text(AppLocalizations.of(dialogCtx)!.selectExportFormat),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.description),
                            title: Text(AppLocalizations.of(dialogCtx)!.csvFormat),
                            onTap: () async {
                              Navigator.pop(dialogCtx);
                              final csvContent = await contactService.exportContactsToCsv();
                              final directory = await getExternalStorageDirectory();
                              final file = File('${directory!.path}/contacts.csv');
                              await file.writeAsString(csvContent);

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${AppLocalizations.of(context)!.fileSavedTo}: ${file.path}'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.code),
                            title: Text(AppLocalizations.of(dialogCtx)!.jsonFormat),
                            onTap: () async {
                              Navigator.pop(dialogCtx);
                              final jsonContent = await contactService.exportContactsToJson();
                              final directory = await getExternalStorageDirectory();
                              final file = File('${directory!.path}/contacts.json');
                              await file.writeAsString(jsonContent);

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${AppLocalizations.of(context)!.fileSavedTo}: ${file.path}'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${AppLocalizations.of(context)!.exportFailed}: $e'), backgroundColor: Colors.red),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
