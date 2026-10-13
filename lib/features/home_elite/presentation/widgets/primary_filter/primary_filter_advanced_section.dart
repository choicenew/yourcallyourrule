import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/enhanced_filter_config_provider.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/provider/time_interceptor_provider.dart';
import 'package:yourcallyourrule/features/device_profile/provider/sim_info_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/features/local_filter/provider/local_count_filter_provider.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_filter_provider.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 独立可用的高级过滤器配置组件 (Filter Management 展开区)
class PrimaryFilterAdvancedSection extends ConsumerWidget {
  final int selectedSimSlot;
  final AppLocalizations l10n;

  const PrimaryFilterAdvancedSection({
    super.key,
    required this.selectedSimSlot,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enhancedConfigAsync = ref.watch(enhancedFilterConfigProvider);

    return enhancedConfigAsync.when(
      data: (enhancedConfig) {
        final isSimSlotRuleEnabled = enhancedConfig.filterEnabledMap['SimSlotRuleService'] ?? false;
        if (isSimSlotRuleEnabled) {
          return _buildSimSlotContent(context, ref);
        } else {
          return _buildGlobalFilterList(context, ref, enhancedConfig);
        }
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      error: (err, _) => Center(
        child: Text(
          l10n.dataLoadFailure(err.toString()),
          style: const TextStyle(fontSize: 11, color: EliteDopamineTheme.textSecondary),
        ),
      ),
    );
  }

  Widget _buildGlobalFilterList(BuildContext context, WidgetRef ref, dynamic enhancedConfig) {
    final isSimSlotEnabled = enhancedConfig.filterEnabledMap['SimSlotRuleService'] ?? false;

    final allRulesCountProvider = FutureProvider<int>((ref) async {
      final service = ref.watch(simSlotRuleServiceProvider);
      final rules = await service.getAllSimSlotRules();
      return rules.length;
    });
    final rulesCount = ref.watch(allRulesCountProvider).value ?? 0;

    final localConfig = ref.watch(localCountFilterConfigProvider.select((v) => v.value));
    final isLocalCountEnabled = localConfig?.enableLocalCountFilter ?? false;

    final remoteConfig = ref.watch(remoteNumberFilterConfigProvider.select((v) => v.value));
    final isRemoteEnabled = remoteConfig?.enableRemoteNumberFilter ?? false;

    final timeConfig = ref.watch(timeInterceptorConfigProvider.select((v) => v.value));
    final isTimeEnabled = timeConfig?.shouldIntercept ?? false;

    return Column(
      children: [
        _buildSwitchTile(
          icon: Icons.sim_card_outlined,
          iconColor: EliteDopamineTheme.skyAzure,
          title: l10n.simCardFilterRules,
          subtitle: l10n.simCardFilterRulesDescription,
          badgeText: '$rulesCount',
          value: isSimSlotEnabled,
          onChanged: (val) {
            final notifier = ref.read(enhancedFilterConfigProvider.notifier);
            val ? notifier.enableFilter('SimSlotRuleService') : notifier.disableFilter('SimSlotRuleService');
          },
        ),
        const SizedBox(height: 8),
        _buildSwitchTile(
          icon: Icons.filter_alt_outlined,
          iconColor: EliteDopamineTheme.sunsetTangerine,
          title: l10n.localCountFilter,
          subtitle: l10n.localCountFilterDescription,
          badgeText: localConfig != null ? '${localConfig.countThreshold}' : null,
          value: isLocalCountEnabled,
          onChanged: (val) {
            if (localConfig != null) {
              ref.read(localCountFilterConfigProvider.notifier).updateConfig(
                    localConfig.copyWith(enableLocalCountFilter: val),
                  );
            }
          },
        ),
        const SizedBox(height: 8),
        _buildSwitchTile(
          icon: Icons.cloud_outlined,
          iconColor: EliteDopamineTheme.softLilac,
          title: l10n.remoteNumberFilter,
          subtitle: l10n.remoteNumberFilterDescription,
          badgeText: remoteConfig != null ? '${remoteConfig.countThreshold}' : null,
          value: isRemoteEnabled,
          onChanged: (val) {
            if (remoteConfig != null) {
              ref.read(remoteNumberFilterConfigProvider.notifier).updateConfig(
                    remoteConfig.copyWith(enableRemoteNumberFilter: val),
                  );
            }
          },
        ),
        const SizedBox(height: 8),
        _buildSwitchTile(
          icon: Icons.timer_outlined,
          iconColor: EliteDopamineTheme.freshMint,
          title: l10n.timeInterceptor,
          subtitle: l10n.timeInterceptorDescription,
          badgeText: timeConfig != null ? '${timeConfig.duration.inMinutes}m' : null,
          value: isTimeEnabled,
          onChanged: (val) {
            if (timeConfig != null) {
              ref.read(timeInterceptorConfigProvider.notifier).updateShouldIntercept(val);
            }
          },
        ),
      ],
    );
  }

  Widget _buildSimSlotContent(BuildContext context, WidgetRef ref) {
    final simCardsAsync = ref.watch(simCardsProvider);

    return simCardsAsync.when(
      data: (simCards) {
        if (simCards.isEmpty) {
          return Center(
            child: Text(
              l10n.noSimCardsDetected,
              style: const TextStyle(fontSize: 12, color: EliteDopamineTheme.textSecondary),
            ),
          );
        }

        return Column(
          children: [
            _buildSwitchTile(
              icon: Icons.filter_alt_outlined,
              iconColor: EliteDopamineTheme.sunsetTangerine,
              title: l10n.localCountFilter,
              subtitle: l10n.localCountFilterDescription,
              value: true,
              onChanged: (_) {},
            ),
            const SizedBox(height: 8),
            _buildSwitchTile(
              icon: Icons.cloud_outlined,
              iconColor: EliteDopamineTheme.softLilac,
              title: l10n.remoteNumberFilter,
              subtitle: l10n.remoteNumberFilterDescription,
              value: true,
              onChanged: (_) {},
            ),
            const SizedBox(height: 8),
            _buildSwitchTile(
              icon: Icons.timer_outlined,
              iconColor: EliteDopamineTheme.freshMint,
              title: l10n.timeInterceptor,
              subtitle: l10n.timeInterceptorDescription,
              value: true,
              onChanged: (_) {},
            ),
          ],
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      error: (err, _) => Center(child: Text(err.toString())),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    String? badgeText,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: EliteDopamineTheme.slateSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: value ? iconColor.withValues(alpha: 0.35) : EliteDopamineTheme.slateBorder,
          width: 1.1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: EliteDopamineTheme.textPrimary,
                      ),
                    ),
                    if (badgeText != null) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: iconColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          badgeText,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: iconColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 9.5,
                    color: EliteDopamineTheme.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            activeColor: iconColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
