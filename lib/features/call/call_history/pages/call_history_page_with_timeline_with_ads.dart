import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/call_log_card.dart';
// 【核心修正】重新导入 BottomNavigation 组件
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_timeline_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// 只导入我们最终的、功能强大的通用组件


// 其他您需要的 imports
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/label_filter_chip.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';











class CallHistoryPageWithTimelineWithAds extends ConsumerStatefulWidget {
  const CallHistoryPageWithTimelineWithAds({super.key});

  @override
  ConsumerState<CallHistoryPageWithTimelineWithAds> createState() => _CallHistoryPageWithTimelineWithAdsState();
}

class _CallHistoryPageWithTimelineWithAdsState extends ConsumerState<CallHistoryPageWithTimelineWithAds> with TickerProviderStateMixin {
  // --- 状态变量 (无变化) ---
  bool _isLoading = true;
  String? _selectedLabel;
  late String _selectedTab;
  TabController? _tabController;
  late List<String> _tabs;
  ListDisplayMode _displayMode = ListDisplayMode.timeline;
  final Set<String> _selectedLogIds = {};
  bool _isMultiSelectMode = false;
  String _searchKeyword = '';
  List<CallLog> _currentLogs = [];
  
  // --- 所有逻辑函数 (无变化) ---
  
  @override
  void initState() {
    super.initState();
    _initializeCallLogs();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabs = [
      AppLocalizations.of(context)!.tabAll,
      AppLocalizations.of(context)!.tabAnswered,
      AppLocalizations.of(context)!.tabMissed,
      AppLocalizations.of(context)!.tabBlocked,
      AppLocalizations.of(context)!.tabOutgoing
    ];
    _selectedTab = _tabs.first;
    _tabController?.removeListener(_handleTabSelection);
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController!.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
  
  void _handleTabSelection() {
    if (_tabController != null && mounted && !_tabController!.indexIsChanging) {
      setState(() => _selectedTab = _tabs[_tabController!.index]);
    }
  }

  Future<void> _initializeCallLogs() async {
    if (mounted) setState(() => _isLoading = true);
    try {
      await ref.read(callLogServiceProvider).initialize();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.callHistoryInitFailed(e.toString()))));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _refreshCallLogs() async {
    if (_isMultiSelectMode) {
      if (mounted) {
        setState(() {
          _isMultiSelectMode = false;
          _selectedLogIds.clear();
        });
      }
    }
    if (mounted) setState(() => _isLoading = true);
    try {
      await ref.read(callLogServiceProvider).refresh();
    } catch (e) {
       if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.callHistoryRefreshFailed(e.toString()))));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _deleteSelectedLogs() async {
    final callLogService = ref.read(callLogServiceProvider);
    try {
      final List<CallLog> logsToDelete = _currentLogs
          .where((log) => _selectedLogIds.contains(log.id))
          .toList();

      // 调用 CallLogService 中新增的 deleteLogs 方法
      await callLogService.deleteLogs(logsToDelete);

      if (mounted) {
        setState(() {
          _selectedLogIds.clear();
          _isMultiSelectMode = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.deleteSuccess),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.deleteFailed(e.toString())),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
  
  void _clearLabelFilter() {
    if (mounted) setState(() => _selectedLabel = null);
  }

  void _toggleMultiSelectMode() {
    if (mounted) {
      setState(() {
        _isMultiSelectMode = !_isMultiSelectMode;
        if (!_isMultiSelectMode) _selectedLogIds.clear();
      });
    }
  }

  void _toggleItemSelection(String logId) {
    if (mounted) {
      setState(() {
        if (_selectedLogIds.contains(logId)) {
          _selectedLogIds.remove(logId);
        } else {
          _selectedLogIds.add(logId);
        }
      });
    }
  }

  List<CallLog> _filterLogs(List<CallLog> logs) {
    var filteredLogs = logs;
    
    if (_selectedLabel != null) {
      filteredLogs = filteredLogs.where((log) => log.labelIds?.contains(_selectedLabel) ?? false).toList();
    }
    
    final tabMap = {
      AppLocalizations.of(context)!.tabAnswered: 'incoming',
      AppLocalizations.of(context)!.tabMissed: 'missed',
      AppLocalizations.of(context)!.tabBlocked: 'blocked',
      AppLocalizations.of(context)!.tabOutgoing: 'outgoing'
    };
    if (_selectedTab != AppLocalizations.of(context)!.tabAll) {
      filteredLogs = filteredLogs.where((log) => log.callType == tabMap[_selectedTab]).toList();
    }
    
    if (_searchKeyword.isNotEmpty) {
      final keyword = _searchKeyword.toLowerCase();
      filteredLogs = filteredLogs.where((log) {
        final phoneNumber = log.phoneNumber.toLowerCase();
        final name = log.name?.toLowerCase() ?? '';
        return phoneNumber.contains(keyword) || name.contains(keyword);
      }).toList();
    }
    
    filteredLogs.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    
    return filteredLogs;
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
                if (mounted) {
                  setState(() {
                    _displayMode = _displayMode == ListDisplayMode.timeline ? ListDisplayMode.list : ListDisplayMode.timeline;
                  });
                }
              },
            ),
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
  
  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.clearAllCallLogs),
        content: Text(AppLocalizations.of(context)!.clearAllCallLogsConfirmation),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)!.cancelButton)),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final callLogService = ref.read(callLogServiceProvider);
              await callLogService.clearAllLogs();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(AppLocalizations.of(context)!.allCallLogsCleared),
                  backgroundColor: Colors.green,
                ));
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    );
  }

  void _showLabelFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.filterByLabel),
        content: SizedBox(
          width: double.maxFinite,
          child: PublicSelectLabel(
            initialLabelId: _selectedLabel,
            onLabelIdChanged: (labelId) {
              if (mounted) setState(() => _selectedLabel = labelId);
              Navigator.pop(context);
            },
            themeColor: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)!.cancelButton)),
          if (_selectedLabel != null)
            TextButton(
              onPressed: () {
                if (mounted) setState(() => _selectedLabel = null);
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.clearFilter),
            ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // 【核心修正】严格按照参考文件结构，返回一个带有 bottomNavigationBar 的 Scaffold
    return Scaffold(
      bottomNavigationBar: BottomNavigation(
        currentIndex: 1, // 通话记录页面在导航栏中的索引
        onTap: (index) => AppRouter.handleNavigation(context, index),
      ),
      body: StreamBuilder<List<CallLog>>(
        stream: ref.watch(callLogServiceProvider).logsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && _isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return _buildErrorView(snapshot.error.toString());
          }

          _currentLogs = snapshot.data ?? [];
          final filteredLogs = _filterLogs(_currentLogs);
          
          return GenericTimelineListWithAdsPage<CallLog>(
            title: AppLocalizations.of(context)!.callHistoryInfoTitle,
            themeColor: Colors.teal,
            items: filteredLogs,
            displayMode: _displayMode,
            getItemTimestamp: (log) => DateTime.fromMillisecondsSinceEpoch(log.timestamp.millisecondsSinceEpoch),
            itemBuilder: (context, log) => CallLogCard(log: log),
            adBuilder: () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
            isLoading: _isLoading && snapshot.connectionState == ConnectionState.waiting,
            emptyText: _selectedLabel != null || _searchKeyword.isNotEmpty || _selectedTab != _tabs.first
                ? AppLocalizations.of(context)!.noMatchingRecords
                : AppLocalizations.of(context)!.noCallRecords,
            onRefresh: _refreshCallLogs,
            headerContent: _buildHeaderContent(),
            searchHintText: AppLocalizations.of(context)!.searchHint,
            onSearchChanged: (keyword) => setState(() => _searchKeyword = keyword),
            isMultiSelectMode: _isMultiSelectMode,
            selectedItemIds: _selectedLogIds,
            getItemId: (log) => log.id,
            onToggleMultiSelectMode: _toggleMultiSelectMode,
            onToggleItemSelection: _toggleItemSelection,
            onDeleteSelected: _deleteSelectedLogs,
            onMoreOptions: _showMoreOptions,
            customActions: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: _showLabelFilterDialog,
                tooltip: AppLocalizations.of(context)!.filterByLabel,
              ),
            ],
          );
        },
      ),
    );
  }

  // --- 辅助UI函数 (无变化) ---
  
  Widget _buildHeaderContent() {
    final blockedCount = _currentLogs.where((log) => log.callType == 'blocked').length;
    final answeredCount = _currentLogs.where((log) => log.callType == 'incoming').length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.count(
          crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 2.0,
          children: [
            _buildStatCard(AppLocalizations.of(context)!.statBlocked, blockedCount.toString(), Colors.red),
            _buildStatCard(AppLocalizations.of(context)!.statAnswered, answeredCount.toString(), Colors.green),
          ],
        ),
        const SizedBox(height: 16),
        TabBar(
          controller: _tabController, 
          isScrollable: true,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
        ),
        if (_selectedLabel != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: LabelFilterChip(labelId: _selectedLabel!, onDeleted: _clearLabelFilter),
          ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              AppLocalizations.of(context)!.dataLoadFailure(errorMessage),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _refreshCallLogs, child: Text(AppLocalizations.of(context)!.retry)),
        ],
      ),
    );
  }
}