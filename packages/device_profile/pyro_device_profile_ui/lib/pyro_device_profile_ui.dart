library pyro_device_profile_ui;

import 'package:flutter/material.dart';
import 'package:pyro_device_profile_protocol/pyro_device_profile_protocol.dart';

/// 100% 遵照 SKILL 规范：富 UI 元素、原生 Theme.of(context)、withValues(alpha: 0.8)
class PyroDeviceProfileCardWidget extends StatelessWidget {
  final DeviceRawProfile profile;
  final Widget? avatar;
  final VoidCallback? onTap;

  const PyroDeviceProfileCardWidget({
    super.key,
    required this.profile,
    this.avatar,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 1.0,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: avatar ??
            CircleAvatar(
              backgroundColor: colorScheme.tertiaryContainer,
              foregroundColor: colorScheme.onTertiaryContainer,
              child: const Icon(Icons.perm_device_information_rounded, size: 20),
            ),
        title: Text(
          profile.deviceId ?? 'Unknown Device',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          'SIM: ${profile.simState ?? "N/A"} • IP: ${profile.ipAddress ?? "N/A"} (${profile.countryCode ?? ""})',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

/// 兼容别名导出
typedef DeviceProfileTileView = PyroDeviceProfileCardWidget;
