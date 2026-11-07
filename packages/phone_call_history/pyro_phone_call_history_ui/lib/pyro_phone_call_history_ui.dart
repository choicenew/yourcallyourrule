library pyro_phone_call_history_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';

/// 通话历史条目 ListTile 组件
class CallLogTileView extends StatelessWidget {
  final CallLogEntry entry;

  const CallLogTileView({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.history),
      title: Text(entry.name ?? entry.phoneNumber),
      subtitle: Text('${entry.callType} • ${entry.location ?? "Unknown"}'),
    );
  }
}
