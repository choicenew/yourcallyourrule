import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_history/entities/call_log.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/labels/utils/label_translation_utils.dart';

/// 标签文本工具类
class LabelTextUtils {
  static Future<String?> getLabelTextById(BuildContext context, WidgetRef ref, String labelId) async {
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final labelText = await predefinedLabelService.getLabelTextAsync(labelId);
    if (labelText == null) return null;

    return LabelTranslationUtils.translateLabelText(context, labelText);
  }

  static Future<String?> getLabelTextFromCallLog(BuildContext context, WidgetRef ref, CallLog log) async {
    if (log.labelIds == null || log.labelIds!.isEmpty) {
      return null;
    }

    return await getLabelTextById(context, ref, log.labelIds!.first);
  }

  static Future<List<String?>> getMultipleLabelTexts(BuildContext context, WidgetRef ref, List<String> labelIds) async {
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final labelTexts = await Future.wait(
      labelIds.map((labelId) => predefinedLabelService.getLabelTextAsync(labelId)).toList(),
    );

    return labelTexts.map((text) =>
      text != null ? LabelTranslationUtils.translateLabelText(context, text) : null,
    ).toList();
  }

  static Future<String?> getTranslatedLabelById(BuildContext context, WidgetRef ref, String labelId) async {
    return await getLabelTextById(context, ref, labelId);
  }

  static Future<String?> getTranslatedLabelFromCallLog(BuildContext context, WidgetRef ref, CallLog log) async {
    return await getLabelTextFromCallLog(context, ref, log);
  }

  static Future<List<String?>> getMultipleTranslatedLabels(BuildContext context, WidgetRef ref, List<String> labelIds) async {
    return await getMultipleLabelTexts(context, ref, labelIds);
  }
}
