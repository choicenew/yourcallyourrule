library pyro_call_coordinator_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_call_coordinator_protocol/pyro_phone_call_coordinator_protocol.dart';

/// 编排通话数据 ListTile 组件
class CallCoordinatorDataTileView extends StatelessWidget {
  final CallCoordinatorData data;

  const CallCoordinatorDataTileView({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.tune),
      title: Text(data.phoneNumber),
      subtitle: Text('${data.name ?? "Unknown"} • ${data.actionName}'),
    );
  }
}
