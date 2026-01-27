import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plugindemo/features/plugin/pages/plugin_management_page_with_ads.dart';

/// 应用路由配置
/// 使用GoRouter管理全局路由表
class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  // 构造函数
  AppRouter();
  
  // 路由名称常量 - 只保留插件相关的
  static const String pluginManagement = 'plugin-management-with-ads';
  static const String home = 'home';

  // 创建路由器 - 只保留插件管理页面路由
  late final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/$pluginManagement',
    routes: [
      // 插件管理页面
      GoRoute(
        path: '/$pluginManagement',
        name: pluginManagement,
        builder: (context, state) => const PluginManagementPageWithAds(),
      ),
      // 主页重定向到插件管理页面
      GoRoute(
        path: '/',
        name: home,
        redirect: (context, state) => '/$pluginManagement',
      ),
    ],
  );
}