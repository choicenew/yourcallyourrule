import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_control_service.dart';
import 'package:yourcallyourrule/ads/ad_list_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通用列表页面组件 - 集成广告功能
/// 
/// 这个组件可用于以下页面：
/// - plugin_management_page.dart
/// - rule_management_page.dart
/// - sms_management_page.dart
/// - contacts_management_page.dart
/// 等需要显示列表并集成广告的页面
class GenericListWithAdsPage<T> extends ConsumerStatefulWidget {
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
  
  /// 获取项目ID的函数 - 用于多选模式
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
  
  /// 【新增参数】是否显示 AppBar
  /// 默认为 true，这意味着你现有的所有代码都不受影响。
  /// 当需要在 TabBarView 中使用时，传入 false。
  final bool showAppBar;
  
  /// 构造函数
  const GenericListWithAdsPage({
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
    this.showAppBar = true, // 默认值为 true
  });

  @override
  ConsumerState<GenericListWithAdsPage<T>> createState() => _GenericListWithAdsPageState<T>();
}

class _GenericListWithAdsPageState<T> extends ConsumerState<GenericListWithAdsPage<T>> {
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

  // 获取选中的项目列表
  List<T> get _selectedItems {
    if (widget.getItemId == null) return [];
    
    return widget.items.where((item) {
      final id = widget.getItemId!(item);
      return widget.selectedItemIds.contains(id);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // 根据 showAppBar 参数决定是否创建 AppBar Widget
    final appBar = widget.showAppBar 
        ? AppBar(
            title: widget.isMultiSelectMode 
              ? Text(AppLocalizations.of(context)!.selectedItems(widget.selectedItemIds.length)) 
              : Text(widget.title),
            backgroundColor: widget.themeColor,
            leading: widget.isMultiSelectMode 
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: widget.onToggleMultiSelectMode,
                )
              : null,
            actions: widget.isMultiSelectMode 
              ? _buildMultiSelectActions() 
              : _buildDefaultActions(),
          )
        : null; // 如果 showAppBar 为 false，则不传 AppBar

    return Scaffold(
      appBar: appBar,
      body: widget.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(),
    );
  }

  List<Widget> _buildDefaultActions() {
    final actions = <Widget>[];
    
    // 自定义操作按钮
    if (widget.customActions != null) {
      actions.addAll(widget.customActions!);
    }
    
    // 多选模式按钮 (如果提供了getItemId和onToggleMultiSelectMode)
    if (widget.getItemId != null && widget.onToggleMultiSelectMode != null) {
      actions.add(
        IconButton(
          icon: const Icon(Icons.select_all),
          onPressed: widget.onToggleMultiSelectMode,
          tooltip: AppLocalizations.of(context)!.selectMultiple,
        ),
      );
    }
    
    // 添加按钮
    if (widget.onAdd != null) {
      actions.add(
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: widget.onAdd,
          tooltip: AppLocalizations.of(context)!.add,
        ),
      );
    }
    
    // 刷新按钮
    if (widget.onRefresh != null) {
      actions.add(
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: widget.onRefresh,
          tooltip: AppLocalizations.of(context)!.refresh,
        ),
      );
    }
    
    // 更多选项按钮
    if (widget.onMoreOptions != null) {
      actions.add(
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: widget.onMoreOptions,
          tooltip: AppLocalizations.of(context)!.moreOptions,
        ),
      );
    }
    
    // 如果没有自定义操作且有 widget.actions，则使用 widget.actions
    if (widget.customActions == null && widget.actions != null) {
      actions.addAll(widget.actions!);
    }
    
    return actions;
  }
  
  List<Widget> _buildMultiSelectActions() {
    return [
      // 删除选中项
      IconButton(
        icon: const Icon(Icons.delete),
        onPressed: widget.selectedItemIds.isNotEmpty ? widget.onDeleteSelected : null,
        tooltip: AppLocalizations.of(context)!.deleteSelected,
      ),
    ];
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 提示卡片
          if (widget.infoCard != null) ...[widget.infoCard!, const SizedBox(height: 16)],

          // 头部内容（如果有）
          if (widget.headerContent != null) ...[widget.headerContent!, const SizedBox(height: 16)],

          // 搜索框
          if (widget.onSearchChanged != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: widget.searchHintText ?? AppLocalizations.of(context)!.search,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          
          // 列表（占用剩余空间）
          Expanded(
            child: _buildList(),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    // 创建空状态组件
    final emptyWidget = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.emptyIcon, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            widget.emptyText,
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          if (widget.emptyActionButton != null) ...[const SizedBox(height: 24), widget.emptyActionButton!],
        ],
      ),
    );

    // 使用AdListWidget构建列表
    return AdListWidget<T>(
      items: widget.items,
      adBuilder: widget.adBuilder,
      itemBuilder: (context, item) {
        // 如果在多选模式下，并且提供了getItemId，则包装原始itemBuilder
        if (widget.isMultiSelectMode && widget.getItemId != null) {
          final itemId = widget.getItemId!(item);
          final isSelected = widget.selectedItemIds.contains(itemId);
          
          // 包装原始的item widget，添加选择状态
          return InkWell(
            onTap: () => widget.onToggleItemSelection?.call(itemId),
            child: Row(
              children: [
                Checkbox(
                  value: isSelected,
                  onChanged: (_) => widget.onToggleItemSelection?.call(itemId),
                  activeColor: widget.themeColor,
                ),
                Expanded(
                  child: widget.itemBuilder(context, item),
                ),
              ],
            ),
          );
        }
        
        // 非多选模式，直接使用原始itemBuilder
        return widget.itemBuilder(context, item);
      },
      adInterval: widget.adInterval,
      adControlServiceProvider: adControlServiceProvider,
      emptyWidget: emptyWidget,
      padding: const EdgeInsets.symmetric(vertical: 8),
      physics: const AlwaysScrollableScrollPhysics(),
    );
  }
}