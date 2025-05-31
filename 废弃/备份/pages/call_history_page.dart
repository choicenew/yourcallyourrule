import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/call_logs_list.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/label_filter_chip.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';

class CallHistoryPage extends StatefulWidget {
  const CallHistoryPage({super.key});

  @override
  State<CallHistoryPage> createState() => _CallHistoryPageState();
}

class _CallHistoryPageState extends State<CallHistoryPage> {
  bool _isLoading = true;
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
            LabelFilterChip(
              labelId: _selectedLabel!,
              onDeleted: _clearLabelFilter,
            ),
          // 通话记录列表
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : CallLogsList(
                    selectedLabel: _selectedLabel,
                    onRefresh: _refreshCallLogs,
                    onClearFilter: _selectedLabel != null ? _clearLabelFilter : null,
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
}
