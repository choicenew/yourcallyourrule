import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/features/labels/repositories/label_phone_repository.dart';
import 'package:yourcallyourrule/features/labels/data/repositories/label_phone_repository_impl.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';


part 'label_phone_service_provider.g.dart';

@Riverpod(keepAlive: true)
class LabelPhonesNotifier extends _$LabelPhonesNotifier {
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
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return [];
    }
  }

  Future<void> addLabel(LabelPhoneEntry label) async {
    state = const AsyncValue.loading();
    try {
      await _labelPhoneRepository.save(label);
      state = AsyncValue.data(await _loadLabels());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateLabel(LabelPhoneEntry label) async {
    state = const AsyncValue.loading();
    try {
      await _labelPhoneRepository.update(label);
      state = AsyncValue.data(await _loadLabels());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteLabel(String labelId) async {
    state = const AsyncValue.loading();
    try {
      await _labelPhoneRepository.deleteById(labelId);
      state = AsyncValue.data(await _loadLabels());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

@riverpod
Future<LabelPhoneEntry?> labelPhoneByNumber(Ref ref, String number) async {
  final labelService = ref.watch(labelServiceProvider);
  return await labelService.getLabelByPhoneNumber(number);
}
