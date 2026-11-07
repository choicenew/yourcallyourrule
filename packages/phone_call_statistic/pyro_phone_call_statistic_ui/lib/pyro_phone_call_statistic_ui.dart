library pyro_phone_call_statistic_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_call_statistic_protocol/pyro_phone_call_statistic_protocol.dart';

/// 通话统计数据 Card 组件
class PhoneCallStatisticCardView extends StatelessWidget {
  final PhoneCallStatisticData data;

  const PhoneCallStatisticCardView({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.pie_chart),
        title: Text('Blocked Calls: ${data.blockedCalls} / Total: ${data.totalCalls}'),
        subtitle: Text('Allowed: ${data.allowedCalls} • Silenced: ${data.silencedCalls}'),
      ),
    );
  }
}
