import 'dart:async';
import 'dart:math'; // 导入 math 库用于随机数（虽然我们最终用hashCode）

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 假设您的项目中存在这些文件
import 'package:yourcallyourrule/ads/ad_control_service.dart';
import 'package:yourcallyourrule/ads/ad_list_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// 新增：用于切换显示模式的枚举
enum ListDisplayMode {
  /// 传统的扁平列表
  list,
  /// 带分组和时间线的时间轴列表
  timeline,
}

/// 通用列表页面组件 - 集成广告和可选的时间轴功能
/// 
/// 这个组件可用于以下页面：
/// - plugin_management_page.dart (使用 list 模式)
/// - rule_management_page.dart (使用 list 模式)
/// - call_history_page.dart (使用 timeline 模式)
/// 等需要显示列表并集成广告的页面
class GenericTimelineListWithAdsPage<T> extends ConsumerStatefulWidget {
  /// 页面标题
  final String title;
  
  /// 列表项
  final List<T> items;
  
  /// 列表项构建器
  final Widget Function(BuildContext, T) itemBuilder;
  
  /// 广告构建器
  final Widget Function() adBuilder;
  
  /// 广告间隔
  final int adInterval;
  
  /// 空状态文本
  final String emptyText;
  
  /// 空状态图标
  final IconData emptyIcon;
  
  /// 空状态操作按钮
  final Widget? emptyActionButton;
  
  /// 主题颜色
  final Color themeColor;
  
  /// 是否正在加载
  final bool isLoading;
  
  /// 刷新回调
  final VoidCallback? onRefresh;
  
  /// 添加项目回调
  final VoidCallback? onAdd;
  
  /// 更多选项回调
  final VoidCallback? onMoreOptions;
  
  /// 自定义操作按钮列表
  final List<Widget>? actions;
  
  /// 页面顶部的额外内容
  final Widget? headerContent;
  
  /// 多选回调 - 当用户选择了多个项目时调用
  final void Function(List<T>)? onMultiSelect;
  
  /// 获取项目ID的函数 - 用于多选模式和生成稳定颜色
  final String Function(T)? getItemId;
  
  /// 是否处于多选模式
  final bool isMultiSelectMode;
  
  /// 选中的项目ID集合
  final Set<String> selectedItemIds;
  
  /// 切换多选模式的回调
  final VoidCallback? onToggleMultiSelectMode;
  
  /// 删除选中项目的回调
  final VoidCallback? onDeleteSelected;
  
  /// 自定义操作按钮列表
  final List<Widget>? customActions;
  
  /// 切换项目选择状态的回调
  final Function(String)? onToggleItemSelection;

  /// 搜索框提示文本
  final String? searchHintText;

  /// 搜索回调
  final ValueChanged<String>? onSearchChanged;

  /// 页面顶部的提示卡片
  final Widget? infoCard;
  
  /// 列表的显示模式（扁平列表或时间轴）
  final ListDisplayMode displayMode;

  /// 获取项目时间戳的函数 - 仅在 `timeline` 模式下需要
  final DateTime? Function(T item)? getItemTimestamp;

