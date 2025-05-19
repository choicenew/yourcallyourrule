import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '首页',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.call),
          label: '通话历史',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contacts),
          label: '联系人',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: '仪表盘',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '设置',
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
        context.go('/call-history');
        break;
      case 2:
        context.go('/contacts');
        break;
      case 3:
        context.go('/dashboard');
        break;
      case 4:
        context.go('/settings');
        break;
    }
  }
}