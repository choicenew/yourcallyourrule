import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/features/labels/repositories/predefined_label_repository.dart';
import 'package:yourcallyourrule/features/labels/data/repositories/predefined_label_repository_impl.dart';

part 'predefined_label_service.g.dart';

/// PredefinedLabelService Riverpod Provider
@Riverpod(keepAlive: true)
PredefinedLabelService predefinedLabelService(Ref ref) {
  final predefinedLabelRepository = ref.watch(predefinedLabelRepositoryProvider);
  return PredefinedLabelService(predefinedLabelRepository);
}

/// 预定义标签服务类
class PredefinedLabelService {
  final PredefinedLabelRepository _repository;
  final Uuid _uuid = const Uuid();

  PredefinedLabelService(this._repository);

  Future<PredefinedLabel> createLabel(String text, {String? avatar, String? icon}) async {
    final label = PredefinedLabel.create(text, avatar: avatar, icon: icon);
    await _repository.save(label);
    return label;
  }

  Future<PredefinedLabel> createLabelFromEnglishName(
    String englishName, {
    String? displayText,
    String? avatar,
    String? icon,
  }) async {
    final label = PredefinedLabel.fromEnglishName(
      englishName,
      displayText: displayText,
      avatar: avatar,
      icon: icon,
    );
    await _repository.save(label);
    return label;
  }

  Future<List<PredefinedLabel>> getAllLabels() async {
    return await _repository.getAll();
  }

  Future<PredefinedLabel?> getLabelById(String id) async {
    return await _repository.getById(id);
  }

  Future<String?> getLabelTextAsync(String id) async {
    return await _repository.getLabelTextAsync(id);
  }

  Future<List<PredefinedLabel>> getLabelsByText(String text) async {
    return await _repository.getByText(text);
  }

  Future<String?> getLabelIdByText(String text) async {
    return await _repository.getIdByText(text);
  }

  Future<void> updateLabel(PredefinedLabel label) async {
    await _repository.update(label);
  }

  Future<void> deleteLabel(String id) async {
    await _repository.delete(id);
  }

  Future<List<PredefinedLabel>> insertPredefinedLabels(List<Map<String, dynamic>> predefinedLabels) async {
    final existingLabels = await getAllLabels();
    final existingTexts = existingLabels.map((e) => e.text).toSet();
    final existingIds = existingLabels.map((e) => e.id).toSet();
    final result = <PredefinedLabel>[];
    final labelsToSave = <PredefinedLabel>[];

    for (final labelMap in predefinedLabels) {
      final labelText = labelMap['label'] as String;
      if (!existingTexts.contains(labelText)) {
        final label = PredefinedLabel.create(
          labelText,
          icon: labelMap['icon'] as String?,
          avatar: labelMap['avatar'] as String?,
        );

        String finalId = label.id;
        int suffix = 1;
        while (existingIds.contains(finalId)) {
          finalId = '${label.id}_$suffix';
          suffix++;
        }

        final finalLabel = finalId != label.id
            ? PredefinedLabel(
                id: finalId,
                text: label.text,
                icon: label.icon,
                avatar: label.avatar,
              )
            : label;

        labelsToSave.add(finalLabel);
        result.add(finalLabel);
        existingIds.add(finalId);
      }
    }

    if (labelsToSave.isNotEmpty) {
      await _repository.saveAll(labelsToSave);
    }

    return result;
  }

  Future<List<String>> getAllLabelTexts() async {
    final labels = await getAllLabels();
    return labels.map((e) => e.text).toList();
  }
}
