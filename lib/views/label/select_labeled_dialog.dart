import 'package:flutter/material.dart';

import '../../services/label_service.dart';
import '../subpage_style.dart';

class SelectLabeledEntriesDialog extends StatefulWidget {
  final List<LabeledEntry> entries;

  const SelectLabeledEntriesDialog({super.key, required this.entries});

  @override
  SelectLabeledEntriesDialogState createState() =>
      SelectLabeledEntriesDialogState();
}

class SelectLabeledEntriesDialogState
    extends State<SelectLabeledEntriesDialog> {
  final Set<LabeledEntry> _selectedEntries = <LabeledEntry>{};
  bool _isSelectAll = false;

  String _keyword = '';

  @override
  Widget build(BuildContext context) {
    final filteredEntries = widget.entries
        .where((entry) =>
            entry.phoneNumber.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();

    return AlertDialog(
      title: Text('Select Entries'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 搜索栏
            TextField(
              decoration: InputDecoration(
                labelText: 'Search entries',
                labelStyle: inputTextStyle,
                suffixIcon: _keyword.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _keyword = '';
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (keyword) {
                setState(() {
                  _keyword = keyword;
                });
              },
            ),
            SizedBox(height: 16.0),
            // Select all checkbox
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Checkbox(
                  value: _isSelectAll,
                  onChanged: (value) {
                    setState(() {
                      _isSelectAll = value!;
                      for (var entry in filteredEntries) {
                        if (_selectedEntries.contains(entry)) {
                          _selectedEntries.remove(entry);
                        } else {
                          _selectedEntries.add(entry);
                        }
                      }
                    });
                  },
                ),
                Text('Select All', style: SubscriptionPageStyles.tabLabelStyle),
              ],
            ),

            ListBody(
              children: filteredEntries
                  .map(
                    (entry) => CheckboxListTile(
                      title: Text(entry.phoneNumber),
                      value: _isSelectAll || _selectedEntries.contains(entry),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null && value) {
                            _selectedEntries.add(entry);
                          } else {
                            _selectedEntries.remove(entry);
                          }
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedEntries.toList());
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
