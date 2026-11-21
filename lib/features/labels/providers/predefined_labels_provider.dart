import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/features/labels/repositories/predefined_label_repository.dart';
import 'package:yourcallyourrule/features/labels/data/repositories/predefined_label_repository_impl.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

part 'predefined_labels_provider.g.dart';

@Riverpod(keepAlive: true)
class PredefinedLabelsNotifier extends _$PredefinedLabelsNotifier {
  late final PredefinedLabelRepository _repository;

  @override
  Future<List<PredefinedLabel>> build() async {
    _repository = ref.read(predefinedLabelRepositoryProvider);
    return _loadLabels();
  }

  Future<List<PredefinedLabel>> _loadLabels() async {
    try {
      return await _repository.getAll();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return [];
    }
  }

  Future<void> addLabel(PredefinedLabel label) async {
    state = const AsyncValue.loading();
    try {
      await _repository.save(label);
      state = AsyncValue.data(await _loadLabels());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateLabel(PredefinedLabel label) async {
    state = const AsyncValue.loading();
    try {
      await _repository.update(label);
      state = AsyncValue.data(await _loadLabels());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteLabel(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repository.delete(id);
      state = AsyncValue.data(await _loadLabels());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addPredefinedLabels(List<Map<String, dynamic>> predefinedLabels) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(predefinedLabelServiceProvider);
      await service.insertPredefinedLabels(predefinedLabels);
      state = AsyncValue.data(await _loadLabels());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<PredefinedLabel?> getLabelById(String id) async {
    try {
      return await _repository.getById(id);
    } catch (e) {
      return null;
    }
  }

  Future<List<PredefinedLabel>> searchLabelsByText(String text) async {
    try {
      return await _repository.getByText(text);
    } catch (e) {
      return [];
    }
  }
}

@riverpod
Future<PredefinedLabel?> predefinedLabelById(Ref ref, String id) async {
  final notifier = ref.watch(predefinedLabelsNotifierProvider.notifier);
  return await notifier.getLabelById(id);
}
