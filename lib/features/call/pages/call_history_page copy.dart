import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/label/label_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/call/services/call_log_service.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';

class CallHistoryPage extends StatefulWidget {
  const CallHistoryPage({Key? key}) : super(key: key);

  @override
  State<CallHistoryPage> createState() => _CallHistoryPageState();
}

class _CallHistoryPageState extends State<CallHistoryPage> {
  bool _isLoading = true;
  List<CallLog> _callLogs = [];
  String? _selectedLabel;
  
  @override
  void initState() {
    super.initState();
    _initializeCallLogs();
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
            icon: const Icon(Icons.refresh),
            onPressed: _refreshCallLogs,
            tooltip: '刷新',
          ),
        ],
      ),
      body: Column(
        children: [
          // 显示当前筛选的标签
          if (_selectedLabel != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chip(
                    label: Text('标签: $_selectedLabel'),
                    backgroundColor: const Color(0xFFF5A623).withOpacity(0.1),
                    labelStyle: const TextStyle(color: Color(0xFFF5A623)),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      setState(() {
                        _selectedLabel = null;
                      });
                    },
                  ),
                ],
              ),
            ),
          // 通话记录列表
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildCallLogsList(),
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
            initialLabel: _selectedLabel,
            onLabelChanged: (label) {
              setState(() {
                _selectedLabel = label;
              });
              Navigator.pop(context);
            },
            themeColor: const Color(0xFFF5A623),
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

  Widget _buildCallLogsList() {
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
            
            if (logs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.call, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      _selectedLabel != null ? '没有匹配的通话记录' : '暂无通话记录', 
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
                        onPressed: () {
                          setState(() {
                            _selectedLabel = null;
                          });
                        },
                        child: const Text('清除标签筛选'),
                      ),
                  ],
                ),
              );
            }
            
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: logs.length + 1, // +1 for the info card
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildInfoCard();
                }
                
                final log = logs[index - 1];
                return _buildCallLogCard(log);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.blue, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '通话记录',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '这里显示您的通话记录，包括来电、去电和未接来电。',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallLogCard(CallLog log) {
    // 根据通话类型设置不同的图标和颜色
    IconData callIcon;
    Color iconColor;
    String callTypeText;
    
    switch (log.callType) {
      case 'incoming':
        callIcon = Icons.call_received;
        iconColor = Colors.green;
        callTypeText = '来电';
        break;
      case 'outgoing':
        callIcon = Icons.call_made;
        iconColor = Colors.blue;
        callTypeText = '去电';
        break;
      case 'missed':
        callIcon = Icons.call_missed;
        iconColor = Colors.red;
        callTypeText = '未接';
        break;
      default:
        callIcon = Icons.call;
        iconColor = Colors.grey;
        callTypeText = '未知';
    }
    
    // 格式化通话时间
    final callTime = log.timestamp;
    final formattedDate = '${callTime.year}-${callTime.month.toString().padLeft(2, '0')}-${callTime.day.toString().padLeft(2, '0')} ${callTime.hour.toString().padLeft(2, '0')}:${callTime.minute.toString().padLeft(2, '0')}';
    
    // 格式化通话时长 - 由于CallLog实体中没有duration字段，这里使用默认值
    // 实际应用中应该从CallLog中获取duration
    final int duration = 0; // 默认值，实际应用中应该从CallLog中获取
    final minutes = duration ~/ 60;
    final seconds = duration % 60;
    final formattedDuration = '${minutes > 0 ? '$minutes分' : ''}${seconds}秒';
    
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(callIcon, color: iconColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            log.number,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: iconColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              callTypeText,
                              style: TextStyle(fontSize: 12, color: iconColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formattedDate,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          if (duration > 0)
                            Text(
                              '通话时长: $formattedDuration',
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.label_outline),
                      onPressed: () => _showLabelDialog(log),
                      tooltip: '添加标签',
                    ),
                    IconButton(
                      icon: const Icon(Icons.call, color: Colors.green),
                      onPressed: () {
                        // 回拨电话
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('回拨 ${log.number}')),
                        );
                      },
                      tooltip: '回拨',
                    ),
                  ],
                ),
              ],
            ),
            // 使用标签服务获取标签信息
            if (log.labelIds != null && log.labelIds!.isNotEmpty)
              FutureBuilder<List<LabelEntry>>(
                future: Provider.of<LabelService>(context, listen: false).getAllLabels(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 64.0),
                      child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                    );
                  }
                  
                  if (snapshot.hasData) {
                    // 查找匹配的标签
                    final matchingLabels = snapshot.data!.where(
                      (label) => log.labelIds!.contains(label.id)
                    ).toList();
                    
                    if (matchingLabels.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 64.0),
                        child: Wrap(
                          spacing: 8,
                          children: matchingLabels.map((label) => Chip(
                            label: Text(label.label),
                            backgroundColor: const Color(0xFFF5A623).withOpacity(0.1),
                            labelStyle: const TextStyle(color: Color(0xFFF5A623)),
                          )).toList(),
                        ),
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
          ],
        ),
      ),
    );
  }
  
  void _showLabelDialog(CallLog log) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('为通话记录添加标签'),
        content: SizedBox(
          width: double.maxFinite,
          child: PublicSelectLabel(
            initialLabel: log.labelIds?.isNotEmpty == true ? log.labelIds!.first : null,
            phoneNumber: log.number,
            onLabelChanged: (label) async {
              try {
                // 获取标签服务和通话记录服务
                final callLogService = Provider.of<CallLogService>(context, listen: false);
                final labelService = Provider.of<LabelService>(context, listen: false);
                
                // 获取所有标签
                final labels = await labelService.getLabelsByText(label);
                if (labels.isNotEmpty) {
                  // 使用第一个匹配的标签ID
                  final labelId = labels.first.id;
                  
                  // 为通话记录添加标签
                  await callLogService.addLabelToLog(log, labelId);
                  
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('标签已更新')),
                    );
                  }
                } else {
                  // 如果没有找到匹配的标签，创建一个新标签
                  final uniqueId = DateTime.now().millisecondsSinceEpoch.toString() + label.hashCode.toString();
                  final phoneNumber = PhoneNumber.fromString(log.number);
                  final newLabel = LabelEntry(
                    id: uniqueId,
                    phoneNumber: phoneNumber,
                    label: label,
                    icon: Icons.label.codePoint.toString(),
                  );
                  
                  // 保存新标签
                  await labelService.addLabel(newLabel);
                  
                  // 为通话记录添加标签
                  await callLogService.addLabelToLog(log, uniqueId);
                  
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('新标签已创建并关联到通话记录')),
                    );
                  }
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('更新标签失败: $e')),
                  );
                }
              }
            },
            themeColor: const Color(0xFFF5A623),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }
}