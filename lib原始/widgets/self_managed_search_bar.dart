import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../utils/ad_state.dart';
import 'adwidgets/native_ads.dart';

class AdvancedSelfManagedSearchBar<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext, T, double) itemBuilder;
  final String Function(T) getSearchString;
  final List<String> Function(T) getSortFields;
  final List<dynamic> Function(T) getSortFieldValues;
  final Widget Function(BuildContext, List<T>) originalBuilder;

  const AdvancedSelfManagedSearchBar({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.getSearchString,
    required this.getSortFields,
    required this.getSortFieldValues,
    required this.originalBuilder,
  });

  @override
  AdvancedSelfManagedSearchBarState<T> createState() => AdvancedSelfManagedSearchBarState<T>();
}

class AdvancedSelfManagedSearchBarState<T> extends State<AdvancedSelfManagedSearchBar<T>> {
  late List<T> _filteredItems;
  String _searchQuery = '';
  String _sortField = '';
  bool _sortAscending = true;
  bool _isSortingEnabled = false;  // New state variable for sorting toggle

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(widget.items);
    if (widget.items.isNotEmpty) {
      _sortField = widget.getSortFields(widget.items.first).first;
    }
    _filterAndSortItems();
  }

  void handleSearch(String query) {
    setState(() {
      _searchQuery = query;
      _filterAndSortItems();
    });
  }

  void _handleSort(String? field) {
    if (field != null && _isSortingEnabled) {
      setState(() {
        if (field == _sortField) {
          _sortAscending = !_sortAscending;
        } else {
          _sortField = field;
          _sortAscending = true;
        }
        _filterAndSortItems();
      });
    }
  }

  void _toggleSorting(bool value) {
    setState(() {
      _isSortingEnabled = value;
      _filterAndSortItems();
    });
  }

  void _filterAndSortItems() {
    _filteredItems = widget.items.where((item) {
      return widget.getSearchString(item).toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    if (_isSortingEnabled && _sortField.isNotEmpty) {
      final sortFieldIndex = widget.getSortFields(widget.items.first).indexOf(_sortField);
      _filteredItems.sort((a, b) {
        final aValue = widget.getSortFieldValues(a)[sortFieldIndex];
        final bValue = widget.getSortFieldValues(b)[sortFieldIndex];
        int comparison;
        if (aValue is String && bValue is String) {
          comparison = aValue.toLowerCase().compareTo(bValue.toLowerCase());
        } else if (aValue is num && bValue is num) {
          comparison = aValue.compareTo(bValue);
        } else {
          comparison = 0;
        }
        return _sortAscending ? comparison : -comparison;
      });
    }
  }

  Widget _buildResults(BuildContext context, BoxConstraints constraints) {
    final orientation = MediaQuery.of(context).orientation;
    final mediaQuery = MediaQuery.of(context);
    final adState = Provider.of<AdState>(context);

    final int entriesPerRow = orientation == Orientation.portrait
        ? (mediaQuery.size.width > 900 ? 2 : 1)
        : (mediaQuery.size.width > 1000 ? 4 : 2);

    final double functionEntryHorizontalPadding =
        mediaQuery.size.width > 900 ? 24.0 : 9.0;

    final double entryWidth = (mediaQuery.size.width -
            2 * functionEntryHorizontalPadding -
            (entriesPerRow - 1) * 10) /
        entriesPerRow;

    return ListView.builder(
      itemCount: _filteredItems.length + (_filteredItems.length ~/ 3),
      itemBuilder: (context, index) {
        if ((index + 1) % 4 == 0 && adState.isAdEnabled) {
          return nativeAdWidgetSmall(adWidth: entryWidth, adHeight: 90);
        } else {
          final itemIndex = index - (index ~/ 4);
          return widget.itemBuilder(context, _filteredItems[itemIndex], entryWidth);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: handleSearch,
            decoration: InputDecoration(
              labelText: S.of(context).search,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        if (widget.items.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(S.of(context).enableSorting),
                Switch(
                  value: _isSortingEnabled,
                  onChanged: _toggleSorting,
                ),
                if (_isSortingEnabled) ...[
                  const SizedBox(width: 16),
                 Text(S.of(context).sortBy),
                  DropdownButton<String>(
                    value: _sortField,
                    items: widget.getSortFields(widget.items.first).map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: _handleSort,
                  ),
                  IconButton(
                    icon: Icon(_sortAscending ? Icons.arrow_upward : Icons.arrow_downward),
                    onPressed: () => _handleSort(_sortField),
                  ),
                ],
              ],
            ),
          ),
        Expanded(
          child: LayoutBuilder(builder: _buildResults),
        ),
      ],
    );
  }
}