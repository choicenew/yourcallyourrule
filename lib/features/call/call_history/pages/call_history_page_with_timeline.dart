import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/call_logs_list.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/call_timeline_view.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/label_filter_chip.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/services/label_to_remote_sync_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 带时间轴布局的通话记录页面
/// 参考HTML UI设计实现，包含统计卡片和时间轴布局
class CallHistoryPageWithTimeline extends StatefulWidget {
  const CallHistoryPageWithTimeline({super.key});

  @override
  State<CallHistoryPageWithTimeline> createState() => _CallHistoryPageWithTimelineState();
}

class _CallHistoryPageWithTimelineState extends State<CallHistoryPageWithTimeline> with SingleTickerProviderStateMixin {
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
      final callLogService = Provider.of<CallLogService>(context, listen: false);
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
      final callLogService = Provider.of<CallLogService>(context, listen: false);
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
      final callLogService = Provider.of<CallLogService>(context, listen: false);
      final labelToRemoteSyncService = Provider.of<LabelToRemoteSyncService>(context, listen: false);
      
      // 添加标签到通话记录
      await callLogService.addLabelToLog(log, labelId);
      
      // 同步标签信息到远程号码服务
      final phoneNumber = PhoneNumber.fromString(log.number);
      await labelToRemoteSyncService.syncLabelByPhoneNumber(phoneNumber);
      
      // 刷新通话记录列表
      await _refreshCallLogs();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('添加标签失败: ${e.toString()}')),
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
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.callHistoryInfoTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
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
        ],
      ),
      body: Column(
        children: [
          // 标签页
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Theme.of(context).primaryColor,
          ),
          
          // 显示当前筛选的标签
          if (_selectedLabel != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: LabelFilterChip(
                labelId: _selectedLabel!,
                onDeleted: _clearLabelFilter,
              ),
            ),
            
          // 主内容区
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _showTimelineView ? _buildTimelineContent() : _buildListContent(),
          ),
        ],
      ),
    );
  }
  
  // 列表视图内容
  Widget _buildListContent() {
    return CallLogsList(
      selectedLabel: _selectedLabel,
      onRefresh: _refreshCallLogs,
      onClearFilter: _selectedLabel != null ? _clearLabelFilter : null,
    );
  }
  
  // 时间轴视图内容
  Widget _buildTimelineContent() {
    return Consumer<CallLogService>(
      builder: (context, callLogService, child) {
        return StreamBuilder<List<CallLog>>(
          stream: callLogService.logsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.dataLoadFailure(snapshot.error.toString())),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _refreshCallLogs,
                      child: Text(AppLocalizations.of(context)!.retry),
                    ),
                  ],
                ),
              );
            }
            
            var logs = snapshot.data ?? [];
            
            // 根据标签筛选
            if (_selectedLabel != null) {
              logs = logs.where((log) => log.labelIds?.contains(_selectedLabel) ?? false).toList();
            }
            
            // 根据标签页筛选
            if (_selectedTab != '全部') {
              logs = logs.where((log) {
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
            
            return CallTimelineView(
              logs: logs,
              onRefresh: _refreshCallLogs,
              onClearFilter: _selectedLabel != null ? _clearLabelFilter : null,
              selectedLabel: _selectedLabel,
              selectedTab: _selectedTab,
            );
          },
        );
      },
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
              setState(() {
                _selectedLabel = labelId;
              });
              Navigator.pop(context);
            },
            themeColor: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          if (_selectedLabel != null)
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedLabel = null;
                });
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.clearFilter),
            ),
        ],
      ),
    );
  }
}