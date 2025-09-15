import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/label_to_remote_sync_service_provider.dart.bak';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/call_logs_list.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/call_timeline_view.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/label_filter_chip.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 带时间轴布局的通话记录页面
/// 参考HTML UI设计实现，包含统计卡片和时间轴布局
class CallHistoryPageWithTimeline extends ConsumerStatefulWidget {
  const CallHistoryPageWithTimeline({super.key});

  @override
  ConsumerState<CallHistoryPageWithTimeline> createState() => _CallHistoryPageWithTimelineState();
}

class _CallHistoryPageWithTimelineState extends ConsumerState<CallHistoryPageWithTimeline> with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  String? _selectedLabel;
  late String _selectedTab;
  late TabController _tabController;
  late List<String> _tabs;
  bool _showTimelineView = true; // 控制是否显示时间轴视图
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTab = _tabs[_tabController.index];
        });
      }
    });
    _initializeCallLogs();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    _tabs = [
      l10n.tabAll,
      l10n.tabAnswered,
      l10n.tabMissed,
      l10n.tabBlocked,
      l10n.tabOutgoing
    ];
    _selectedTab = _tabs[0];
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTab = _tabs[_tabController.index];
        });
      }
    });
    _initializeCallLogs();
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _initializeCallLogs() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final callLogService = ref.read(callLogServiceProvider);
      await callLogService.initialize();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.callHistoryInitFailed(e.toString()))),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshCallLogs() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final callLogService = ref.read(callLogServiceProvider);
      await callLogService.refresh();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.callHistoryRefreshFailed(e.toString()))),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  /// 为通话记录添加标签并同步到远程号码服务
  Future<void> _addLabelToLogAndSync(CallLog log, String labelId) async {
    try {
      final callLogService = ref.read(callLogServiceProvider);
      final labelToRemoteSyncService = ref.read(labelToRemoteSyncServiceProvider);
      
      // 添加标签到通话记录
      await callLogService.addLabelToLog(log, labelId);
      
      // 同步标签信息到远程号码服务
      final phoneNumber = PhoneNumber.fromString(log.phoneNumber);
      await labelToRemoteSyncService.syncLabelByPhoneNumber(phoneNumber);
      
      // 刷新通话记录列表
      await _refreshCallLogs();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('AppLocalizations.of(context)!.addLabelFailed: ${e.toString()}')),
      );
    }
  }

  void _clearLabelFilter() {
    setState(() {
      _selectedLabel = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
  
  /// 构建应用栏
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.callHistoryInfoTitle),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: _buildActions(),
    );
  }
  
  /// 构建操作按钮列表
  List<Widget> _buildActions() {
    return [
      // 添加视图切换按钮
      IconButton(
        icon: Icon(_showTimelineView ? Icons.view_list : Icons.timeline),
        onPressed: () {
          setState(() {
            _showTimelineView = !_showTimelineView;
          });
        },
        tooltip: _showTimelineView ? 'List View' : 'Timeline View',
      ),
      IconButton(
        icon: const Icon(Icons.filter_list),
        onPressed: () => _showLabelFilterDialog(),
        tooltip: AppLocalizations.of(context)!.labelFilter,
      ),
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {}, // 搜索功能待实现
        tooltip: AppLocalizations.of(context)!.search,
      ),
    ];
  }
  
  /// 构建主体内容
  Widget _buildBody() {
    return Column(
      children: [
        _buildTabBar(),
        _buildLabelFilterChip(),
        _buildMainContent(),
      ],
    );
  }
  
  /// 构建标签页
  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
      labelColor: Theme.of(context).primaryColor,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Theme.of(context).primaryColor,
    );
  }
  
  /// 构建标签筛选芯片
  Widget _buildLabelFilterChip() {
    if (_selectedLabel == null) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: LabelFilterChip(
        labelId: _selectedLabel!,
        onDeleted: _clearLabelFilter,
      ),
    );
  }
  
  /// 构建主要内容区域
  Widget _buildMainContent() {
    return Expanded(
      child: _isLoading
          ? _buildLoadingIndicator()
          : _showTimelineView ? _buildTimelineContent() : _buildListContent(),
    );
  }
  
  /// 构建加载指示器
  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }
  
  /// 构建列表视图内容
  Widget _buildListContent() {
    return CallLogsList(
      selectedLabel: _selectedLabel,
      onRefresh: _refreshCallLogs,
      onClearFilter: _selectedLabel != null ? _clearLabelFilter : null,
    );
  }
  
  /// 构建时间轴视图内容
  Widget _buildTimelineContent() {
    final callLogService = ref.watch(callLogServiceProvider);
    return StreamBuilder<List<CallLog>>(
      stream: callLogService.logsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        }
        
        if (snapshot.hasError) {
          return _buildErrorView(snapshot.error);
        }
        
        var logs = snapshot.data ?? [];
        logs = _filterLogs(logs);
        
        return _buildTimelineView(logs);
      },
    );
  }
  
  /// 构建错误视图
  Widget _buildErrorView(Object? error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(AppLocalizations.of(context)!.dataLoadFailure(error.toString())),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _refreshCallLogs,
            child: Text(AppLocalizations.of(context)!.retry),
          ),
        ],
      ),
    );
  }
  
  /// 根据筛选条件过滤通话记录
  List<CallLog> _filterLogs(List<CallLog> logs) {
    var filteredLogs = logs;
    
    // 根据标签筛选
    if (_selectedLabel != null) {
      filteredLogs = filteredLogs.where((log) => 
        log.labelIds?.contains(_selectedLabel) ?? false
      ).toList();
    }
    
    // 根据标签页筛选
    if (_selectedTab != 'All') {
      filteredLogs = filteredLogs.where((log) {
        switch (_selectedTab) {
          case 'Answered':
            return log.callType == 'incoming';
          case 'Missed':
            return log.callType == 'missed';
          case 'Blocked':
            return log.callType == 'blocked';
          case 'Outgoing':
            return log.callType == 'outgoing';
          default:
            return true;
        }
      }).toList();
    }
    
    return filteredLogs;
  }
  
  /// 构建时间轴视图
  Widget _buildTimelineView(List<CallLog> logs) {
    return CallTimelineView(
      logs: logs,
      onRefresh: _refreshCallLogs,
      onClearFilter: _selectedLabel != null ? _clearLabelFilter : null,
      selectedLabel: _selectedLabel,
      selectedTab: _selectedTab,
    );
  }
    
  

  /// 显示标签筛选对话框
  void _showLabelFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.filterByLabel),
        content: _buildLabelSelectorContent(),
        actions: _buildLabelDialogActions(context),
      ),
    );
  }
  
  /// 构建标签选择器内容
  Widget _buildLabelSelectorContent() {
    return SizedBox(
      width: double.maxFinite,
      child: PublicSelectLabel(
        initialLabelId: _selectedLabel,
        onLabelIdChanged: _onLabelSelected,
        themeColor: Theme.of(context).primaryColor,
      ),
    );
  }
  
  /// 处理标签选择
  void _onLabelSelected(String labelId) {
    setState(() {
      _selectedLabel = labelId;
    });
    Navigator.pop(context);
  }
  
  /// 构建标签对话框操作按钮
  List<Widget> _buildLabelDialogActions(BuildContext context) {
    final actions = <Widget>[
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(AppLocalizations.of(context)!.cancelButton),
      ),
    ];
    
    if (_selectedLabel != null) {
      actions.add(
        TextButton(
          onPressed: _onClearLabelAndClose,
          child: Text(AppLocalizations.of(context)!.clearFilter),
        ),
      );
    }
    
    return actions;
  }
  
  /// 清除标签并关闭对话框
  void _onClearLabelAndClose() {
    setState(() {
      _selectedLabel = null;
    });
    Navigator.pop(context);
  }
}