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
  bool _isInfoCardExpanded = false;

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
          )
        : null;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F5),
      appBar: appBar,
      body: widget.isLoading
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : _buildContent(),
    );
  }

  List<Widget> _buildDefaultActions() {
    final actions = <Widget>[];
    
    // 自定义操作按钮
    if (widget.customActions != null) {
      actions.addAll(widget.customActions!);
    }
    
    // 多选模式按钮
    if (widget.getItemId != null && widget.onToggleMultiSelectMode != null) {
      actions.add(
        _buildAppbarButton(
          icon: Icons.checklist_rtl_rounded,
          onPressed: widget.onToggleMultiSelectMode!,
          tooltip: AppLocalizations.of(context)!.selectMultiple,
        ),
      );
    }
    
    // 添加按钮
    if (widget.onAdd != null) {
      actions.add(
        _buildAppbarButton(
          icon: Icons.add_rounded,
          onPressed: widget.onAdd!,
          tooltip: AppLocalizations.of(context)!.add,
        ),
      );
    }
    
    // 刷新按钮
    if (widget.onRefresh != null) {
      actions.add(
        _buildAppbarButton(
          icon: Icons.refresh_rounded,
          onPressed: widget.onRefresh!,
          tooltip: AppLocalizations.of(context)!.refresh,
        ),
      );
    }
    
    // 更多选项按钮
    if (widget.onMoreOptions != null) {
      actions.add(
        _buildAppbarButton(
          icon: Icons.more_horiz_rounded,
          onPressed: widget.onMoreOptions!,
          tooltip: AppLocalizations.of(context)!.moreOptions,
        ),
      );
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
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 提示卡片（支持标准折叠与展开）
          if (widget.infoCard != null) ...[_buildCollapsibleInfoCard(), const SizedBox(height: 12)],

          // 头部内容（如果有）
          if (widget.headerContent != null) ...[widget.headerContent!, const SizedBox(height: 12)],

          // 搜索框
          if (widget.onSearchChanged != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
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
          
          // 列表（占用剩余空间）
          Expanded(
            child: _buildList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCollapsibleInfoCard() {
    if (!_isInfoCardExpanded) {
      return InkWell(
        onTap: () {
          setState(() {
            _isInfoCardExpanded = true;
          });
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: widget.themeColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: widget.themeColor.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 18,
                color: widget.themeColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.description,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: widget.themeColor,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                size: 18,
                color: widget.themeColor,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isInfoCardExpanded = false;
            });
          },
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 18,
                  color: widget.themeColor,
                ),
                const SizedBox(width: 6),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: widget.themeColor,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_up,
                  size: 18,
                  color: widget.themeColor,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        widget.infoCard!,
      ],
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