import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/providers/blocked_call_repository_provider.dart';

import 'caller_id_service_provider.dart';
import 'local_count_filter_service_provider.dart';
import 'remote_number_filter_service_provider.dart';
import 'sim_slot_rule_service_provider.dart';
import 'allowed_blocked_service_provider.dart';
import 'regex_service_provider.dart';
import 'rule_management_service_provider.dart';
import 'config_repository_provider.dart';

/// CallFilterService的Provider
final callFilterServiceProvider = Provider<CallFilterService>((ref) {
  final callerIdService = ref.watch(callerIdServiceProvider);
  final localCountFilterService = ref.watch(localCountFilterServiceProvider);
  final remoteNumberFilterService = ref.watch(remoteNumberFilterServiceProvider);
  final simSlotRuleService = ref.watch(simSlotRuleServiceProvider);
  final allowedBlockedService = ref.watch(allowedBlockedServiceProvider);
  final regexService = ref.watch(regexServiceProvider);
  final blockedCallRepository = ref.watch(blockedCallRepositoryProvider);
  
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