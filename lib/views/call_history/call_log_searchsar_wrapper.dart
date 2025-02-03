
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'call_log_database.dart';



class CallLogSearchBarWrapper extends StatefulWidget {
  final List<CallLogEntry> callLogs;
  final Widget Function(BuildContext, List<CallLogEntry>) builder;

  const CallLogSearchBarWrapper({
    super.key,
    required this.callLogs,
    required this.builder,
  });

  @override
  State<CallLogSearchBarWrapper> createState() => _CallLogSearchBarWrapperState();
}

class _CallLogSearchBarWrapperState extends State<CallLogSearchBarWrapper> {
  Key _key = UniqueKey();  // 添加key来强制重建

  @override
  void didUpdateWidget(CallLogSearchBarWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.callLogs, oldWidget.callLogs)) {
      setState(() {
        _key = UniqueKey();  // 更新key强制重建
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: widget.builder(context, widget.callLogs)
    );
  }
}


/*
class CallLogSearchBarWrapper extends StatefulWidget {
  final List<CallLogEntry> callLogs;
  final Widget Function(BuildContext, List<CallLogEntry>) builder;

  const CallLogSearchBarWrapper({
    super.key,
    required this.callLogs,
    required this.builder,
  });

  @override
  State<CallLogSearchBarWrapper> createState() => _CallLogSearchBarWrapperState();
}

class _CallLogSearchBarWrapperState extends State<CallLogSearchBarWrapper> {
  late List<CallLogEntry> _currentLogs;

  @override
  void initState() {
    super.initState();
    _currentLogs = List.from(widget.callLogs); // 初始化数据
  }

  @override
  void didUpdateWidget(CallLogSearchBarWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 检查数据是否真的变化
    if (!listEquals(widget.callLogs, oldWidget.callLogs)) {
      setState(() {
        _currentLogs = List.from(widget.callLogs);
      });
    }
  }

  @override 
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!listEquals(_currentLogs, widget.callLogs)) {
      setState(() {
        _currentLogs = List.from(widget.callLogs);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 直接使用widget.callLogs而不是_currentLogs
    return widget.builder(context, widget.callLogs);
  }
}
*/

/*
// 使用方式：
Widget _buildCallLogSearchBar(List<CallLogEntry> callLogs) {
  return CallLogSearchBarWrapper(
    callLogs: callLogs,
    builder: (context, logs) => AdvancedSelfManagedSearchBar<CallLogEntry>(
      items: logs,
      itemBuilder: (context, entry, width) => _buildCallLogItem(entry, width),
      getSearchString: (entry) => '${entry.timestamp} ${entry.number} ${entry.name}',
      getSortFields: (entry) => ['Time', 'Phone Number', 'Name'],
      getSortFieldValues: (entry) => [entry.timestamp, entry.number, entry.name],
      originalBuilder: (context, items) => _build(context),
    ),
  );
}
*/