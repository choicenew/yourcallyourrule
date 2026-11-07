library pyro_phone_remote_filter_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';

/// 远程高危号码卡片组件 (PhoneRemoteFilterTileView)
class PhoneRemoteFilterTileView extends StatelessWidget {
  final RemoteNumberEntry entry;

  const PhoneRemoteFilterTileView({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.cloud_off),
      title: Text(entry.phoneNumber),
      subtitle: Text('${entry.name ?? "Unknown"} • ${entry.label ?? "Remote Threat"}'),
    );
  }
}
