import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/allowed_blocked_service.dart';
import '../subpage_style.dart';


class SelectBlockedEntriesDialog extends StatefulWidget {
  final List<BlockedEntry> entries;

  const SelectBlockedEntriesDialog({super.key, required this.entries});

  @override
  SelectBlacklistEntriesDialogState createState() =>
      SelectBlacklistEntriesDialogState();
}

class SelectBlacklistEntriesDialogState
    extends State<SelectBlockedEntriesDialog> {
  final Set<BlockedEntry> _selectedEntries = <BlockedEntry>{};
  bool _isSelectAll = false;
  String _keyword = '';

  @override
  Widget build(BuildContext context) {
    final filteredEntries = widget.entries
        .where((entry) =>
            entry.phoneNumber.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();

    return AlertDialog(
      title: Text(Intl.message('Select Entries')),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: Intl.message('Search Entries'),
                labelStyle: inputTextStyle,
                suffixIcon: _keyword.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
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
            const SizedBox(height: 16.0),
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
                Text(Intl.message('Select All'), style: SubscriptionPageStyles.tabLabelStyle),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: <Widget>[
                    TabBar(
                      tabs: [
                        Tab(text: Intl.message('All')),

                      ],
                      labelColor: Colors.blue,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildEntriesList(filteredEntries),
                   
         
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(Intl.message('Cancel')),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedEntries.toList());
          },
         child: Text(Intl.message('OK')),
        ),
      ],
    );
  }

  Widget _buildEntriesList(List<BlockedEntry> entries) {
    return SingleChildScrollView(
      child: Column(
        children: entries.map((entry) {
          return CheckboxListTile(
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
          );
        }).toList(),
      ),
    );
  }




}

