import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/predefined_label_repository_provider.dart';

/// PredefinedLabelService的Provider
final predefinedLabelServiceProvider = Provider<PredefinedLabelService>((ref) {
  final predefinedLabelRepository = ref.watch(predefinedLabelRepositoryProvider);
  return PredefinedLabelService(predefinedLabelRepository);
});