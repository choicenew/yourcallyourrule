import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/label_to_remote_sync_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/call_logs_list.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/call_timeline_view.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/label_filter_chip.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/ads/ad_control_service.dart';

/// 带时间轴布局的通话记录页面 - 集成广告功能
/// 参考HTML UI设计实现，包含统计卡片和时间轴布局
class CallHistoryPageWithTimelineWithAds extends ConsumerStatefulWidget {
  const CallHistoryPageWithTimelineWithAds({super.key});

  @override
  ConsumerState<CallHistoryPageWithTimelineWithAds> createState() => _CallHistoryPageWithTimelineWithAdsState();
}

class _CallHistoryPageWithTimelineWithAdsState extends ConsumerState<CallHistoryPageWithTimelineWithAds> with TickerProviderStateMixin {
  bool _isLoading = true;
  String? _selectedLabel;
  late String _selectedTab;
  TabController? _tabController;
  late List<String> _tabs;
  bool _showTimelineView = true; // 控制是否显示时间轴视图
  
  @override
  void initState() {
    super.initState();
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
    
    // 处理旧的 TabController
    if (_tabController != null) {
      _tabController!.removeListener(_handleTabSelection);
      _tabController!.dispose();
    }
    
    // 创建新的 TabController
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController!.addListener(_handleTabSelection);
  }
  
  // TabController 监听器回调
  void _handleTabSelection() {
    if (_tabController != null && !_tabController!.indexIsChanging) {
      setState(() {
        _selectedTab = _tabs[_tabController!.index];
      });
    }
  }
  
  @override
  void dispose() {
    if (_tabController != null) {
      _tabController!.dispose();
    }
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
      final phoneNumber = PhoneNumber.fromString(log.number);
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
    final callLogService = ref.watch(callLogServiceProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavigation(
        currentIndex: 1, // 通话记录页面标签索引
        onTap: (index) => AppRouter.handleNavigation(context, index),
      ),
      body: StreamBuilder<List<CallLog>>(
        stream: callLogService.logsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && _isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
        
        var logs = snapshot.data ?? [];
        
        // 根据标签筛选
        if (_selectedLabel != null) {
          logs = logs.where((log) => log.labelIds?.contains(_selectedLabel) ?? false).toList();
        }
        
        // 根据标签页筛选
        if (_selectedTab != _tabs[0]) {
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
        
        // 使用GenericListWithAdsPage显示内容
        return GenericListWithAdsPage<CallLog>(
          title: AppLocalizations.of(context)!.callHistoryInfoTitle,
          items: logs,
          itemBuilder: (context, log) {
            // 根据视图模式返回不同的显示组件
            if (_showTimelineView) {
              return CallTimelineView(
                logs: [log],
                onRefresh: _refreshCallLogs,
                onClearFilter: _selectedLabel != null ? _clearLabelFilter : null,
                selectedLabel: _selectedLabel,
                selectedTab: _selectedTab,
              );
            } else {
              return CallLogsList(
                selectedLabel: _selectedLabel,
                onRefresh: _refreshCallLogs,
                onClearFilter: _selectedLabel != null ? _clearLabelFilter : null,
              );
            }
          },
          adBuilder: () => const Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('广告位', textAlign: TextAlign.center),
            ),
          ),
          adInterval: 5,
          emptyText: AppLocalizations.of(context)!.noCallLogs,
          emptyIcon: Icons.call_missed,
          themeColor: Theme.of(context).primaryColor,
          isLoading: _isLoading,
          onRefresh: _refreshCallLogs,
          headerContent: Column(
            children: [
              // 标签页
              TabBar(
                controller: _tabController!,
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
                
              // 视图切换按钮
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(_showTimelineView ? Icons.view_list : Icons.timeline),
                      onPressed: () {
                        setState(() {
                          _showTimelineView = !_showTimelineView;
                        });
                      },
                      tooltip: _showTimelineView ? 'List View' : 'Timeline View',
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
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
        );
        },
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
            child: Text(AppLocalizations.of(context)!.cancelButton),
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