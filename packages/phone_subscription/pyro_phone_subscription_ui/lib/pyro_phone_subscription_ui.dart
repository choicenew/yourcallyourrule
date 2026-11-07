library pyro_phone_subscription_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';

/// 电话订阅条目 ListTile 组件
class PhoneSubscriptionTileView extends StatelessWidget {
  final PhoneSubscriptionKind kind;

  const PhoneSubscriptionTileView({
    super.key,
    required this.kind,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.cloud_download),
      title: Text(kind.id),
    );
  }
}
