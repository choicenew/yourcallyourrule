import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';

// 导入Provider
import 'providers/config_repository_provider.dart';
import 'providers/time_interceptor_service_provider.dart';
import 'providers/local_count_filter_service_provider.dart';
import 'providers/remote_number_filter_service_provider.dart';
import 'providers/remote_number_service_provider.dart';
import 'providers/sim_slot_rule_service_provider.dart';
import 'providers/enhanced_composite_filter_service_provider.dart';
import 'providers/sms_subscription_service_provider.dart';
import 'providers/contact_subscription_service_provider.dart';
import 'providers/allowed_blocked_service_provider.dart';
import 'providers/regex_service_provider.dart';
import 'providers/call_filter_service_provider.dart';
import 'providers/sms_filter_service_provider.dart';


/// AppRouter的Riverpod Provider
/// 用于在应用中提供AppRouter的实例
/// 这个版本专门用于支持Riverpod迁移的页面
final appRouterProvider = Provider<AppRouter>((ref) {
  // 获取所需的依赖服务
  final configRepository = ref.watch(configRepositoryProvider);
  final timeInterceptorService = ref.watch(timeInterceptorServiceProvider);
  final localCountFilterService = ref.watch(localCountFilterServiceProvider);
  final remoteNumberFilterService = ref.watch(remoteNumberFilterServiceProvider);
  final remoteNumberService = ref.watch(remoteNumberServiceProvider);
  final simSlotRuleService = ref.watch(simSlotRuleServiceProvider);
  final enhancedCompositeFilterService = ref.watch(enhancedCompositeFilterServiceProvider);
  final smsSubscriptionService = ref.watch(smsSubscriptionServiceProvider);
  final contactSubscriptionService = ref.watch(contactSubscriptionServiceProvider);
  final allowedBlockedService = ref.watch(allowedBlockedServiceProvider);
  final regexService = ref.watch(regexServiceProvider);
  final callFilterService = ref.watch(callFilterServiceProvider);
  final smsFilterService = ref.watch(smsFilterServiceProvider);
  
  // 创建并返回AppRouter实例
  return AppRouter(
    configRepository: configRepository,
    timeInterceptorService: timeInterceptorService,
    localCountFilterService: localCountFilterService,
    remoteNumberFilterService: remoteNumberFilterService,
    remoteNumberService: remoteNumberService,
    simSlotRuleService: simSlotRuleService,
    enhancedCompositeFilterService: enhancedCompositeFilterService,
    smsSubscriptionService: smsSubscriptionService,
    contactSubscriptionService: contactSubscriptionService,
    allowedBlockedService: allowedBlockedService,
    regexService: regexService,
    callFilterService: callFilterService,
    smsFilterService: smsFilterService,
    ref: ref,
  );
});