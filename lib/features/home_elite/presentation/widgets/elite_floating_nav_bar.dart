// -----------------------------------------------------------------------------
// 文件: elite_floating_nav_bar.dart
// 描述: Elite 底部悬浮多巴胺胶囊导航栏，承载 5 大核心一级导航并带有琥珀流光指示。
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// ------------------- Widget 定义 -------------------

class EliteFloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const EliteFloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final navItems = [
      _NavItemData(icon: Icons.shield_rounded, label: l10n.homeTab),
      _NavItemData(icon: Icons.call_rounded, label: l10n.callHistoryTab),
      _NavItemData(icon: Icons.contacts_rounded, label: l10n.contactsTab),
      _NavItemData(icon: Icons.dashboard_rounded, label: l10n.dashboardTab),
      _NavItemData(icon: Icons.settings_rounded, label: l10n.settingsTab),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: EliteDopamineTheme.warmSunAmber.withValues(alpha: 0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: EliteDopamineTheme.warmSunAmber.withValues(alpha: 0.18),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          final item = navItems[index];
          final isSelected = currentIndex == index;

          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 240),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(
                horizontal: isSelected ? 12 : 8,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? EliteDopamineTheme.warmSunAmber.withValues(alpha: 0.18)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item.icon,
                    size: 22,
                    color: isSelected
                        ? EliteDopamineTheme.sunsetTangerine
                        : Colors.grey[500],
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: 6),
                    Text(
                      item.label,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: EliteDopamineTheme.sunsetTangerine,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  static Future<void> handleEliteNavigation(BuildContext context, int index) async {
    switch (index) {
      case 0:
        context.goNamed(AppRouter.eliteHome);
        break;
      case 1:
        await context.pushNamed(AppRouter.callHistory);
        break;
      case 2:
        await context.pushNamed(AppRouter.contactsManagement);
        break;
      case 3:
        await context.pushNamed(AppRouter.dashboard);
        break;
      case 4:
        await context.pushNamed(AppRouter.settings);
        break;
    }
  }
}

class _NavItemData {
  final IconData icon;
  final String label;

  const _NavItemData({required this.icon, required this.label});
}

// ------------------- Widget Previewer 支持 -------------------

@Preview(name: 'Floating Navigation Bar', group: 'Elite Showcase')
Widget previewEliteFloatingNavBar() {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      backgroundColor: EliteDopamineTheme.warmCanvasBackground,
      body: const Center(
        child: SizedBox.shrink(),
      ),
      bottomNavigationBar: EliteFloatingNavBar(
        currentIndex: 0,
        onTap: (_) {},
      ),
    ),
  );
}
