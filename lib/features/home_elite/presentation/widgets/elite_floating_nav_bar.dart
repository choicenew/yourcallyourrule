import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context);

    final navItems = [
      _NavItemData(icon: Icons.shield_rounded, label: l10n?.homeTab ?? 'Home'),
      _NavItemData(icon: Icons.call_rounded, label: l10n?.callHistoryTab ?? 'Calls'),
      _NavItemData(icon: Icons.contacts_rounded, label: l10n?.contactsTab ?? 'Contacts'),
      _NavItemData(icon: Icons.dashboard_rounded, label: l10n?.dashboardTab ?? 'Dashboard'),
      _NavItemData(icon: Icons.settings_rounded, label: l10n?.settingsTab ?? 'Settings'),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: EliteDopamineTheme.warmSunAmber.withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: EliteDopamineTheme.sunsetTangerine.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          final isSelected = currentIndex == index;
          final item = navItems[index];

          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.symmetric(
                horizontal: isSelected ? 12 : 8,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? EliteDopamineTheme.warmSunAmber.withValues(alpha: 0.16)
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

  static void handleEliteNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/elite-home');
        break;
      case 1:
        context.push('/call-history');
        break;
      case 2:
        context.push('/contacts-management');
        break;
      case 3:
        context.push('/dashboard');
        break;
      case 4:
        context.push('/settings');
        break;
    }
  }
}

class _NavItemData {
  final IconData icon;
  final String label;

  const _NavItemData({required this.icon, required this.label});
}
