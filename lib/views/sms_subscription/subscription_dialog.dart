import 'package:flutter/material.dart';

import '../../services/sms_subscribe_service.dart';
import '../subpage_style.dart';

class SelectSubscriptionsDialog extends StatefulWidget {
  final List<SmsSubscriptionModel> subscriptions;

  const SelectSubscriptionsDialog({super.key, required this.subscriptions});

  @override
  SelectSubscriptionsDialogState createState() =>
      SelectSubscriptionsDialogState();
}

class SelectSubscriptionsDialogState extends State<SelectSubscriptionsDialog> {
  late List<SmsSubscriptionModel> _subscriptions;
  final Set<SmsSubscriptionModel> _selectedSubscriptions =
      <SmsSubscriptionModel>{};
  bool _isSelectAll = false;
  String _keyword = '';

  @override
  void initState() {
    super.initState();
    _subscriptions = widget.subscriptions;
  }

  @override
  Widget build(BuildContext context) {
    final filteredSubscriptions = _subscriptions
        .where((subscription) =>
            subscription.name.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();

    return AlertDialog(
      title: Text('Select Subscriptions'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
            SizedBox(height: 16.0),
            // 添加选项卡和选项卡视图
            DefaultTabController(
              length: 3, // 三个选项卡
              child: Column(
                children: <Widget>[
                  TabBar(
                    tabs: [
                      Tab(text: 'All'),
                      Tab(text: 'Whitelist'),
                      Tab(text: 'Blacklist'),
                    ],
                    labelColor: Colors.blue, // 选中标签文本的颜色
                  ),
                  SizedBox(
                    height: 200.0, // 选项卡视图的高度
                    child: TabBarView(
                      children: [
                        _buildSubscriptionsList(filteredSubscriptions),
                        _buildWhitelist(filteredSubscriptions),
                        _buildBlacklist(filteredSubscriptions),
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
            Navigator.of(context).pop(_selectedSubscriptions.toList());
          },
          child: Text('OK'),
        ),
      ],
    );
  }

  Widget _buildSubscriptionsList(List<SmsSubscriptionModel> subscriptions) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: subscriptions.length,
      itemBuilder: (context, index) {
        final subscription = subscriptions[index];
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
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  Widget _buildWhitelist(List<SmsSubscriptionModel> subscriptions) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: subscriptions.length,
      itemBuilder: (context, index) {
        final subscription = subscriptions[index];
        // 根据条件过滤白名单
        if (subscription.isWhitelist) {
          return CheckboxListTile(
            title: Text(subscription.name),
            value:
                _isSelectAll || _selectedSubscriptions.contains(subscription),
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
        } else {
          return Container(); // 不返回任何内容
        }
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  Widget _buildBlacklist(List<SmsSubscriptionModel> subscriptions) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: subscriptions.length,
      itemBuilder: (context, index) {
        final subscription = subscriptions[index];
        // 根据条件过滤黑名单
        if (subscription.isBlacklist) {
          return CheckboxListTile(
            title: Text(subscription.name),
            value:
                _isSelectAll || _selectedSubscriptions.contains(subscription),
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
        } else {
          return Container(); // 不返回任何内容
        }
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
