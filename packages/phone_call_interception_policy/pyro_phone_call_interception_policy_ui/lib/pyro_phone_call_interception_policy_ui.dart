import 'package:flutter/material.dart';
import 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';

/// 策略动作显示 ListTile 组件
class InterceptActionTileView extends StatelessWidget {
  final InterceptAction action;

  const InterceptActionTileView({
    super.key,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.security),
      title: Text(action.actionName),
    );
  }
}
