import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:yourcallyourrule/features/phone_rules/services/import_export_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class ImportExportServiceComponent<T, ID> {
  final ImportExportService<T, ID> importExportService;
  final String entityTypeName;
  final Function(List<T>) onEntitiesImported;
  final Future<List<T>> Function() getEntitiesToExport;

  ImportExportServiceComponent({
    required this.importExportService,
    required this.entityTypeName,
    required this.onEntitiesImported,
    required this.getEntitiesToExport,
  });

  Future<void> importFromFile(BuildContext context) async {
    try {
      final result = await FilePicker.pickFiles(
        dialogTitle: AppLocalizations.of(context)!.importEntity(entityTypeName),
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      
      if (result != null && result.files.isNotEmpty && result.files.single.path != null) {
        final entities = await importExportService.importFromFile(result.files.single.path!);
        
        await onEntitiesImported(entities);
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.entityImportSuccess(entityTypeName, entities.length)),
            backgroundColor: Colors.green,
          ));
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.entityImportFailed(entityTypeName, e.toString())),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> exportToFile(BuildContext context) async {
    try {
      final entities = await getEntitiesToExport();
      final bytes = await importExportService.prepareExportBytes(entities);

      final result = await FilePicker.saveFile(
        dialogTitle: AppLocalizations.of(context)!.exportEntity(entityTypeName),
        fileName: '${entityTypeName.toLowerCase().replaceAll(' ', '_')}_export.json',
        bytes: bytes,
      );
      
      if (result != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.entityExportSuccess(entityTypeName)),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.entityExportFailed(entityTypeName, e.toString())),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Widget buildImportExportButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.file_upload),
          label: Text(AppLocalizations.of(context)!.import),
          onPressed: () => importFromFile(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.file_download),
          label: Text(AppLocalizations.of(context)!.export),
          onPressed: () => exportToFile(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
        ),
      ],
    );
  }
  
  void showImportExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.importExportTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)!.importExportDescription(entityTypeName)),
            const SizedBox(height: 16),
            buildImportExportButtons(context),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.closeButton),
          ),
        ],
      ),
    );
  }
}
