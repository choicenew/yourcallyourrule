import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

enum ListDisplayMode {
  list,
  timeline,
}

/// 通用列表与时间轴页面组件 - 标准通用框架
class GenericTimelinePage<T> extends ConsumerStatefulWidget {
  final String title;
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  final Widget Function() adBuilder;
  final int adInterval;
  final String emptyText;
  final IconData emptyIcon;
  final Widget? emptyActionButton;
  final Color? themeColor;
  final bool isLoading;
  final VoidCallback? onRefresh;
  final VoidCallback? onAdd;
  final VoidCallback? onMoreOptions;
  final List<Widget>? actions;
  final Widget? headerContent;
  final void Function(List<T>)? onMultiSelect;
  final String Function(T)? getItemId;
  final bool isMultiSelectMode;
  final Set<String> selectedItemIds;
  final VoidCallback? onToggleMultiSelectMode;
  final VoidCallback? onDeleteSelected;
  final List<Widget>? customActions;
  final Function(String)? onToggleItemSelection;
  final String? searchHintText;
  final ValueChanged<String>? onSearchChanged;
  final Widget? infoCard;
  final ListDisplayMode displayMode;
  final DateTime? Function(T item)? getItemTimestamp;

  const GenericTimelinePage({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    required this.adBuilder,
    this.adInterval = 3,
    required this.emptyText,
    this.emptyIcon = Icons.info_outline,
    this.emptyActionButton,
    this.themeColor,
    this.isLoading = false,
    this.onRefresh,
    this.onAdd,
    this.onMoreOptions,
    this.actions,
    this.headerContent,
    this.onMultiSelect,
    this.getItemId,
    this.isMultiSelectMode = false,
    this.selectedItemIds = const {},
    this.onToggleMultiSelectMode,
    this.onDeleteSelected,
    this.customActions,
    this.onToggleItemSelection,
    this.searchHintText,
    this.onSearchChanged,
    this.infoCard,
    this.displayMode = ListDisplayMode.list,
    this.getItemTimestamp,
  }) : assert(
            displayMode == ListDisplayMode.list || getItemTimestamp != null,
            'getItemTimestamp must be provided for timeline mode.',
          );

  @override
  ConsumerState<GenericTimelinePage<T>> createState() => _GenericTimelinePageState<T>();
}

