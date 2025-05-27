import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/labels/utils/label_translation_utils.dart';

/// 标签文本工具类
/// 提供统一的获取标签文本的方法，避免代码重复
/// 所有方法都会自动根据当前语言环境返回翻译后的文本
class LabelTextUtils {
  /// 根据标签ID获取标签文本
  /// 如果标签不存在，返回null
  /// 返回的文本会根据当前语言环境自动翻译
  static Future<String?> getLabelTextById(BuildContext context, String labelId) async {
    final predefinedLabelService = Provider.of<PredefinedLabelService>(context, listen: false);
    final labelText = await predefinedLabelService.getLabelTextAsync(labelId);
    if (labelText == null) return null;
    
    // 自动翻译标签文本
    return LabelTranslationUtils.translateLabelText(context, labelText);
  }
  
  /// 根据通话记录获取标签文本
  /// 如果通话记录没有标签或标签不存在，返回null
  /// 返回的文本会根据当前语言环境自动翻译
  static Future<String?> getLabelTextFromCallLog(BuildContext context, CallLog log) async {
    if (log.labelIds == null || log.labelIds!.isEmpty) {
      return null;
    }
    
    return await getLabelTextById(context, log.labelIds!.first);
  }
  
  /// 获取多个标签文本
  /// 返回标签文本列表，如果某个标签不存在，对应位置为null
  /// 返回的文本会根据当前语言环境自动翻译
  static Future<List<String?>> getMultipleLabelTexts(BuildContext context, List<String> labelIds) async {
    final predefinedLabelService = Provider.of<PredefinedLabelService>(context, listen: false);
    final labelTexts = await Future.wait(
      labelIds.map((labelId) => predefinedLabelService.getLabelTextAsync(labelId)).toList()
    );
    
    // 自动翻译所有标签文本
    return labelTexts.map((text) => 
      text != null ? LabelTranslationUtils.translateLabelText(context, text) : null
    ).toList();
  }
  
  /// 以下方法保留以兼容现有代码，但内部实现已更新为使用上面的方法
  
  /// 根据标签ID获取翻译后的标签文本
  /// 如果标签不存在，返回null
  /// @deprecated 请直接使用 getLabelTextById，它已经包含翻译功能
  static Future<String?> getTranslatedLabelById(BuildContext context, String labelId) async {
    return await getLabelTextById(context, labelId);
  }
  
  /// 根据通话记录获取翻译后的标签文本
  /// 如果通话记录没有标签或标签不存在，返回null
  /// @deprecated 请直接使用 getLabelTextFromCallLog，它已经包含翻译功能
  static Future<String?> getTranslatedLabelFromCallLog(BuildContext context, CallLog log) async {
    return await getLabelTextFromCallLog(context, log);
  }
  
  /// 获取多个翻译后的标签文本
  /// 返回翻译后的标签文本列表，如果某个标签不存在，对应位置为null
  /// @deprecated 请直接使用 getMultipleLabelTexts，它已经包含翻译功能
  static Future<List<String?>> getMultipleTranslatedLabels(BuildContext context, List<String> labelIds) async {
    return await getMultipleLabelTexts(context, labelIds);
  }
}