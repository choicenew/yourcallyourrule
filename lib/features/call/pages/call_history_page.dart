import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/label/label_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/call/services/call_log_service.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';

class CallHistoryPage extends StatefulWidget {
  const CallHistoryPage({super.key});

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
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue, size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
    
    // 获取CallLogService实例
    final callLogService = Provider.of<CallLogService>(context, listen: false);
    
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
                // 使用FutureBuilder获取并显示头像
                FutureBuilder<String?>(
                  future: callLogService.getAvatarForNumber(log.number),
                  builder: (context, snapshot) {
                    Widget avatarWidget;
                    
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // 加载中显示占位符
                      avatarWidget = Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: iconColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))),
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      // 有头像数据
                      final avatarPath = snapshot.data!;
                      ImageProvider imageProvider;
                      
                      if (avatarPath.startsWith('http')) {
                        // 网络图片
                        imageProvider = NetworkImage(avatarPath);
                      } else {
                        // 本地图片
                        imageProvider = FileImage(File(avatarPath));
                      }
                      
                      avatarWidget = Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else if (log.labelIds != null && log.labelIds!.isNotEmpty) {
                      // 使用标签作为默认头像
                      avatarWidget = FutureBuilder<List<LabelEntry>>(
                        future: Provider.of<LabelService>(context, listen: false).getAllLabels(),
                        builder: (context, labelSnapshot) {
                          if (labelSnapshot.hasData) {
                            final matchingLabels = labelSnapshot.data!.where(
                              (label) => log.labelIds!.contains(label.id)
                            ).toList();
                            
                            if (matchingLabels.isNotEmpty) {
                              // 使用第一个标签的图标作为头像
                              final labelIcon = callLogService.getDefaultAvatarForLabel(matchingLabels.first.label);
                              
                              if (labelIcon != null) {
                                return Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: labelIcon,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                          
                          // 默认图标
                          return Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: iconColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(callIcon, color: iconColor),
                          );
                        },
                      );
                    } else {
                      // 默认图标
                      avatarWidget = Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: iconColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(callIcon, color: iconColor),
                      );
                    }
                    
                    return avatarWidget;
                  },
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
                      Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
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
    // 创建一个状态变量，用于控制标签面板的展开/折叠状态
    bool isExpanded = false;
    
    // 创建一个可滚动的底部面板
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 允许面板占据更多空间
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => StatefulBuilder( // 使用StatefulBuilder以便在底部面板内部管理状态
        builder: (context, setState) => Container(
          padding: const EdgeInsets.all(16),
          // 设置最小高度为屏幕高度的30%，最大高度为70%
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.3,
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题栏
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '为通话记录添加标签',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              // 电话号码信息
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      log.number,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // 当前标签信息（如果有）
              if (log.labelIds?.isNotEmpty == true)
                FutureBuilder<List<LabelEntry>>(
                  future: Provider.of<LabelService>(context, listen: false).getAllLabels(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    if (snapshot.hasData) {
                      final matchingLabels = snapshot.data!.where(
                        (label) => log.labelIds!.contains(label.id)
                      ).toList();
                      
                      if (matchingLabels.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('当前标签:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: matchingLabels.map((label) => Chip(
                                  label: Text(label.label),
                                  backgroundColor: const Color(0xFFF5A623).withOpacity(0.1),
                                  labelStyle: const TextStyle(color: Color(0xFFF5A623)),
                                  deleteIcon: const Icon(Icons.close, size: 16),
                                  onDeleted: () async {
                                    try {
                                      final callLogService = Provider.of<CallLogService>(context, listen: false);
                                      // 创建一个新的标签列表，排除要删除的标签
                                      final newLabelIds = List<String>.from(log.labelIds ?? [])
                                        ..remove(label.id);
                                      
                                      // 创建更新后的通话记录
                                      final updatedLog = CallLog(
                                        id: log.id,
                                        number: log.number,
                                        timestamp: log.timestamp,
                                        simDisplayName: log.simDisplayName,
                                        callType: log.callType,
                                        simSlotIndex: log.simSlotIndex,
                                        carrierName: log.carrierName,
                                        countryIso: log.countryIso,
                                        subscriptionId: log.subscriptionId,
                               
                                        labelIds: newLabelIds,
                                      );
                                      
                                      // 更新通话记录
                                      await callLogService.updateLog(updatedLog);
                                      
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('标签已移除')),
                                        );
                                        // 刷新状态
                                        setState(() {});
                                      }
                                    } catch (e) {
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('移除标签失败: $e')),
                                        );
                                      }
                                    }
                                  },
                                )).toList(),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
              // 展开/折叠按钮
              GestureDetector(
                onTap: () => setState(() => isExpanded = !isExpanded),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isExpanded ? '收起标签选择器' : '展开标签选择器',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      Icon(
                        isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              // 标签选择器（可展开/折叠）
              if (isExpanded)
                Expanded(
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('标签已更新')),
                            );
                            // 刷新状态
                            setState(() {});
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('新标签已创建并关联到通话记录')),
                            );
                            // 刷新状态
                            setState(() {});
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
              // 底部按钮
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('关闭'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}