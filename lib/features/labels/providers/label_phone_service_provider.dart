import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/features/labels/repositories/label_phone_repository.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/labels/data/repositories/label_phone_repository_impl.dart';
import 'package:yourcallyourrule/features/labels/services/mark_phone_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

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
  
  Future<List<LabelPhoneEntry>> getEnabledLabels() async {
    try {
      return await _labelPhoneRepository.getAllEnabled();
    } catch (e) {
      return [];
    }
  }
  
  Future<List<LabelPhoneEntry>> getLabelsByType(String type) async {
    try {
      return await _labelPhoneRepository.getByType(type);
    } catch (e) {
      return [];
    }
  }
  
  Future<LabelPhoneEntry?> getLabelByPhoneNumber(String phoneNumber) async {
    try {
      return await _labelPhoneRepository.getByPhoneNumber(phoneNumber);
    } catch (e) {
      return null;
    }
  }
  
  Future<List<LabelPhoneEntry>> getLabelsByLabelId(String labelId) async {
    try {
      return await _labelPhoneRepository.getByLabelId(labelId);
    } catch (e) {
      return [];
    }
  }
}

final labelPhonesProvider = AsyncNotifierProvider<LabelPhoneNotifier, List<LabelPhoneEntry>>(() {
  return LabelPhoneNotifier();
});

final labelPhoneServiceProvider = Provider<LabelPhoneService>((ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  
  return LabelPhoneService(ruleRepository, predefinedLabelService);
});

final labelPhoneByNumberProvider = FutureProvider.family<dynamic, String>((ref, phoneNumber) async {
  final labelPhoneService = ref.watch(labelPhoneServiceProvider);
  final phoneNumberObj = PhoneNumber.fromString(phoneNumber);
  return await labelPhoneService.getLabelByPhoneNumber(phoneNumberObj);
});

final labelPhoneEntryByNumberProvider = FutureProvider.family<LabelPhoneEntry?, String>((ref, phoneNumber) async {
  final notifier = ref.watch(labelPhonesProvider.notifier);
  return await notifier.getLabelByPhoneNumber(phoneNumber);
});

final labelPhonesByLabelIdProvider = FutureProvider.family<List<dynamic>, String>((ref, labelId) async {
  final labelPhoneService = ref.watch(labelPhoneServiceProvider);
  return await labelPhoneService.getMarksByLabelId(labelId);
});

final labelPhoneViewModelProvider = FutureProvider.family<dynamic, dynamic>((ref, entry) async {
  final labelPhoneService = ref.watch(labelPhoneServiceProvider);
  return await labelPhoneService.getMarkViewModel(entry);
});
