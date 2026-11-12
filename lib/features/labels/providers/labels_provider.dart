import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

import 'label_phone_service_provider.dart';

final labelServiceProvider = Provider<LabelService>((ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  
  return LabelService(ruleRepository, predefinedLabelService);
});

final labelsProvider = Provider<LabelPhoneNotifier>((ref) {
  return ref.read(labelPhonesProvider.notifier);
});

final labelSystemProvider = Provider<LabelService>((ref) {
  final labelService = ref.watch(labelServiceProvider);
  return labelService;
});
