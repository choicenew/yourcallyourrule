import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/router/app_router.dart' as app_router;

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) {
        if (index == currentIndex) return;
        if (onTap != null) {
          onTap!(index);
        } else {
          BottomNavigationHandler.handleNavigation(context, index);
        }
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.shield_outlined),
          selectedIcon: const Icon(Icons.shield_rounded),
          label: l10n.homeTab,
        ),
        NavigationDestination(
          icon: const Icon(Icons.call_outlined),
          selectedIcon: const Icon(Icons.call_rounded),
          label: l10n.callHistoryTab,
        ),
        NavigationDestination(
          icon: const Icon(Icons.contacts_outlined),
          selectedIcon: const Icon(Icons.contacts_rounded),
          label: l10n.contactsTab,
        ),
        NavigationDestination(
          icon: const Icon(Icons.dashboard_outlined),
          selectedIcon: const Icon(Icons.dashboard_rounded),
          label: l10n.dashboardTab,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings_rounded),
          label: l10n.settingsTab,
        ),
      ],
    );
  }
}

class BottomNavigationHandler {
  static void handleNavigation(BuildContext context, int index) {
    final route = switch (index) {
      0 => '/',
      1 => '/${app_router.AppRouter.callHistory}',
      2 => '/${app_router.AppRouter.contactsManagement}',
      3 => '/${app_router.AppRouter.dashboard}',
      4 => '/${app_router.AppRouter.settings}',
      _ => null,
    };
    if (route != null) {
      context.go(route);
    }
  }
}
