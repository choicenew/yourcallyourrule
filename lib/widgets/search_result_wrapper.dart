import 'package:flutter/material.dart';

import '../generated/l10n.dart';



class SearchResultWrapper extends StatefulWidget {
  final String initialSearchValue;
  final String pageTitle;
  final Widget child; // 修改为 Widget 类型

  const SearchResultWrapper({
    super.key,
    required this.initialSearchValue,
    required this.pageTitle,
    required this.child,
  });

  @override
  State<SearchResultWrapper> createState() => _SearchResultWrapperState();
}

class _SearchResultWrapperState extends State<SearchResultWrapper> {
  String _currentSearchValue = '';

  @override
  void initState() {
    super.initState();
    _currentSearchValue = widget.initialSearchValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.pageTitle}: $_currentSearchValue'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${S.of(context).showingSearchResultsFor} $_currentSearchValue', 

    ),
          ),
          Expanded(
            child: NotificationListener<SearchNotification>(
              onNotification: (notification) {
                setState(() {
                  _currentSearchValue = notification.searchValue;
                });
                return true;
              },
              child: widget.child, // 直接使用 child 属性
            ),
          ),
        ],
      ),
    );
  }
}

class SearchNotification extends Notification {
  final String searchValue;

  SearchNotification(this.searchValue);
}