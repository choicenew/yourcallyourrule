import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/features/labels/repositories/label_phone_repository.dart';
import 'package:yourcallyourrule/features/labels/data/repositories/label_phone_repository_impl.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';

class LabelPhoneNotifier extends AsyncNotifier<List<LabelPhoneEntry>> {
  late final LabelPhoneRepository _labelPhoneRepository;

  @override
  Future<List<LabelPhoneEntry>> build() async {
    _initRepository();
    return _loadLabels();
  }

  void _initRepository() {
    _labelPhoneRepository = ref.read(labelPhoneRepositoryProvider);
  }

  Future<List<LabelPhoneEntry>> _loadLabels() async {
    try {
      return await _labelPhoneRepository.getAll();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  Future<void> addLabel(LabelPhoneEntry label) async {
    state = const AsyncValue.loading();
    try {
      await _labelPhoneRepository.save(label);
      state = AsyncValue.data(await _loadLabels());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateLabel(LabelPhoneEntry label) async {
    state = const AsyncValue.loading();
    try {
      await _labelPhoneRepository.update(label);
      state = AsyncValue.data(await _loadLabels());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteLabel(String labelId) async {
    state = const AsyncValue.loading();
    try {
      await _labelPhoneRepository.deleteById(labelId);
      state = AsyncValue.data(await _loadLabels());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final labelPhonesProvider = AsyncNotifierProvider<LabelPhoneNotifier, List<LabelPhoneEntry>>(() {
  return LabelPhoneNotifier();
});

final labelPhoneByNumberProvider = FutureProvider.family<LabelPhoneEntry?, String>((ref, number) async {
  final labelService = ref.watch(labelServiceProvider);
  return await labelService.getLabelByPhoneNumber(number);
});