  /// 构造函数
  const GenericTimelineListWithAdsPage({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    required this.adBuilder,
    this.adInterval = 3,
    required this.emptyText,
    this.emptyIcon = Icons.info_outline,
    this.emptyActionButton,
    this.themeColor = Colors.blue,
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
  ConsumerState<GenericTimelineListWithAdsPage<T>> createState() => _GenericTimelineListWithAdsPageState<T>();
}

class _GenericTimelineListWithAdsPageState<T> extends ConsumerState<GenericTimelineListWithAdsPage<T>> {
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
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F5),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFFFBF9F5),
        foregroundColor: Colors.black87,
        title: widget.isMultiSelectMode 
          ? Text(
              AppLocalizations.of(context)!.selectedItems(widget.selectedItemIds.length),
              style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 18),
            ) 
          : Text(
              widget.title,
              style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 20, letterSpacing: -0.3),
            ),
        leading: widget.isMultiSelectMode 
          ? IconButton(
              icon: const Icon(Icons.close_rounded, color: Colors.black87),
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
      actions.add(_buildAppbarButton(icon: Icons.checklist_rtl_rounded, onPressed: widget.onToggleMultiSelectMode!, tooltip: AppLocalizations.of(context)!.selectMultiple));
    }
    if (widget.onAdd != null) {
      actions.add(_buildAppbarButton(icon: Icons.add_rounded, onPressed: widget.onAdd!, tooltip: AppLocalizations.of(context)!.add));
    }
    if (widget.onRefresh != null) {
      actions.add(_buildAppbarButton(icon: Icons.refresh_rounded, onPressed: widget.onRefresh!, tooltip: AppLocalizations.of(context)!.refresh));
    }
    if (widget.onMoreOptions != null) {
      actions.add(_buildAppbarButton(icon: Icons.more_horiz_rounded, onPressed: widget.onMoreOptions!, tooltip: AppLocalizations.of(context)!.moreOptions));
    }
    if (widget.customActions == null && widget.actions != null) {
      actions.addAll(widget.actions!);
    }
    return actions;
  }
  
  List<Widget> _buildMultiSelectActions() {
    return [
      IconButton(
        icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
        onPressed: widget.selectedItemIds.isNotEmpty ? widget.onDeleteSelected : null,
        tooltip: AppLocalizations.of(context)!.deleteSelected,
      ),
    ];
  }

  Widget _buildAppbarButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: IconButton(
        icon: Icon(icon, color: Colors.grey[800], size: 20),
        onPressed: onPressed,
        tooltip: tooltip,
        style: IconButton.styleFrom(
          backgroundColor: const Color(0xFFF7F5F0),
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFEDE8DF),
                    width: 1.1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
                  decoration: InputDecoration(
                    hintText: widget.searchHintText ?? AppLocalizations.of(context)!.search,
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13, fontWeight: FontWeight.w500),
                    prefixIcon: Icon(Icons.search_rounded, color: widget.themeColor, size: 20),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 16, color: Colors.grey),
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
              activeColor: widget.themeColor,
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
          Icon(widget.emptyIcon, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(widget.emptyText, style: TextStyle(fontSize: 18, color: Colors.grey[600]), textAlign: TextAlign.center),
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
    return AdListWidget<T>(
      items: widget.items,
      adBuilder: widget.adBuilder,
      itemBuilder: (context, item) => _buildItemWidget(context, item),
      adInterval: widget.adInterval,
      adControlServiceProvider: adControlServiceProvider,
      emptyWidget: emptyWidget,
      padding: const EdgeInsets.symmetric(vertical: 8),
      physics: const AlwaysScrollableScrollPhysics(),
    );
  }

  Widget _buildTimelineLayout(BuildContext context) {
    final Map<String, List<T>> groupedItems = {};
    final localizations = AppLocalizations.of(context)!;
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
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 28.0),
          child: Text(groupKey, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ),
      );
      
      for (final item in groupItems) {
        final String itemId = widget.getItemId?.call(item) ?? item.hashCode.toString();
        final Color randomColor = HSVColor.fromAHSV(
          1.0, // Alpha (不透明)
          (itemId.hashCode % 360).toDouble(), // Hue (色相, 0-360)
          0.8, // Saturation (饱和度, 0-1, 越高越鲜艳)
          0.9, // Value (亮度, 0-1, 越高越明亮)
        ).toColor();

        timelineWidgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: const Offset(-11.0, 16.0),
                  child: _buildTimelineNode(context, randomColor),
                ),
                const SizedBox(width: 5),
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
          child: Container(color: Colors.grey[300]),
        ),
        ListView(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          children: timelineWidgets,
        ),
      ],
    );
  }

  /// 构建时间轴上的单个节点（圆点）
  /// [color] 参数用于指定节点的颜色
  Widget _buildTimelineNode(BuildContext context, Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color, 
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }
}