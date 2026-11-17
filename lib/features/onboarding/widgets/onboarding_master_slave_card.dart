import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_device_master_slave_protocol/pyro_device_master_slave_protocol.dart';
import 'package:pyro_device_master_slave_ui/pyro_device_master_slave_ui.dart';

/// 引导页：设备集群与节点角色介绍卡片组件（100% Primary/Secondary 规范与标准国际化）
class OnboardingMasterSlaveCard extends ConsumerStatefulWidget {
  const OnboardingMasterSlaveCard({super.key});

  @override
  ConsumerState<OnboardingMasterSlaveCard> createState() => _OnboardingMasterSlaveCardState();
}

class _OnboardingMasterSlaveCardState extends ConsumerState<OnboardingMasterSlaveCard> {
  DeviceRole _selectedRole = DeviceRole.master;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final deviceL10n = DeviceMasterSlaveLocalizations.of(context);

    final isPrimary = _selectedRole == DeviceRole.master;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 上层：节点图示与角色对比 Banner (上下两层解耦布局)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isPrimary ? colorScheme.primary.withValues(alpha: 0.5) : colorScheme.secondary.withValues(alpha: 0.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: (isPrimary ? colorScheme.primary : colorScheme.secondary).withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (isPrimary ? colorScheme.primaryContainer : colorScheme.secondaryContainer).withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isPrimary ? Icons.stars_rounded : Icons.phone_android_rounded,
                        color: isPrimary ? colorScheme.primary : colorScheme.secondary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                isPrimary ? deviceL10n.primaryRole : deviceL10n.secondaryRole,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isPrimary ? colorScheme.primaryContainer : colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: isPrimary ? colorScheme.primary.withValues(alpha: 0.4) : colorScheme.secondary.withValues(alpha: 0.4),
                                  ),
                                ),
                                child: Text(
                                  isPrimary ? deviceL10n.primaryBadge : deviceL10n.secondaryBadge,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: isPrimary ? colorScheme.onPrimaryContainer : colorScheme.onSecondaryContainer,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isPrimary ? deviceL10n.primaryDesc : deviceL10n.secondaryDesc,
                            style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isPrimary ? Icons.shield_rounded : Icons.sync_lock_rounded,
                        size: 16,
                        color: isPrimary ? colorScheme.primary : colorScheme.secondary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          isPrimary ? deviceL10n.primaryDesc : deviceL10n.secondaryDesc,
                          style: TextStyle(
                            fontSize: 11,
                            color: colorScheme.onSurfaceVariant,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            deviceL10n.clusterOnboardingTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            deviceL10n.clusterOnboardingDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // 下层：角色快选体验 SegmentedButton (全宽、无单行挤压、无硬编码)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SegmentedButton<DeviceRole>(
                  segments: [
                    ButtonSegment(
                      value: DeviceRole.master,
                      label: Text(deviceL10n.primaryRole),
                      icon: const Icon(Icons.stars_rounded, size: 16),
                    ),
                    ButtonSegment(
                      value: DeviceRole.slave,
                      label: Text(deviceL10n.secondaryRole),
                      icon: const Icon(Icons.phone_android_rounded, size: 16),
                    ),
                  ],
                  selected: {_selectedRole},
                  onSelectionChanged: (selected) {
                    setState(() {
                      _selectedRole = selected.first;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
