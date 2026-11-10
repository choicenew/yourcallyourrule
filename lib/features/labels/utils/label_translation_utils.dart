import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.g.dart';
import 'package:yourcallyourrule/features/labels/utils/label_translation_extension.dart';

/// 标签翻译工具类
class LabelTranslationUtils {
  static String translateLabelText(BuildContext context, String labelText) {
    return labelText.translate(context);
  }

  static Future<String?> translateLabelById(
    BuildContext context,
    WidgetRef ref,
    String labelId,
  ) async {
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final labelText = await predefinedLabelService.getLabelTextAsync(labelId);
    if (labelText == null) return null;

    return translateLabelText(context, labelText);
  }

  static Future<List<String?>> translateMultipleLabelsById(
    BuildContext context,
    WidgetRef ref,
    List<String> labelIds,
  ) async {
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final labelTexts = await Future.wait(
      labelIds
          .map((labelId) => predefinedLabelService.getLabelTextAsync(labelId))
          .toList(),
    );

    return labelTexts
        .map((text) => text != null ? translateLabelText(context, text) : null)
        .toList();
  }
}
