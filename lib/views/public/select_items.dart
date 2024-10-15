import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../subpage_style.dart';

class SelectEntriesDialog<T> extends StatefulWidget {
  final List<T> entries;
  final bool hasSubscriptionTabs; // 是否显示订阅相关的选项卡
  final bool hasBlacklistWhitelistTabs; // 是否显示黑白名单相关的选项卡
  final String searchKey; // 用于搜索和显示的 key

  const SelectEntriesDialog({
    super.key,
    required this.entries,
    this.hasSubscriptionTabs = false, // 默认不显示订阅选项卡
    this.hasBlacklistWhitelistTabs = false, // 默认不显示黑白名单选项卡
    required this.searchKey,
  });

  @override
  SelectEntriesDialogState<T> createState() => SelectEntriesDialogState<T>();
}

class SelectEntriesDialogState<T> extends State<SelectEntriesDialog<T>> {
  final Set<T> _selectedEntries = <T>{};
  bool _isSelectAll = false;
  String _keyword = '';

  @override
  Widget build(BuildContext context) {
    final filteredEntries = widget.entries
        .where((entry) => (entry as dynamic)[widget.searchKey]
            .toLowerCase()
            .contains(_keyword.toLowerCase()))
        .toList();

    int tabCount = 1;
    if (widget.hasSubscriptionTabs) tabCount += 2;
    if (widget.hasBlacklistWhitelistTabs) tabCount += 2;

    return AlertDialog(
      title: Text(S.of(context).selectEntries),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 搜索框
            TextField(
              decoration: InputDecoration(
                labelText: S.of(context).searchEntries,
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
            // 全选按钮
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
                Text(S.of(context).selectAll,
                    style: SubscriptionPageStyles.tabLabelStyle),
              ],
            ),
            const SizedBox(height: 16.0),
            // 选项卡视图
            Expanded(
              child: DefaultTabController(
                length: tabCount,
                child: Column(
                  children: <Widget>[
                    TabBar(
                      labelPadding: const EdgeInsets.only(left: 5.0),
                      isScrollable: tabCount > 3, // 如果选项卡超过3个，则可滚动
                      tabs: [
                        Tab(text: S.of(context).all),
                        if (widget.hasSubscriptionTabs)
                          Tab(text: S.of(context).subscribed),
                        if (widget.hasSubscriptionTabs)
                          Tab(text: S.of(context).unsubscribed),
                        if (widget.hasBlacklistWhitelistTabs)
                          Tab(text: S.of(context).blacklist),
                        if (widget.hasBlacklistWhitelistTabs)
                          Tab(text: S.of(context).whitelist),
                      ],
                      labelColor: Colors.blue,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildEntriesList(filteredEntries),
                          if (widget.hasSubscriptionTabs)
                            _buildSubscribed(filteredEntries),
                          if (widget.hasSubscriptionTabs)
                            _buildUnsubscribed(filteredEntries),
                          if (widget.hasBlacklistWhitelistTabs)
                            _buildBlacklist(filteredEntries),
                          if (widget.hasBlacklistWhitelistTabs)
                            _buildWhitelist(filteredEntries),
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
        // 取消按钮
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(S.of(context).cancel),
        ),
        // 确认按钮
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedEntries.toList());
          },
          child: Text(S.of(context).ok),
        ),
      ],
    );
  }

  Widget _buildEntriesList(List<T> entries) {
    return SingleChildScrollView(
      child: Column(
        children: entries.map((entry) {
          return CheckboxListTile(
            title: Text((entry as dynamic)[widget.searchKey]),
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

  Widget _buildSubscribed(List<T> entries) {
    final subscribedEntries =
        entries.where((entry) => (entry as dynamic).isSubscribed).toList();
    return _buildEntriesList(subscribedEntries);
  }

  Widget _buildUnsubscribed(List<T> entries) {
    final unsubscribedEntries =
        entries.where((entry) => !(entry as dynamic).isSubscribed).toList();
    return _buildEntriesList(unsubscribedEntries);
  }

  Widget _buildBlacklist(List<T> entries) {
    final blacklistEntries =
        entries.where((entry) => (entry as dynamic).isBlacklist).toList();
    return _buildEntriesList(blacklistEntries);
  }

  Widget _buildWhitelist(List<T> entries) {
    final whitelistEntries =
        entries.where((entry) => (entry as dynamic).isWhitelist).toList();
    return _buildEntriesList(whitelistEntries);
  }
}
