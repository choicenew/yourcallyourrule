import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_filter/call_filter_type.dart';
import 'package:yourcallyourrule/features/call_filter/providers/enhanced_filter_config_provider.dart';

/// 过滤器通用 Switch 列表项组件
class FilterSwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final int count;
  final bool isEnabled;
  final Function(bool) onToggle;

  const FilterSwitchTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.count,
    required this.isEnabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$count',
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Switch(value: isEnabled, onChanged: onToggle, activeThumbColor: color),
        ],
      ),
    );
  }
}

/// SIM 卡分卡特化 Switch 列表项组件
class SimSlotFilterTile extends ConsumerWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final int simSlot;
  final CallFilterType filterType;
  final String serviceId;

  const SimSlotFilterTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.simSlot,
    required this.filterType,
    required this.serviceId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enhancedConfig = ref.watch(
      enhancedFilterConfigProvider.select((v) => v.value),
    );

    if (enhancedConfig == null) {
      return Container();
    }

    final isEnabled = enhancedConfig.simSlotFilterConfigMap[simSlot]?[filterType] ??
        enhancedConfig.filterEnabledMap[serviceId] ??
        true;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: (value) {
              final notifier = ref.read(enhancedFilterConfigProvider.notifier);
              value
                  ? notifier.enableFilterForSimSlot(simSlot, filterType)
                  : notifier.disableFilterForSimSlot(simSlot, filterType);
            },
            activeThumbColor: color,
          ),
        ],
      ),
    );
  }
}
