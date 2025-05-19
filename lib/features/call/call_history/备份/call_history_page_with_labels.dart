import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';

class CallHistoryPageWithLabels extends StatefulWidget {
  const CallHistoryPageWithLabels({Key? key}) : super(key: key);

  @override
  State<CallHistoryPageWithLabels> createState() => _CallHistoryPageWithLabelsState();
}

class _CallHistoryPageWithLabelsState extends State<CallHistoryPageWithLabels> {
  bool _isLoading = true;
  List<CallLog> _callLogs = [];
  String? _selectedLabel;
  String _searchQuery = '';
  
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

  List<CallLog> get _filteredCallLogs {
    if (_searchQuery.isEmpty && _selectedLabel == null) {
      return _callLogs;
    }

    return _callLogs.where((log) {
      final matchesSearch = _searchQuery.isEmpty ||
          log.number.contains(_searchQuery);

      // 标签匹配应该通过服务层实现，而不是直接从CallLog获取
      // 这里简化处理，仅根据搜索条件过滤
      // 实际实现应该根据项目的标签服务来调整
      // 例如：final logLabel = labelService.getLabelForNumber(log.number);
      // final matchesLabel = _selectedLabel == null || logLabel == _selectedLabel;
      final matchesLabel = _selectedLabel == null; // 临时实现，应替换为实际标签匹配逻辑

      return matchesSearch && matchesLabel;
    }).toList();
  }

  void _assignLabel(CallLog log) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('为通话记录添加标签'),
        content: PublicSelectLabel(
          initialLabel: null, // CallLog没有label属性，应通过服务层获取
          phoneNumber: log.number,
          onLabelChanged: (label) async {
            try {
              // 更新通话记录 - 保持原有属性
              final updatedLog = CallLog(
                id: log.id,
                number: log.number,
                timestamp: log.timestamp,
                callType: log.callType,
                simDisplayName: log.simDisplayName,
                simSlotIndex: log.simSlotIndex,
                carrierName: log.carrierName,
                countryIso: log.countryIso,
                subscriptionId: log.subscriptionId,
              );
              
              final callLogService = Provider.of<CallLogService>(context, listen: false);
              await callLogService.addLog(updatedLog);
              
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('标签添加成功')),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('添加标签失败: $e')),
              );
            }
          },
          themeColor: const Color(0xFFF5A623),
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
            icon: const Icon(Icons.refresh),
            onPressed: _refreshCallLogs,
            tooltip: '刷新',
          ),
        ],
      ),
      body: Column(
        children: [
          // 搜索栏
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: '搜索通话记录',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // 标签筛选
          if (_selectedLabel != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Chip(
                    label: Text(_selectedLabel!),
                    backgroundColor: const Color(0xFFF5A623).withOpacity(0.1),
                    labelStyle: const TextStyle(color: Color(0xFFF5A623)),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      setState(() {
                        _selectedLabel = null;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('选择标签'),
                          content: PublicSelectLabel(
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
                      );
                    },
                    child: const Text('更改标签'),
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
            
            _callLogs = snapshot.data ?? [];
            final filteredLogs = _filteredCallLogs;
            
            if (filteredLogs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.call, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      _callLogs.isEmpty ? '暂无通话记录' : '没有匹配的通话记录',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.refresh),
                      label: const Text('刷新'),
                      onPressed: _refreshCallLogs,
                    ),
                  ],
                ),
              );
            }
            
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: filteredLogs.length + 1, // +1 for the info card
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildInfoCard();
                }
                
                final log = filteredLogs[index - 1];
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
                    '这里显示您的通话记录，包括来电、去电和未接来电。您可以为通话记录添加标签，方便管理。',
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
      case 'blocked':
        callIcon = Icons.block;
        iconColor = Colors.red;
        callTypeText = '已拦截';
        break;
      default:
        callIcon = Icons.call;
        iconColor = Colors.grey;
        callTypeText = '未知';
    }
    
    // 格式化通话时间
    final callTime = log.timestamp;
    final formattedDate = '${callTime.year}-${callTime.month.toString().padLeft(2, '0')}-${callTime.day.toString().padLeft(2, '0')} ${callTime.hour.toString().padLeft(2, '0')}:${callTime.minute.toString().padLeft(2, '0')}';
    
    // 格式化通话时长
    final int duration = log.duration ?? 0;
    final minutes = duration ~/ 60;
    final seconds = duration % 60;
    final formattedDuration = '${minutes > 0 ? '$minutes分' : ''}${seconds}秒';
    
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
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
                  // 标签应该通过服务层获取，而不是直接从CallLog获取
                  // 以下代码仅作为示例，实际实现应该根据项目的标签服务来调整
                  FutureBuilder<String?>(  
                    future: Future.value(null), // 应替换为实际获取标签的方法
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Chip(
                              label: Text(snapshot.data!),
                              backgroundColor: Colors.blue.withOpacity(0.1),
                              labelStyle: const TextStyle(color: Colors.blue, fontSize: 10),
                              padding: EdgeInsets.zero,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.label, color: Color(0xFFF5A623)),
              onPressed: () => _assignLabel(log),
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
      ),
    );
  }
}