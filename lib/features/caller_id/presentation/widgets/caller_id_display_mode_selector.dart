// lib/features/caller_id/presentation/widgets/caller_id_display_mode_selector.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
import 'package:yourcallyourrule/features/caller_id/config/display_mode.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 来电显示模式选择器小部件
/// 允许用户直观选择来电信息的显示方式：悬浮窗、传统通知或实时活动 (Live Activity)
class CallerIdDisplayModeSelector extends ConsumerWidget {
  const CallerIdDisplayModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(callerIdConfigProvider);
    final notifier = ref.read(callerIdConfigProvider.notifier);
    final l10n = AppLocalizations.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.display_settings, size: 22),
                const SizedBox(width: 8),
                Text(
                  l10n.callerIdDisplayMode,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildModeCard(
              context: context,
              icon: Icons.layers_outlined,
              selectedIcon: Icons.layers,
              title: l10n.overlayMode,
              subtitle: l10n.overlayModeDescription,
              value: DisplayMode.overlay,
              groupValue: config.displayMode,
              onSelected: (mode) => notifier.setDisplayMode(mode),
            ),
            const SizedBox(height: 10),
            _buildModeCard(
              context: context,
              icon: Icons.notifications_none,
              selectedIcon: Icons.notifications_active,
              title: l10n.notificationMode,
              subtitle: l10n.notificationModeDescription,
              value: DisplayMode.notification,
              groupValue: config.displayMode,
              onSelected: (mode) => notifier.setDisplayMode(mode),
            ),
            const SizedBox(height: 10),
            _buildModeCard(
              context: context,
              icon: Icons.bolt_outlined,
              selectedIcon: Icons.bolt,
              title: l10n.liveActivityMode,
              subtitle: l10n.liveActivityModeDescription,
              value: DisplayMode.live_activity,
              groupValue: config.displayMode,
              onSelected: (mode) => notifier.setDisplayMode(mode),
            ),
            const SizedBox(height: 16),
            InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd, width: 400),
          ],
        ),
      ),
    );
  }

  /// 构建现代化卡片选项
  Widget _buildModeCard({
    required BuildContext context,
    required IconData icon,
    required IconData selectedIcon,
    required String title,
    required String subtitle,
    required DisplayMode value,
    required DisplayMode groupValue,
    required void Function(DisplayMode) onSelected,
  }) {
    final isSelected = value == groupValue;
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onSelected(value),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? primaryColor : theme.dividerColor.withAlpha(80),
              width: isSelected ? 2 : 1,
            ),
            color: isSelected
                ? primaryColor.withAlpha(20)
                : theme.cardColor.withAlpha(50),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: isSelected
                      ? primaryColor.withAlpha(40)
                      : theme.dividerColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isSelected ? selectedIcon : icon,
                  color: isSelected ? primaryColor : theme.iconTheme.color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                        color: isSelected ? primaryColor : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withAlpha(180),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Radio<DisplayMode>(
                value: value,
                groupValue: groupValue,
                activeColor: primaryColor,
                onChanged: (val) {
                  if (val != null) onSelected(val);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}