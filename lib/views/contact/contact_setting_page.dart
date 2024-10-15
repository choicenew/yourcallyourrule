import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../../services/contact_service.dart';
import 'contact_export_page.dart';
import 'contact_import_page.dart';
import 'contact_merge_page.dart';

class SettingsPage extends StatefulWidget {
  final ContactService contactService;

  const SettingsPage({super.key, required this.contactService});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  bool _showWhatsApp = true;
  bool _showTelegram = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

    _showWhatsApp = await asyncPrefs.getBool('show_whatsapp') ?? true;
    _showTelegram = await asyncPrefs.getBool('show_telegram') ?? true;
    setState(() {});
  }

  Future<void> _saveSettings() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool('show_whatsapp', _showWhatsApp);
    await asyncPrefs.setBool('show_telegram', _showTelegram);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(S.of(context).showWhatsapp),
            value: _showWhatsApp,
            onChanged: (bool value) {
              setState(() {
                _showWhatsApp = value;
                _saveSettings();
              });
            },
          ),
          SwitchListTile(
            title: Text(S.of(context).showTelegram),
            value: _showTelegram,
            onChanged: (bool value) {
              setState(() {
                _showTelegram = value;
                _saveSettings();
              });
            },
          ),
          ListTile(
            title: Text(S.of(context).exportContacts),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ExportPage(contactService: widget.contactService),
                ),
              );
            },
          ),
          ListTile(
            title: Text(S.of(context).importContacts),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ImportPage(contactService: widget.contactService),
                ),
              );
            },
          ),
          ListTile(
            title: Text(S.of(context).mergeContacts),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _showMergeContactsDialog();
            },
          ),
        ],
      ),
    );
  }

  void _showMergeContactsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MergeContactsDialog(contactService: widget.contactService);
      },
    );
  }
}
