import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/subscription_service.dart';
import '../subpage_style.dart';

class SelectSubscriptionsDialog extends StatefulWidget {
  final List<SubscriptionModel> subscriptions;

  const SelectSubscriptionsDialog({super.key, required this.subscriptions});

  @override
  SelectSubscriptionsDialogState createState() =>
      SelectSubscriptionsDialogState();
}

class SelectSubscriptionsDialogState extends State<SelectSubscriptionsDialog> {
  final Set<SubscriptionModel> _selectedSubscriptions = <SubscriptionModel>{};
  bool _isSelectAll = false;
  String _keyword = '';

  @override
  Widget build(BuildContext context) {
    final filteredSubscriptions = widget.subscriptions
        .where((subscription) =>
            subscription.name.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();

    return AlertDialog(
      title: Text(Intl.message('Select Subscriptions')),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: Intl.message('Search Subscriptions'),
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
                      for (var subscription in filteredSubscriptions) {
                        if (_selectedSubscriptions.contains(subscription)) {
                          _selectedSubscriptions.remove(subscription);
                        } else {
                          _selectedSubscriptions.add(subscription);
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
                        Tab(text: Intl.message('Whitelist')),
                        Tab(text: Intl.message('Blacklist')),
                      ],
                      labelColor: Colors.blue,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildEntriesList(filteredSubscriptions),
                          _buildWhitelist(filteredSubscriptions),
                          _buildBlacklist(filteredSubscriptions),
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
            Navigator.of(context).pop(_selectedSubscriptions.toList());
          },
         child: Text(Intl.message('OK')),
        ),
      ],
    );
  }

  Widget _buildEntriesList(List<SubscriptionModel> subscriptions) {
    return SingleChildScrollView(
      child: Column(
        children: subscriptions.map((subscription) {
          return CheckboxListTile(
            title: Text(subscription.name),
            value: _isSelectAll || _selectedSubscriptions.contains(subscription),
            onChanged: (bool? value) {
              setState(() {
                if (value != null && value) {
                  _selectedSubscriptions.add(subscription);
                } else {
                  _selectedSubscriptions.remove(subscription);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildWhitelist(List<SubscriptionModel> subscriptions) {
    final whitelistSubscriptions = subscriptions.where((subscription) => subscription.isWhitelist).toList();
    return SingleChildScrollView(
      child: Column(
        children: whitelistSubscriptions.map((subscription) {
          return CheckboxListTile(
            title: Text(subscription.name),
            value: _isSelectAll || _selectedSubscriptions.contains(subscription),
            onChanged: (bool? value) {
              setState(() {
                if (value != null && value) {
                  _selectedSubscriptions.add(subscription);
                } else {
                  _selectedSubscriptions.remove(subscription);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBlacklist(List<SubscriptionModel> subscriptions) {
    final blacklistSubscriptions = subscriptions.where((subscription) => subscription.isBlacklist).toList();
    return SingleChildScrollView(
      child: Column(
        children: blacklistSubscriptions.map((subscription) {
          return CheckboxListTile(
            title: Text(subscription.name),
            value: _isSelectAll || _selectedSubscriptions.contains(subscription),
            onChanged: (bool? value) {
              setState(() {
                if (value != null && value) {
                  _selectedSubscriptions.add(subscription);
                } else {
                  _selectedSubscriptions.remove(subscription);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
