import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/label_dialog.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/rule_action_dialog.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通话记录时间轴视图组件
/// 展示带有时间轴布局的通话记录列表
class CallTimelineView extends StatelessWidget {
  final List<CallLog> logs;
  final Function() onRefresh;
  final Function()? onClearFilter;
  final String? selectedLabel;
  final String selectedTab;
  
  const CallTimelineView({
    super.key,
    required this.logs,
    required this.onRefresh,
    this.onClearFilter,
    this.selectedLabel,
    required this.selectedTab,
  });

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.call, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              selectedTab != AppLocalizations.of(context)!.tabAll || selectedLabel != null ? 
                AppLocalizations.of(context)!.noMatchingRecords : 
                AppLocalizations.of(context)!.noCallRecords, 
              style: const TextStyle(fontSize: 18, color: Colors.grey)
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: Text(AppLocalizations.of(context)!.refresh),
              onPressed: onRefresh,
            ),
            if (selectedLabel != null)
              TextButton(
                onPressed: onClearFilter,
                child: Text(AppLocalizations.of(context)!.clearLabelFilter),
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
                _buildStatCard(context, AppLocalizations.of(context)!.statBlocked, blockedCount.toString(), Colors.red),
                _buildStatCard(context, AppLocalizations.of(context)!.statAnswered, answeredCount.toString(), Colors.green),
              ],
            ),
            const SizedBox(height: 24),
            
            // 时间轴布局
            _buildTimelineLayout(context, logs),
            
            // 加载更多按钮
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: TextButton.icon(
                  icon: const Icon(Icons.expand_more),
                  label: Text(AppLocalizations.of(context)!.loadMore),
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
  }
  
  Widget _buildStatCard(BuildContext context, String title, String value, Color color) {
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
  
  Widget _buildTimelineLayout(BuildContext context, List<CallLog> logs) {
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
        groupKey = AppLocalizations.of(context)!.today;
      } else if (logDay == yesterday) {
        groupKey = AppLocalizations.of(context)!.yesterday;
      } else {
        groupKey = AppLocalizations.of(context)!.earlier;
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
        final order = {AppLocalizations.of(context)!.today: 0, AppLocalizations.of(context)!.yesterday: 1, AppLocalizations.of(context)!.earlier: 2};
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
        timelineGroups.add(_buildTimelineItem(context, log));
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
  
  Widget _buildTimelineItem(BuildContext context, CallLog log) {
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
        callTypeText = AppLocalizations.of(context)!.callTypeAnswered;
        break;
      case 'outgoing':
        callIcon = Icons.call_made;
        iconColor = Colors.blue;
        callTypeText = AppLocalizations.of(context)!.callTypeOutgoing;
        break;
      case 'missed':
        callIcon = Icons.phone_missed;
        iconColor = Colors.orange;
        callTypeText = AppLocalizations.of(context)!.callTypeMissed;
        break;
      case 'blocked':
        callIcon = Icons.block;
        iconColor = Colors.red;
        callTypeText = AppLocalizations.of(context)!.callTypeBlocked;
        break;
      default:
        callIcon = Icons.phone;
        iconColor = Colors.grey;
        callTypeText = AppLocalizations.of(context)!.callTypeUnknown;
    }
    
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 时间轴节点
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
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
                        color: iconColor.withValues(alpha:0.1),
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
                            log.name ?? log.phoneNumber,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            log.phoneNumber, // 始终显示电话号码
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
                              icon: const Icon(Icons.label_outline, size: 20),
                              color: Colors.grey,
                              onPressed: () => _showLabelSelectionDialog(context, log), // 添加标签功能
                            ),
                            IconButton(
                              icon: Icon(
                                log.callType == 'blocked' ? Icons.block : Icons.phone,
                                size: 20,
                              ),
                              color: Colors.grey,
                              onPressed: () {}, // 拦截或拨打功能待实现
                            ),
                            // 添加规则开关按钮
                            IconButton(
                              icon: const Icon(Icons.rule, size: 20),
                              color: Colors.grey,
                              onPressed: () => _showRuleActionDialog(context, log), // 显示规则操作对话框
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

  // 显示标签选择对话框
  void _showLabelSelectionDialog(BuildContext context, CallLog log) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => LabelDialog(
        log: log,
        onLabelUpdated: () {
          // 标签更新后刷新列表
          onRefresh();
        },
      ),
    );
  }

  // 显示规则操作对话框
  void _showRuleActionDialog(BuildContext context, CallLog log) {
    showDialog(
      context: context,
      builder: (context) => RuleActionDialog(log: log),
    );
  }
}