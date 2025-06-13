import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/call_filter_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/sim_slot_rule_service_provider.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';

/// EnhancedCompositeFilterService的Provider
final enhancedCompositeFilterServiceProvider = Provider<EnhancedCompositeFilterService>((ref) {
  final callFilterService = ref.watch(callFilterServiceProvider);
  final simSlotRuleService = ref.watch(simSlotRuleServiceProvider);
  final configRepository = ref.watch(configRepositoryProvider);
  
  return EnhancedCompositeFilterService(
    filters: [callFilterService],
    simSlotRuleService: simSlotRuleService,
    configRepository: configRepository,
  );
});