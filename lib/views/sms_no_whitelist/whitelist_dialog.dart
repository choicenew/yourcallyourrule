import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/sms_blacklist_whitelist_service.dart';
import '../subpage_style.dart';

class SelectSmsWhitelistEntriesDialog extends StatefulWidget {
  final List<SmsWhitelistEntry> entries;

  const SelectSmsWhitelistEntriesDialog({super.key, required this.entries});

  @override
  SelectSmsWhitelistEntriesDialogState createState() =>
      SelectSmsWhitelistEntriesDialogState();
}

class SelectSmsWhitelistEntriesDialogState
    extends State<SelectSmsWhitelistEntriesDialog> {
  final Set<SmsWhitelistEntry> _selectedEntries = <SmsWhitelistEntry>{};
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
            TextField(
              decoration: InputDecoration(
                labelText: 'Search Entries',
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
            SizedBox(height: 16.0),
            // 添加选项卡和选项卡视图
            DefaultTabController(
              length: 3, // 三个选项卡
              child: Column(
                children: <Widget>[
                  TabBar(
                    tabs: [
                      Tab(text: Intl.message('All')),
                      Tab(text: Intl.message('Subscribed')),
                      Tab(text: Intl.message('Unsubscribed')),
                    ],
                    labelColor: Colors.blue, // 选中标签文本的颜色
                  ),
                  SizedBox(
                    height: 200.0, // 选项卡视图的高度
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

  Widget _buildEntriesList(List<SmsWhitelistEntry> entries) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
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
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  Widget _buildSubscribed(List<SmsWhitelistEntry> entries) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        // 根据条件过滤号码
        if (entry.isSubscribed) {
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
        } else {
          return Container(); // 不返回任何内容
        }
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  Widget _buildUnsubscribed(List<SmsWhitelistEntry> entries) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        // 根据条件过滤号码
        if (!entry.isSubscribed) {
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
        } else {
          return Container(); // 不返回任何内容
        }
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
