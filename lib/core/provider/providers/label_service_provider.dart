import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';
import 'predefined_label_service_provider.dart';

/// LabelService的Provider
final labelServiceProvider = Provider<LabelService>((ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  return LabelService(ruleRepository, predefinedLabelService);
});