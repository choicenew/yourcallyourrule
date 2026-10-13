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

  NavigationDestination _buildDestination(
    String id,
    AppLocalizations l10n,
    Color unselectedColor,
    ColorScheme colorScheme,
  ) {
    switch (id) {
      case tabHome:
        return NavigationDestination(
          icon: Icon(Icons.shield_outlined, color: unselectedColor),
          selectedIcon: Icon(Icons.shield_rounded, color: colorScheme.primary),
          label: l10n.homeTab,
        );
      case tabCallHistory:
        return NavigationDestination(
          icon: Icon(Icons.call_outlined, color: unselectedColor),
          selectedIcon: Icon(Icons.call_rounded, color: colorScheme.primary),
          label: l10n.callHistoryTab,
        );
      case tabContacts:
        return NavigationDestination(
          icon: Icon(Icons.contacts_outlined, color: unselectedColor),
          selectedIcon: Icon(Icons.contacts_rounded, color: colorScheme.primary),
          label: l10n.contactsTab,
        );
      case tabDashboard:
        return NavigationDestination(
          icon: Icon(Icons.dashboard_outlined, color: unselectedColor),
          selectedIcon: Icon(Icons.dashboard_rounded, color: colorScheme.primary),
          label: l10n.dashboardTab,
        );
      case tabSettings:
      default:
        return NavigationDestination(
          icon: Icon(Icons.settings_outlined, color: unselectedColor),
          selectedIcon: Icon(Icons.settings_rounded, color: colorScheme.primary),
          label: l10n.settingsTab,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final unselectedColor = colorScheme.onSurfaceVariant;

    final destinations = activeTabIds
        .map((id) => _buildDestination(id, l10n, unselectedColor, colorScheme))
        .toList();

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.6),
            width: 1,
          ),
        ),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
              );
            }
            return TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 11.0,
            );
          }),
        ),
        child: NavigationBar(
          selectedIndex: currentIndex.clamp(0, activeTabIds.length - 1),
          backgroundColor: Colors.transparent,
          indicatorColor: colorScheme.primaryContainer,
          elevation: 0,
          onDestinationSelected: (index) {
            if (index == currentIndex) return;
            onTap?.call(index);
          },
          destinations: destinations,
        ),
      ),
    );
  }
}
