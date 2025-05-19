import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/call_log_card.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/label_filter_chip.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';

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
  String _selectedTab = '全部';
  late TabController _tabController;
  
  final List<String> _tabs = ['全部', '已接通', '未接来电', '已拦截', '已拨出'];
  
  @override
  void initState() {
    super.initState();
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
        SnackBar(content: Text('初始化通话记录失败: $e')),
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
        SnackBar(content: Text('刷新通话记录失败: $e')),
      );
      setState(() {
        _isLoading = false;
      });
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
        title: const Text('通话记录'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showLabelFilterDialog(),
            tooltip: '标签筛选',
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {}, // 搜索功能待实现
            tooltip: '搜索',
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
                : _buildCallLogsContent(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCallLogsContent() {
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
                    Text('加载失败: ${snapshot.error}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _refreshCallLogs,
                      child: const Text('重试'),
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
                  case '已接通':
                    return log.callType == 'incoming';
                  case '未接来电':
                    return log.callType == 'missed';
                  case '已拦截':
                    return log.callType == 'blocked';
                  case '已拨出':
                    return log.callType == 'outgoing';
                  default:
                    return true;
                }
              }).toList();
            }
            
            if (logs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.call, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      _selectedTab != '全部' || _selectedLabel != null ? '没有匹配的通话记录' : '暂无通话记录', 
                      style: const TextStyle(fontSize: 18, color: Colors.grey)
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.refresh),
                      label: const Text('刷新'),
                      onPressed: _refreshCallLogs,
                    ),
                    if (_selectedLabel != null)
                      TextButton(
                        onPressed: _clearLabelFilter,
                        child: const Text('清除标签筛选'),
                      ),
                  ],
                ),
              );
            }
            
            // 计算统计数据
            final blockedCount = logs.where((log) => log.callType == 'blocked').length;
            final answeredCount = logs.where((log) => log.callType == 'incoming').length;
            
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 统计卡片
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 2.5,
                      children: [
                        _buildStatCard('已拦截', blockedCount.toString(), Colors.red),
                        _buildStatCard('已接通', answeredCount.toString(), Colors.green),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // 时间轴布局
                    _buildTimelineLayout(logs),
                    
                    // 加载更多按钮
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: TextButton.icon(
                          icon: const Icon(Icons.expand_more),
                          label: const Text('加载更多'),
                          onPressed: () {}, // 加载更多功能待实现
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
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
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTimelineLayout(List<CallLog> logs) {
    // 按日期分组
    final Map<String, List<CallLog>> groupedLogs = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    
    for (final log in logs) {
      final logDate = DateTime.fromMillisecondsSinceEpoch(log.timestamp.millisecondsSinceEpoch);
      final logDay = DateTime(logDate.year, logDate.month, logDate.day);
      
      String groupKey;
      if (logDay == today) {
        groupKey = '今天';
      } else if (logDay == yesterday) {
        groupKey = '昨天';
      } else {
        groupKey = '更早';
      }
      
      if (!groupedLogs.containsKey(groupKey)) {
        groupedLogs[groupKey] = [];
      }
      groupedLogs[groupKey]!.add(log);
    }
    
    // 按日期分组显示
    final List<Widget> timelineGroups = [];
    
    // 排序日期组：今天、昨天、更早
    final sortedKeys = groupedLogs.keys.toList()
      ..sort((a, b) {
        final order = {'今天': 0, '昨天': 1, '更早': 2};
        return order[a]!.compareTo(order[b]!);
      });
    
    for (final groupKey in sortedKeys) {
      final groupLogs = groupedLogs[groupKey]!;
      
      timelineGroups.add(
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Text(
            groupKey,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ),
      );
      
      for (final log in groupLogs) {
        timelineGroups.add(_buildTimelineItem(log));
      }
    }
    
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Stack(
        children: [
          // 时间轴线
          Positioned(
            left: 4,
            top: 0,
            bottom: 0,
            width: 2,
            child: Container(color: Colors.grey[300]),
          ),
          // 时间轴内容
          Column(children: timelineGroups),
        ],
      ),
    );
  }
  
  Widget _buildTimelineItem(CallLog log) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(log.timestamp.millisecondsSinceEpoch);
    final timeFormat = DateFormat('HH:mm');
    final timeString = timeFormat.format(dateTime);
    
    // 根据通话类型设置不同的图标和颜色
    IconData callIcon;
    Color iconColor;
    String callTypeText;
    
    switch (log.callType) {
      case 'incoming':
        callIcon = Icons.phone;
        iconColor = Colors.green;
        callTypeText = '已接通';
        break;
      case 'outgoing':
        callIcon = Icons.call_made;
        iconColor = Colors.blue;
        callTypeText = '已拨出';
        break;
      case 'missed':
        callIcon = Icons.phone_missed;
        iconColor = Colors.orange;
        callTypeText = '未接来电';
        break;
      case 'blocked':
        callIcon = Icons.block;
        iconColor = Colors.red;
        callTypeText = '已拦截';
        break;
      default:
        callIcon = Icons.phone;
        iconColor = Colors.grey;
        callTypeText = '未知';
    }
    
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 时间轴节点
          Positioned(
            left: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // 通话记录卡片
          Expanded(
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 图标
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: iconColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(callIcon, color: iconColor),
                    ),
                    const SizedBox(width: 16),
                    // 联系人信息
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            log.number,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            timeString,
                            style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                          ),
                          Text(
                            '${log.simDisplayName} (${log.carrierName})',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    // 通话类型和操作按钮
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          callTypeText,
                          style: TextStyle(fontSize: 14, color: iconColor),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.info_outline, size: 20),
                              color: Colors.grey,
                              onPressed: () {}, // 查看详情功能待实现
                            ),
                            IconButton(
                              icon: Icon(
                                log.callType == 'blocked' ? Icons.block : Icons.phone,
                                size: 20,
                              ),
                              color: Colors.grey,
                              onPressed: () {}, // 拦截或拨打功能待实现
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLabelFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('按标签筛选'),
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
            child: const Text('取消'),
          ),
          if (_selectedLabel != null)
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedLabel = null;
                });
                Navigator.pop(context);
              },
              child: const Text('清除筛选'),
            ),
        ],
      ),
    );
  }
}