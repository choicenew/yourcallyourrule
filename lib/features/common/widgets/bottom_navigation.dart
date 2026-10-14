import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class BottomNavigation extends StatelessWidget {
  static const String tabHome = 'home';
  static const String tabCallHistory = 'call_history';
  static const String tabContacts = 'contacts';
  static const String tabDashboard = 'dashboard';
  static const String tabSettings = 'settings';

  static const List<String> defaultTabIds = [
    tabHome,
    tabCallHistory,
    tabContacts,
    tabDashboard,
    tabSettings,
  ];

  final int currentIndex;
  final ValueChanged<int>? onTap;
  final List<String> activeTabIds;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    this.onTap,
    this.activeTabIds = defaultTabIds,
  });

  _NavItemData _buildNavItemData(String id, AppLocalizations l10n) {
    switch (id) {
      case tabHome:
        return _NavItemData(
          icon: Icons.shield_outlined,
          selectedIcon: Icons.shield_rounded,
          label: l10n.homeTab,
        );
      case tabCallHistory:
        return _NavItemData(
          icon: Icons.call_outlined,
          selectedIcon: Icons.call_rounded,
          label: l10n.callHistoryTab,
        );
      case tabContacts:
        return _NavItemData(
          icon: Icons.contacts_outlined,
          selectedIcon: Icons.contacts_rounded,
          label: l10n.contactsTab,
        );
      case tabDashboard:
        return _NavItemData(
          icon: Icons.dashboard_outlined,
          selectedIcon: Icons.dashboard_rounded,
          label: l10n.dashboardTab,
        );
      case tabSettings:
      default:
        return _NavItemData(
          icon: Icons.settings_outlined,
          selectedIcon: Icons.settings_rounded,
          label: l10n.settingsTab,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final navItems = activeTabIds.map((id) => _buildNavItemData(id, l10n)).toList();

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.35),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.18),
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
            final isSelected = currentIndex.clamp(0, navItems.length - 1) == index;

            return GestureDetector(
              onTap: () {
                if (index == currentIndex) return;
                onTap?.call(index);
              },
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
                      ? theme.colorScheme.primary.withValues(alpha: 0.18)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSelected ? item.selectedIcon : item.icon,
                      size: 22,
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 6),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const _NavItemData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}
