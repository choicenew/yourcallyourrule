import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plugindemo/features/plugin/pages/plugin_management_page.dart';

/// 应用路由配置
class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  AppRouter();

  static const String pluginManagement = 'plugin-management';
  static const String home = 'home';

  late final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/$pluginManagement',
    routes: [
      GoRoute(
        path: '/$pluginManagement',
        name: pluginManagement,
        builder: (context, state) => const PluginManagementPage(),
      ),
      GoRoute(
        path: '/',
        name: home,
        redirect: (context, state) => '/$pluginManagement',
      ),
    ],
  );
}
