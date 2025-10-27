import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_filter_service.dart';

import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';
import '../../../core/provider/providers/config_repository_provider.dart';

/// SimSlotRuleService的Provider
final simSlotRuleServiceProvider = Provider<SimSlotRuleService>((ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final configRepository = ref.watch(configRepositoryProvider);
  return SimSlotRuleService(ruleRepository: ruleRepository, configRepository: configRepository);
});