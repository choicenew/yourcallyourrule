import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/router/app_router.dart' as app_router;

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final navItems = [
      _BottomNavItemData(icon: Icons.shield_rounded, label: l10n.homeTab),
      _BottomNavItemData(icon: Icons.call_rounded, label: l10n.callHistoryTab),
      _BottomNavItemData(icon: Icons.contacts_rounded, label: l10n.contactsTab),
      _BottomNavItemData(icon: Icons.dashboard_rounded, label: l10n.dashboardTab),
      _BottomNavItemData(icon: Icons.settings_rounded, label: l10n.settingsTab),
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
}

class _BottomNavItemData {
  final IconData icon;
  final String label;

  const _BottomNavItemData({required this.icon, required this.label});
}

// START: 修改这里
class BottomNavigationHandler {
  // <-- 从 AppRouter 重命名为 BottomNavigationHandler
  static void handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/${app_router.AppRouter.callHistory}');
        break;
      case 2:
        context.go('/${app_router.AppRouter.contactsManagement}');
        break;
      case 3:
        context.go('/${app_router.AppRouter.dashboard}');
        break;
      case 4:
        context.go('/${app_router.AppRouter.settings}');
        break;
    }
  }
}
// END: 修改这里