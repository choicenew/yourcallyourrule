library pyro_device_profile_ui;

import 'package:flutter/material.dart';
import 'package:pyro_device_profile_protocol/pyro_device_profile_protocol.dart';

/// 设备 Profile ListTile 组件
class DeviceProfileTileView extends StatelessWidget {
  final DeviceRawProfile profile;

  const DeviceProfileTileView({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.perm_device_information),
      title: Text(profile.deviceId ?? 'Unknown Device'),
      subtitle: Text('SIM: ${profile.simState ?? "N/A"} • IP: ${profile.ipAddress ?? "N/A"} (${profile.countryCode ?? ""})'),
    );
  }
}
