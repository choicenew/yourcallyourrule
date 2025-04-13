import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../services/contact_service.dart';

class ExportPage extends StatelessWidget {
  final ContactService contactService;

  const ExportPage({super.key, required this.contactService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).exportContacts),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(S.of(context).exportAsVcf),
            onTap: () => _exportContacts(context, 'vcf'),
          ),
          ListTile(
            title: Text(S.of(context).exportAsCsv),
            onTap: () => _exportContacts(context, 'csv'),
          ),
          ListTile(
            title: Text(S.of(context).exportAsJson),
            onTap: () => _exportContacts(context, 'json'),
          ),
          ListTile(
            title: Text(S.of(context).exportAsYaml),
            onTap: () => _exportContacts(context, 'yaml'),
          ),
        ],
      ),
    );
  }

  void _exportContacts(BuildContext context, String format) async {
    try {
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: S.of(context).pleaseSelectAnOutputFile,
        fileName: 'contacts.$format',
      );

      if (outputFile != null) {
        await contactService.exportContacts(format, outputFile);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).contactsExportedSuccessfully)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${S.of(context).errorExportingContacts} $e')),
      );
    }
  }
}
