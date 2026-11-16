import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_device_master_slave_protocol/pyro_device_master_slave_protocol.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 引导页：主从设备集群概念与节点角色介绍卡片组件（100% i18n 国际化）
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
    final l10n = AppLocalizations.of(context);

    final isMaster = _selectedRole == DeviceRole.master;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 上层：主从节点图示与角色对比 Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isMaster ? Colors.green.withValues(alpha: 0.5) : Colors.orange.withValues(alpha: 0.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: (isMaster ? Colors.green : Colors.orange).withValues(alpha: 0.08),
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
                        color: (isMaster ? Colors.green : Colors.orange).withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isMaster ? Icons.star_rounded : Icons.phonelink_setup_rounded,
                        color: isMaster ? Colors.green : Colors.orange,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isMaster ? l10n.masterRoleTitle : l10n.slaveRoleTitle,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            isMaster ? l10n.masterRoleDescription : l10n.slaveRoleDescription,
                            style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurfaceVariant),
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
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isMaster ? Icons.shield_rounded : Icons.sync_lock_rounded,
                        size: 16,
                        color: isMaster ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          isMaster ? l10n.masterPermissionHelp : l10n.slavePermissionHelp,
                          style: TextStyle(
                            fontSize: 11,
                            color: theme.colorScheme.onSurfaceVariant,
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
            l10n.masterSlaveOnboardingTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.masterSlaveOnboardingDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // 下层：角色快选体验 SegmentedButton
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SegmentedButton<DeviceRole>(
                  segments: const [
                    ButtonSegment(
                      value: DeviceRole.master,
                      label: Text('Master (主节点)'),
                      icon: Icon(Icons.star_border, size: 16),
                    ),
                    ButtonSegment(
                      value: DeviceRole.slave,
                      label: Text('Slave (从节点)'),
                      icon: Icon(Icons.lock_clock, size: 16),
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
