import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';
import 'package:yourcallyourrule/features/labels/services/mark_phone_service.dart';

/// LabelPhoneService的Provider
final markPhoneServiceProvider = Provider<LabelPhoneService>((ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  return LabelPhoneService(ruleRepository, predefinedLabelService);
});