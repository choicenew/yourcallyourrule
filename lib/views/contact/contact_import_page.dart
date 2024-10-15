import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../services/contact_service.dart';

class ImportPage extends StatelessWidget {
  final ContactService contactService;

  const ImportPage({super.key, required this.contactService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).importContacts),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(S.of(context).importFromVcf),
            onTap: () => _importContacts(context, ['vcf']),
          ),
          ListTile(
            title: Text(S.of(context).importFromCsv),
            onTap: () => _importContacts(context, ['csv']),
          ),
          ListTile(
            title: Text(S.of(context).importFromJson),
            onTap: () => _importContacts(context, ['json']),
          ),
          ListTile(
            title: Text(S.of(context).importFromYaml),
            onTap: () => _importContacts(context, ['yaml']),
          ),
          ListTile(
            title: Text(S.of(context).importFromUrl),
            onTap: () => _showUrlImportDialog(context),
          ),
        ],
      ),
    );
  }

  void _importContacts(
      BuildContext context, List<String> allowedExtensions) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        await contactService.importContactsFromLocalFile(file);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).contactsImportedSuccessfully)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${S.of(context).errorImporting}: $e')),
      );
    }
  }

  void _showUrlImportDialog(BuildContext context) {
    String url = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).importFromUrl),
          content: TextField(
            onChanged: (value) {
              url = value;
            },
            decoration: InputDecoration(hintText: S.of(context).enterUrl),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(S.of(context).import),
              onPressed: () {
                _importFromUrl(context, url);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _importFromUrl(BuildContext context, String url) async {
    try {
      await contactService.importContactsFromUrl(url);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).importedSuccessfullyFromUrl)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${S.of(context).errorImporting}: $e')),
      );
    }
  }
}
