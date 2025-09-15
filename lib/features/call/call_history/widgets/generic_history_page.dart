// lib/features/common/widgets/generic_history_page.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/base/base_entity.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_timeline_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通用历史记录页面的逻辑控制器 (最终版 - 无假设)
///
/// [T] 是实体类型, [S] 是服务类型, [M] 是元数据类型
class GenericHistoryPage<T extends BaseEntity, S, M> extends ConsumerStatefulWidget {
  final String title;
  final Color themeColor;
  final ProviderBase<S> serviceProvider;
  final Future<List<T>> Function(S service) getItems;
  final Future<M> Function(WidgetRef ref, List<T> items)? getSecondaryMeta;
  final Future<void> Function(S service, List<T> itemsToDelete)? deleteItems;
  final Future<void> Function(S service)? clearAllItems;
  
  /// 列表项构建器
  /// 新增: refresh 回调，允许子组件触发列表刷新
  final Widget Function(BuildContext context, T item, M? meta, VoidCallback refresh) itemBuilder;
  
  final Widget? Function(BuildContext context, List<T> allItems, Function(String key, dynamic value) updateFilters)? headerContentBuilder;
  final bool Function(T item, Map<String, dynamic> filters)? filterPredicate;
  
  /// 搜索谓词回调，定义如何根据搜索关键字筛选项目
  final bool Function(T item, String keyword) searchPredicate;

  final Widget Function() adBuilder;
  final String emptyText;
  final IconData emptyIcon;
  final String Function(T) getItemId;
  final DateTime? Function(T item) getItemTimestamp;

  const GenericHistoryPage({
    super.key,
    required this.title,
    required this.themeColor,
    required this.serviceProvider,
    required this.getItems,
    this.getSecondaryMeta,
    this.deleteItems,
    this.clearAllItems,
    required this.itemBuilder,
    this.headerContentBuilder,
    this.filterPredicate,
    required this.searchPredicate,
    required this.adBuilder,
    required this.emptyText,
    required this.emptyIcon,
    required this.getItemId,
    required this.getItemTimestamp,
  });

  @override
  ConsumerState<GenericHistoryPage<T, S, M>> createState() => _GenericHistoryPageState<T, S, M>();
}

class _GenericHistoryPageState<T extends BaseEntity, S, M> extends ConsumerState<GenericHistoryPage<T, S, M>> {
  List<T> _allItems = [];
  List<T> _filteredItems = [];
  M? _metadata;
  bool _isLoading = true;
  ListDisplayMode _displayMode = ListDisplayMode.timeline;
  final Set<String> _selectedItemIds = {};
  bool _isMultiSelectMode = false;
  String _searchKeyword = '';
  Map<String, dynamic> _filters = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      if (_isMultiSelectMode) {
        _isMultiSelectMode = false;
        _selectedItemIds.clear();
      }
    });

    try {
      final service = ref.read(widget.serviceProvider);
      final items = await widget.getItems(service);
      M? meta;
      if (widget.getSecondaryMeta != null) {
        meta = await widget.getSecondaryMeta!(ref, items);
      }

      if (mounted) {
        setState(() {
          _allItems = items;
          _metadata = meta;
          _applyFilters();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.dataLoadFailure(e.toString())),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  void _applyFilters() {
    List<T> filtered = List.from(_allItems);

    if (widget.filterPredicate != null) {
      filtered = filtered.where((item) => widget.filterPredicate!(item, _filters)).toList();
    }

    if (_searchKeyword.isNotEmpty) {
      final keyword = _searchKeyword.toLowerCase();
      filtered = filtered.where((item) => widget.searchPredicate(item, keyword)).toList();
    }

    filtered.sort((a, b) => widget.getItemTimestamp(b)!.compareTo(widget.getItemTimestamp(a)!));

    setState(() {
      _filteredItems = filtered;
    });
  }

  void _updateFilters(String key, dynamic value) {
    setState(() {
      _filters[key] = value;
      _applyFilters();
    });
  }

  void _deleteSelectedItems() async {
    if (widget.deleteItems == null || _selectedItemIds.isEmpty) return;

    final service = ref.read(widget.serviceProvider);
    try {
      final List<T> itemsToDelete = _allItems
          .where((item) => _selectedItemIds.contains(widget.getItemId(item)))
          .toList();

      if (itemsToDelete.isNotEmpty) {
        await widget.deleteItems!(service, itemsToDelete);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.deleteSuccess),
          backgroundColor: Colors.green,
        ));
      }
      await _loadData();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.deleteFailed(e.toString())),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(_displayMode == ListDisplayMode.timeline ? Icons.view_list : Icons.timeline),
              title: Text(_displayMode == ListDisplayMode.timeline ? AppLocalizations.of(context)!.listView : AppLocalizations.of(context)!.timelineView),
              onTap: () {
                Navigator.pop(context);
                if (mounted) { setState(() { _displayMode = _displayMode == ListDisplayMode.timeline ? ListDisplayMode.list : ListDisplayMode.timeline; }); }
              },
            ),
            if (widget.clearAllItems != null)
              ListTile(
                leading: const Icon(Icons.delete_sweep),
                title: Text(AppLocalizations.of(context)!.clearAllCallLogs),
                onTap: () {
                  Navigator.pop(context);
                  _showClearAllDialog();
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showClearAllDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.clearAllCallLogs),
        content: Text(AppLocalizations.of(context)!.clearAllCallLogsConfirmation),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(AppLocalizations.of(context)!.cancelButton)),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    );
    if (confirmed == true && widget.clearAllItems != null) {
      await widget.clearAllItems!(ref.read(widget.serviceProvider));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.allCallLogsCleared),
          backgroundColor: Colors.green,
        ));
      }
      await _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GenericTimelineListWithAdsPage<T>(
      title: widget.title,
      themeColor: widget.themeColor,
      items: _filteredItems,
      isLoading: _isLoading,
      onRefresh: _loadData,
      displayMode: _displayMode,
      getItemTimestamp: widget.getItemTimestamp,
      headerContent: widget.headerContentBuilder?.call(context, _allItems, _updateFilters),
      itemBuilder: (context, item) => widget.itemBuilder(context, item, _metadata, _loadData),
      adBuilder: widget.adBuilder,
      emptyText: widget.emptyText,
      emptyIcon: widget.emptyIcon,
      searchHintText: AppLocalizations.of(context)!.searchHint,
      onSearchChanged: (keyword) {
        _searchKeyword = keyword;
        _applyFilters();
      },
      isMultiSelectMode: _isMultiSelectMode,
      selectedItemIds: _selectedItemIds,
      getItemId: widget.getItemId,
      onToggleMultiSelectMode: () => setState(() {
        _isMultiSelectMode = !_isMultiSelectMode;
        if (!_isMultiSelectMode) _selectedItemIds.clear();
      }),
      onToggleItemSelection: (itemId) => setState(() {
        if (_selectedItemIds.contains(itemId)) {
          _selectedItemIds.remove(itemId);
        } else {
          _selectedItemIds.add(itemId);
        }
      }),
      onDeleteSelected: widget.deleteItems != null ? _deleteSelectedItems : null,
      onMoreOptions: _showMoreOptions,
    );
  }
}