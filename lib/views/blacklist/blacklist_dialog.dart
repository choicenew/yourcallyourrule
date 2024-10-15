import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/blacklist_whitelist_service.dart';
import '../subpage_style.dart';

class SelectBlacklistEntriesDialog extends StatefulWidget {
  final List<BlacklistEntry> entries;

  const SelectBlacklistEntriesDialog({super.key, required this.entries});

  @override
  SelectBlacklistEntriesDialogState createState() =>
      SelectBlacklistEntriesDialogState();
}

class SelectBlacklistEntriesDialogState
    extends State<SelectBlacklistEntriesDialog> {
  final Set<BlacklistEntry> _selectedEntries = <BlacklistEntry>{};
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
                      labelPadding: const EdgeInsets.only(left: 5.0),
                      tabs: [
                        Tab(text: Intl.message('All')),
                        Tab(text: Intl.message('Subscribed')),
                        Tab(text: Intl.message('Unsubscribed')),
                      ],
                      labelColor: Colors.blue,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildEntriesList(filteredEntries),
                          _buildSubscribed(filteredEntries),
                          _buildUnsubscribed(filteredEntries),
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

  Widget _buildEntriesList(List<BlacklistEntry> entries) {
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

  Widget _buildSubscribed(List<BlacklistEntry> entries) {
    final subscribedEntries = entries.where((entry) => entry.isSubscribed).toList();
    return SingleChildScrollView(
      child: Column(
        children: subscribedEntries.map((entry) {
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

  Widget _buildUnsubscribed(List<BlacklistEntry> entries) {
    final unsubscribedEntries = entries.where((entry) => !entry.isSubscribed).toList();
    return SingleChildScrollView(
      child: Column(
        children: unsubscribedEntries.map((entry) {
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
