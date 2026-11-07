library pyro_phone_location_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';

/// 号码归属地显示卡片组件 (PhoneLocationTileView)
class PhoneLocationTileView extends StatelessWidget {
  final PhoneLocationEntry entry;

  const PhoneLocationTileView({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: Text(entry.phoneNumber),
      subtitle: Text('${entry.region ?? "Unknown"} • ${entry.carrier ?? "Unknown"}'),
    );
  }
}