class _GenericTimelinePageState<T> extends ConsumerState<GenericTimelinePage<T>> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (widget.onSearchChanged != null) {
        widget.onSearchChanged!(_searchController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
        title: widget.isMultiSelectMode 
          ? Text(
              AppLocalizations.of(context).selectedItems(widget.selectedItemIds.length),
              style: TextStyle(color: theme.colorScheme.onSurface, fontWeight: FontWeight.w900, fontSize: 18),
            ) 
          : Text(
              widget.title,
              style: TextStyle(color: theme.colorScheme.onSurface, fontWeight: FontWeight.w900, fontSize: 20, letterSpacing: -0.3),
            ),
        leading: widget.isMultiSelectMode 
          ? IconButton(
              icon: Icon(Icons.close_rounded, color: theme.colorScheme.onSurface),
              onPressed: widget.onToggleMultiSelectMode,
            )
          : null,
        actions: widget.isMultiSelectMode 
          ? _buildMultiSelectActions() 
          : _buildDefaultActions(),
      ),
      body: widget.isLoading
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : _buildContent(),
    );
  }

  List<Widget> _buildDefaultActions() {
    final actions = <Widget>[];
    if (widget.customActions != null) {
      actions.addAll(widget.customActions!);
    }
    if (widget.getItemId != null && widget.onToggleMultiSelectMode != null) {
      actions.add(_buildAppbarButton(icon: Icons.checklist_rtl_rounded, onPressed: widget.onToggleMultiSelectMode!, tooltip: AppLocalizations.of(context).selectMultiple));
    }
    if (widget.onAdd != null) {
      actions.add(_buildAppbarButton(icon: Icons.add_rounded, onPressed: widget.onAdd!, tooltip: AppLocalizations.of(context).add));
    }
    if (widget.onRefresh != null) {
      actions.add(_buildAppbarButton(icon: Icons.refresh_rounded, onPressed: widget.onRefresh!, tooltip: AppLocalizations.of(context).refresh));
    }
    if (widget.onMoreOptions != null) {
      actions.add(_buildAppbarButton(icon: Icons.more_horiz_rounded, onPressed: widget.onMoreOptions!, tooltip: AppLocalizations.of(context).moreOptions));
    }
    if (widget.customActions == null && widget.actions != null) {
      actions.addAll(widget.actions!);
    }
    return actions;
  }
  
  List<Widget> _buildMultiSelectActions() {
    return [
      IconButton(
        icon: Icon(Icons.delete_outline_rounded, color: Theme.of(context).colorScheme.error),
        onPressed: widget.selectedItemIds.isNotEmpty ? widget.onDeleteSelected : null,
        tooltip: AppLocalizations.of(context).deleteSelected,
      ),
    ];
  }

  Widget _buildAppbarButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: IconButton(
        icon: Icon(icon, color: theme.colorScheme.onSurfaceVariant, size: 20),
        onPressed: onPressed,
        tooltip: tooltip,
        style: IconButton.styleFrom(
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(8),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.infoCard != null) Padding(padding: const EdgeInsets.only(top: 12), child: widget.infoCard!),
          if (widget.headerContent != null) Padding(padding: const EdgeInsets.only(top: 12), child: widget.headerContent!),
          if (widget.onSearchChanged != null)
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: 1.1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurface),
                  decoration: InputDecoration(
                    hintText: widget.searchHintText ?? AppLocalizations.of(context).search,
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.6), fontSize: 13, fontWeight: FontWeight.w500),
                    prefixIcon: Icon(Icons.search_rounded, color: widget.themeColor ?? Theme.of(context).colorScheme.primary, size: 20),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear_rounded, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
                            onPressed: () {
                              _searchController.clear();
                              if (widget.onSearchChanged != null) {
                                widget.onSearchChanged!('');
                              }
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
                  ),
                ),
              ),
            ),
          Expanded(
            child: _buildList(),
          ),
        ],
      ),
    );
  }

  Widget _buildItemWidget(BuildContext context, T item) {
    if (widget.isMultiSelectMode && widget.getItemId != null) {
      final itemId = widget.getItemId!(item);
      final isSelected = widget.selectedItemIds.contains(itemId);
      return InkWell(
        onTap: () => widget.onToggleItemSelection?.call(itemId),
        child: Row(
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (_) => widget.onToggleItemSelection?.call(itemId),
              activeColor: widget.themeColor ?? Theme.of(context).colorScheme.primary,
            ),
            Expanded(child: widget.itemBuilder(context, item)),
          ],
        ),
      );
    }
    return widget.itemBuilder(context, item);
  }

  Widget _buildList() {
    final emptyWidget = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.emptyIcon, size: 64, color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          Text(widget.emptyText, style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
          if (widget.emptyActionButton != null) ...[const SizedBox(height: 24), widget.emptyActionButton!],
        ],
      ),
    );

    if (widget.items.isEmpty) {
      return emptyWidget;
    }

    switch (widget.displayMode) {
      case ListDisplayMode.timeline:
        return _buildTimelineLayout(context);
      case ListDisplayMode.list:
      default:
        return _buildFlatListLayout(context, emptyWidget);
    }
  }

  Widget _buildFlatListLayout(BuildContext context, Widget emptyWidget) {
    if (widget.items.isEmpty) {
      return emptyWidget;
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return _buildItemWidget(context, item);
      },
    );
  }

  Widget _buildTimelineLayout(BuildContext context) {
    final Map<String, List<T>> groupedItems = {};
    final localizations = AppLocalizations.of(context);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    
    for (final item in widget.items) {
      final itemDate = widget.getItemTimestamp!(item);
      if (itemDate == null) continue;

      final itemDay = DateTime(itemDate.year, itemDate.month, itemDate.day);
      
      String groupKey;
      if (itemDay == today) {
        groupKey = localizations.today;
      } else if (itemDay == yesterday) {
        groupKey = localizations.yesterday;
      } else {
        groupKey = localizations.earlier;
      }
      
      if (!groupedItems.containsKey(groupKey)) groupedItems[groupKey] = [];
      groupedItems[groupKey]!.add(item);
    }
    
    final sortedKeys = groupedItems.keys.toList()
      ..sort((a, b) {
        final order = {localizations.today: 0, localizations.yesterday: 1, localizations.earlier: 2};
        return order[a]!.compareTo(order[b]!);
      });
    
    final List<Widget> timelineWidgets = [];
    int itemCounter = 0;

    for (final groupKey in sortedKeys) {
      final groupItems = groupedItems[groupKey]!;
      
      timelineWidgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 18.0),
          child: Text(groupKey, style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant)),
        ),
      );
      
      for (final item in groupItems) {
        final String itemId = widget.getItemId?.call(item) ?? item.hashCode.toString();
        final Color randomColor = HSVColor.fromAHSV(
          1.0,
          (itemId.hashCode % 360).toDouble(),
          0.8,
          0.9,
        ).toColor();

        timelineWidgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 12,
                  margin: const EdgeInsets.only(top: 16.0),
                  alignment: Alignment.center,
                  child: _buildTimelineNode(context, randomColor),
                ),
                const SizedBox(width: 2),
                Expanded(
                  child: _buildItemWidget(context, item),
                ),
              ],
            ),
          )
        );

        itemCounter++;
        if (itemCounter % widget.adInterval == 0 && itemCounter != widget.items.length) {
          timelineWidgets.add(widget.adBuilder());
        }
      }
    }
    
    return Stack(
      children: [
        Positioned(
          left: 5,
          top: 0,
          bottom: 0,
          width: 2,
          child: Container(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        ListView(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          children: timelineWidgets,
        ),
      ],
    );
  }

  Widget _buildTimelineNode(BuildContext context, Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color, 
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).colorScheme.surface, width: 2),
      ),
    );
  }
}
