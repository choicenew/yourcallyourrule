import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/labels/data/repositories/label_phone_repository_impl.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

import 'label_phone_service_provider.dart';

final labelServiceProvider = Provider<LabelService>((ref) {
  final labelPhoneRepository = ref.watch(labelPhoneRepositoryProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  
  return LabelService(labelPhoneRepository, predefinedLabelService);
});

final labelsProvider = Provider<LabelPhoneNotifier>((ref) {
  return ref.read(labelPhonesProvider.notifier);
});

final labelSystemProvider = Provider<LabelService>((ref) {
  return ref.watch(labelServiceProvider);
});
