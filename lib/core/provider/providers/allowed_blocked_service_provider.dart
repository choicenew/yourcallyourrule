import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';

/// AllowedBlockedService的Provider
final allowedBlockedServiceProvider = Provider<AllowedBlockedService>((ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  return AllowedBlockedService(ruleRepository);
});