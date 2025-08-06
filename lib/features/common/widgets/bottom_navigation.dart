import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFFFF9800),
      unselectedItemColor: Colors.grey,
      items:  [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: AppLocalizations.of(context)!.homeTab,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.call),
          label: AppLocalizations.of(context)!.callHistoryTab,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.contacts),
          label: AppLocalizations.of(context)!.contactsTab,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.dashboard),
          label: AppLocalizations.of(context)!.dashboardTab,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: AppLocalizations.of(context)!.settingsTab,
        ),
      ],
    );
  }
}

class AppRouter {
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
        context.go('/${app_router.AppRouter.callStatistics}');
        break;
      case 4:
        context.go('/${app_router.AppRouter.settings}');
        break;
    }
  }
}