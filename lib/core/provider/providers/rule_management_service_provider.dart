import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';

/// RuleManagementService的Provider
final ruleManagementServiceProvider = Provider<RuleManagementService>((ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  return RuleManagementService(ruleRepository);
});