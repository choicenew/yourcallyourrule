import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';

import 'allowed_blocked_service_provider.dart';
import 'regex_service_provider.dart';
import 'rule_management_service_provider.dart';
import 'config_repository_provider.dart';

/// CallFilterService的Provider
final callFilterServiceProvider = Provider<CallFilterService>((ref) {
  
 
 
 
  final allowedBlockedService = ref.watch(allowedBlockedServiceProvider);
  final regexService = ref.watch(regexServiceProvider);
 
  
  final ruleManagementService = ref.watch(ruleManagementServiceProvider);
  final configRepository = ref.watch(configRepositoryProvider);
  
  final service = CallFilterService(
    allowedBlockedService: allowedBlockedService,
    regexService: regexService,
    ruleManagementService: ruleManagementService,
    configRepository: configRepository,
  );
  
  // 异步初始化
  Future.microtask(() async {
    await service.initialize();
  });
  
  return service;
});