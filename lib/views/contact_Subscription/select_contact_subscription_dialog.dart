import 'package:flutter/material.dart';

import '../../services/subscribe_contacts_service.dart';
//import '../../views/Custom_3Button_Style.dart';
import '../subpage_style.dart';
//import '../../new_set_icons.dart';

class SelectSubscriptionsDialog extends StatefulWidget {
  final List<ContactSubscriptionModel> subscriptions;

  const SelectSubscriptionsDialog({super.key, required this.subscriptions});

  @override
  SelectSubscriptionsDialogState createState() =>
      SelectSubscriptionsDialogState();
}

class SelectSubscriptionsDialogState extends State<SelectSubscriptionsDialog> {
  final Set<ContactSubscriptionModel> _selectedSubscriptions =
      <ContactSubscriptionModel>{};
  bool _isSelectAll = false;
  String _keyword = '';

  @override
  Widget build(BuildContext context) {
    final filteredSubscriptions = widget.subscriptions
        .where((subscription) =>
            subscription.name.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();

    return AlertDialog(
      title: Text('Select Subscriptions'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 搜索栏
            TextField(
              decoration: InputDecoration(
                labelText: 'Search subscriptions',
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
                Text('Select All', style: SubscriptionPageStyles.tabLabelStyle),
              ],
            ),
            ListBody(
              children: filteredSubscriptions
                  .map(
                    (subscription) => CheckboxListTile(
                      title: Text(subscription.name),
                      value: _isSelectAll ||
                          _selectedSubscriptions.contains(subscription),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null && value) {
                            _selectedSubscriptions.add(subscription);
                          } else {
                            _selectedSubscriptions.remove(subscription);
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
            Navigator.of(context).pop(_selectedSubscriptions.toList());
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
