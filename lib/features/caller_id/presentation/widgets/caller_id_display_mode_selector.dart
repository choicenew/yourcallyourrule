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

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.display_settings_rounded, color: Color(0xFFFF9500), size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                l10n.callerIdDisplayMode,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildModeCard(
            context: context,
            icon: Icons.layers_outlined,
            selectedIcon: Icons.layers_rounded,
            title: l10n.overlayMode,
            subtitle: l10n.overlayModeDescription,
            value: DisplayMode.overlay,
            groupValue: config.displayMode,
            onSelected: (mode) => notifier.setDisplayMode(mode),
          ),
          const SizedBox(height: 10),
          _buildModeCard(
            context: context,
            icon: Icons.notifications_none_rounded,
            selectedIcon: Icons.notifications_active_rounded,
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
            selectedIcon: Icons.bolt_rounded,
            title: l10n.liveActivityMode,
            subtitle: l10n.liveActivityModeDescription,
            value: DisplayMode.live_activity,
            groupValue: config.displayMode,
            onSelected: (mode) => notifier.setDisplayMode(mode),
          ),
          const SizedBox(height: 14),
          InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd, width: 400),
        ],
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
    const activeColor = Color(0xFFFF9500);

    return InkWell(
      onTap: () => onSelected(value),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? activeColor : const Color(0xFFEDE8DF),
            width: isSelected ? 1.5 : 1.1,
          ),
          color: isSelected
              ? activeColor.withValues(alpha: 0.08)
              : const Color(0xFFF7F5F0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? activeColor.withValues(alpha: 0.15)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isSelected ? selectedIcon : icon,
                color: isSelected ? activeColor : Colors.grey[700],
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                      fontSize: 14.5,
                      color: isSelected ? activeColor : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Radio<DisplayMode>(
              value: value,
              groupValue: groupValue,
              activeColor: activeColor,
              onChanged: (val) {
                if (val != null) onSelected(val);
              },
            ),
          ],
        ),
      ),
    );
  }
}