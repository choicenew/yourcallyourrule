library pyro_call_monitor_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_call_monitor_protocol/pyro_phone_call_monitor_protocol.dart';

/// 通道事件 ListTile 组件
class CallMonitorEventTileView extends StatelessWidget {
  final CallMonitorEvent event;

  const CallMonitorEventTileView({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.phone_in_talk),
      title: Text(event.phoneNumber),
      subtitle: Text(event.runtimeType.toString()),
    );
  }
}
