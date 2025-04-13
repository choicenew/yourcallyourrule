import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../services/contact_service.dart';

class MergeContactsDialog extends StatefulWidget {
  final ContactService contactService;

  const MergeContactsDialog({super.key, required this.contactService});

  @override
  MergeContactsDialogState createState() => MergeContactsDialogState();
}

class MergeContactsDialogState extends State<MergeContactsDialog> {
  Map<String, List<Contact>> potentialDuplicates = {};
  Map<String, bool> selectedGroups = {};

  @override
  void initState() {
    super.initState();
    _loadPotentialDuplicates();
  }

  Future<void> _loadPotentialDuplicates() async {
    List<Contact> allContacts = await widget.contactService.getAllContacts();
    Map<String, List<Contact>> duplicates = {};

    for (var contact in allContacts) {
      for (var phoneNumber in contact.phoneNumbers) {
        if (!duplicates.containsKey(phoneNumber)) {
          duplicates[phoneNumber] = [];
        }
        duplicates[phoneNumber]!.add(contact);
      }
    }

    setState(() {
      potentialDuplicates = Map.fromEntries(
          duplicates.entries.where((entry) => entry.value.length > 1));
      selectedGroups =
          Map.fromIterable(potentialDuplicates.keys, value: (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).mergeContacts),
      content: SingleChildScrollView(
        child: Column(
          children: potentialDuplicates.entries.map((entry) {
            return CheckboxListTile(
              title: Text(
                  '${S.of(context).merge} ${entry.value.length} ${S.of(context).contactsWithNumber} ${entry.key}'),
              value: selectedGroups[entry.key],
              onChanged: (bool? value) {
                setState(() {
                  selectedGroups[entry.key] = value ?? false;
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(S.of(context).cancel),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text(S.of(context).mergeSelected),
          onPressed: () {
            _mergeSelectedContacts();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void _mergeSelectedContacts() async {
    for (var entry in potentialDuplicates.entries) {
      if (selectedGroups[entry.key] == true) {
        await widget.contactService.mergeContacts(entry.value);
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).selectedContactsMergedSuccessfully)),
    );
  }
}
