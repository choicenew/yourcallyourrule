import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/labels/data/repositories/label_phone_repository_impl.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'predefined_labels_provider.dart';

part 'labels_provider.g.dart';

@Riverpod(keepAlive: true)
LabelService labelService(Ref ref) {
  final labelPhoneRepository = ref.watch(labelPhoneRepositoryProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);

  return LabelService(labelPhoneRepository, predefinedLabelService);
}

@Riverpod(keepAlive: true)
LabelService labelSystem(Ref ref) {
  return ref.watch(labelServiceProvider);
}
