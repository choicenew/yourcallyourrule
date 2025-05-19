import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

/// 标签文本工具类
/// 提供统一的获取标签文本的方法，避免代码重复
class LabelTextUtils {
  /// 根据标签ID获取标签文本
  /// 如果标签不存在，返回null
  static Future<String?> getLabelTextById(BuildContext context, String labelId) async {
    final predefinedLabelService = Provider.of<PredefinedLabelService>(context, listen: false);
    return await predefinedLabelService.getLabelTextAsync(labelId);
  }
  
  /// 根据通话记录获取标签文本
  /// 如果通话记录没有标签或标签不存在，返回null
  static Future<String?> getLabelTextFromCallLog(BuildContext context, CallLog log) async {
    if (log.labelIds == null || log.labelIds!.isEmpty) {
      return null;
    }
    
    return await getLabelTextById(context, log.labelIds!.first);
  }
  
  /// 获取多个标签文本
  /// 返回标签文本列表，如果某个标签不存在，对应位置为null
  static Future<List<String?>> getMultipleLabelTexts(BuildContext context, List<String> labelIds) async {
    final predefinedLabelService = Provider.of<PredefinedLabelService>(context, listen: false);
    return Future.wait(
      labelIds.map((labelId) => predefinedLabelService.getLabelTextAsync(labelId)).toList()
    );
  }
}