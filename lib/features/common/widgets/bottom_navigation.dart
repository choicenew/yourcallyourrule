// 文件：lib/features/common/widgets/bottom_navigation.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
// 注意：这里的 as app_router 仍然需要，因为它被下面的 handleNavigation 方法使用了
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
      selectedItemColor: const Color(0xFFFF9800),
      unselectedItemColor:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[400]
              : Colors.grey,
      items: [
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