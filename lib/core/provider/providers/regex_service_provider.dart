import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';
import 'package:yourcallyourrule/features/rules/services/regex_service.dart';

/// RegexService的Provider
final regexServiceProvider = Provider<RegexService>((ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  return RegexService(ruleRepository);
});