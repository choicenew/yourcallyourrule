import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/pages/sim_slot_rule_page.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/presentation/pages/time_interceptor_settings_page.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/local_filter/presentation/pages/local_filter_settings_page.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/presentation/pages/remote_filter_settings_page.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/presentation/call_filter_settings_page.dart';

/// 应用路由配置
/// 使用GoRouter管理全局路由表
class AppRouter {
  // 服务依赖
  final ConfigRepository configRepository;
  final TimeInterceptorService timeInterceptorService;
  final LocalCountFilterService localCountFilterService;
  final RemoteNumberFilterService remoteNumberFilterService;
  final RemoteNumberService remoteNumberService;
  final SimSlotRuleService simSlotRuleService;
  
  // 构造函数
  AppRouter({
    required this.configRepository,
    required this.timeInterceptorService,
    required this.localCountFilterService,
    required this.remoteNumberFilterService,
    required this.remoteNumberService,
    required this.simSlotRuleService,
  });
  
  // 路由名称常量
  static const String timeInterceptorSettings = 'time-interceptor-settings';
  static const String localFilterSettings = 'local-filter-settings';
  static const String remoteFilterSettings = 'remote-filter-settings';
  static const String simSlotRuleSettings = 'sim-slot-rule-settings';
  static const String callFilterSettings = 'call-filter-settings';
  
  // 创建路由器
  late final router = GoRouter(
    initialLocation: '/',
    routes: [
      // 主页路由
      GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('主页')),
        ),
      ),
      
      // 来电频率拦截设置页面
      GoRoute(
        path: '/$timeInterceptorSettings',
        name: timeInterceptorSettings,
        builder: (context, state) => TimeInterceptorSettingsPage(
          timeInterceptorService: timeInterceptorService,
          configRepository: configRepository,
        ),
      ),
      
      // 本地过滤器设置页面
      GoRoute(
        path: '/$localFilterSettings',
        name: localFilterSettings,
        builder: (context, state) => LocalFilterSettingsPage(
          localCountFilterService: localCountFilterService,
          configRepository: configRepository,
        ),
      ),
      
      // 远程号码过滤器设置页面
      GoRoute(
        path: '/$remoteFilterSettings',
        name: remoteFilterSettings,
        builder: (context, state) => RemoteFilterSettingsPage(
          remoteNumberFilterService: remoteNumberFilterService,
          remoteNumberService: remoteNumberService,
          configRepository: configRepository,
        ),
      ),
      
      // SIM卡槽位规则设置页面
      GoRoute(
        path: '/$simSlotRuleSettings/:simSlotIndex',
        name: simSlotRuleSettings,
        builder: (context, state) {
          final simSlotIndex = int.parse(state.pathParameters['simSlotIndex'] ?? '0');
          return SimSlotRulePage(
            simSlotRuleService: simSlotRuleService,
            enhancedCompositeFilterService: state.extra as dynamic,
            configRepository: configRepository,
            ruleRepository: state.extra as dynamic,
            simSlotIndex: simSlotIndex,
          );
        },
      ),
      
      // 通话过滤设置页面
      GoRoute(
        path: '/$callFilterSettings',
        name: callFilterSettings,
        builder: (context, state) => CallFilterSettingsPage(
          callFilterService: state.extra as dynamic,
        ),
      ),
    ],
  );
  
  // 导航到来电频率拦截设置页面
  void navigateToTimeInterceptorSettings(BuildContext context) {
    context.goNamed(timeInterceptorSettings);
  }
  
  // 导航到本地过滤器设置页面
  void navigateToLocalFilterSettings(BuildContext context) {
    context.goNamed(localFilterSettings);
  }
  
  // 导航到远程号码过滤器设置页面
  void navigateToRemoteFilterSettings(BuildContext context) {
    context.goNamed(remoteFilterSettings);
  }
  
  // 导航到SIM卡槽位规则设置页面
  void navigateToSimSlotRuleSettings(BuildContext context, int simSlotIndex, dynamic extra) {
    context.goNamed(
      simSlotRuleSettings,
      pathParameters: {'simSlotIndex': simSlotIndex.toString()},
      extra: extra,
    );
  }
  
  // 导航到通话过滤设置页面
  void navigateToCallFilterSettings(BuildContext context, dynamic callFilterService) {
    context.goNamed(
      callFilterSettings,
      extra: callFilterService,
    );
  }
}