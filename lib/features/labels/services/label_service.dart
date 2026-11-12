import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/features/labels/repositories/label_phone_repository.dart';
import 'package:yourcallyourrule/features/labels/data/repositories/label_phone_repository_impl.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

part 'label_service.g.dart';

/// LabelService Provider
@Riverpod(keepAlive: true)
LabelService labelService(Ref ref) {
  final repo = ref.watch(labelPhoneRepositoryProvider);
  final predefinedSvc = ref.watch(predefinedLabelServiceProvider);
  return LabelService(repo, predefinedSvc);
}

/// 标签服务类
class LabelService {
  final LabelPhoneRepository _repo;
  final PredefinedLabelService _predefinedSvc;

  LabelService(this._repo, this._predefinedSvc);

  Future<void> addLabel(LabelPhoneEntry entry) async {
    await (_repo as dynamic).saveLabel(entry as dynamic);
  }

  Future<void> addLabels(List<LabelPhoneEntry> entries) async {
    await (_repo as dynamic).saveAllLabels(entries);
  }

  Future<void> updateLabel(LabelPhoneEntry entry) async {
    await (_repo as dynamic).updateLabel(entry);
  }

  Future<void> removeLabel(String labelId) async {
    await _repo.deleteById(labelId);
  }

  Future<List<LabelPhoneEntry>> getAllLabels() async {
    return await _repo.getAll();
  }

  Future<LabelPhoneEntry?> getLabelByPhoneNumber(String phoneNumberStr) async {
    return await _repo.getByPhoneNumber(phoneNumberStr);
  }

  Future<List<LabelPhoneEntry>> getLabelsByLabelId(String labelId) async {
    return await _repo.getByLabelId(labelId);
  }

  Future<List<String>> getAllLabelIds() async {
    final labels = await getAllLabels();
    return labels.map((l) => l.labelId).toSet().toList();
  }

  Future<void> insertPredefinedLabels(List<Map<String, dynamic>> predefinedLabels) async {
    await _predefinedSvc.insertPredefinedLabels(predefinedLabels);
  }

  Future<List<PredefinedLabel>> getAllPredefinedLabels() async {
    return await _predefinedSvc.getAllLabels();
  }

  Future<List<LabelPhoneEntry>> getEnabledLabels() async {
    return await _repo.getAllEnabled();
  }

  Future<void> deleteLabel(String labelId) async {
    await removeLabel(labelId);
  }

  Future<bool> importLabelsFromFile(String filePath) async {
    return true;
  }

  Future<String?> exportLabelsToFile(String directoryPath) async {
    return null;
  }
}
