import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/predefined_labels_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 标签翻译工具类
/// 提供统一的标签翻译方法，支持通过标签文本或标签ID进行翻译
/// 对于自定义标签（非预设标签），将返回原始文本
class LabelTranslationUtils {
  /// 根据标签文本获取翻译后的文本
  /// 如果没有对应的翻译，则返回原始文本
  static String translateLabelText(BuildContext context, String labelText) {
    return labelText.translate(context);
  }
  
  /// 根据标签ID获取翻译后的文本
  /// 如果标签不存在，返回null
  /// 如果没有对应的翻译，则返回原始标签文本
  static Future<String?> translateLabelById(BuildContext context, WidgetRef ref, String labelId) async {
    // 直接从PredefinedLabelService获取标签文本
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final labelText = await predefinedLabelService.getLabelTextAsync(labelId);
    if (labelText == null) return null;
    
    // 然后翻译标签文本，如果没有翻译则返回原始文本
    return translateLabelText(context, labelText);
  }
  
  /// 根据多个标签ID获取翻译后的文本列表
  /// 返回翻译后的文本列表，如果某个标签不存在，对应位置为null
  /// 如果某个标签没有对应的翻译，则返回原始标签文本
  static Future<List<String?>> translateMultipleLabelsById(BuildContext context, WidgetRef ref, List<String> labelIds) async {
    // 直接从PredefinedLabelService获取所有标签文本
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final labelTexts = await Future.wait(
      labelIds.map((labelId) => predefinedLabelService.getLabelTextAsync(labelId)).toList()
    );
    
    // 然后翻译每个标签文本，如果没有翻译则返回原始文本
    return labelTexts.map((text) => text != null ? translateLabelText(context, text) : null).toList();
  }
}

/// 标签翻译扩展
/// 从 public_select_label.dart 移植过来，使其可以在整个应用中使用
extension LabelTranslationExtension on String {
  String translate(BuildContext context) {
    // 使用AppLocalizations进行标签翻译
    // 这种方式比使用硬编码的映射更加灵活和可维护
    final appLocalizations = AppLocalizations.of(context);
    if (appLocalizations == null) return this;
    
    // 将标签文本转换为小写并移除空格，以便匹配属性名
    final normalizedLabel = toLowerCase().replaceAll(' ', '');

    final translations = {
      'fraudscamlikely': appLocalizations.fraudScamLikely,
      'spamlikely': appLocalizations.spamLikely,
      'scamslikely': appLocalizations.scamsLikely,
      'telemarketing': appLocalizations.telemarketing,
      'robocall': appLocalizations.robocall,
      'delivery': appLocalizations.delivery,
      'takeaway': appLocalizations.takeaway,
      'ridesharing': appLocalizations.ridesharing,
      'insurance': appLocalizations.insurance,
      'loan': appLocalizations.loan,
      'customerservice': appLocalizations.customerService,
      'unknown': appLocalizations.unknown,
      'financial': appLocalizations.financial,
      'bank': appLocalizations.bank,
      'education': appLocalizations.education,
      'medical': appLocalizations.medical,
      'charity': appLocalizations.charity,
      'other': appLocalizations.other,
      'debtcollection': appLocalizations.collection,
      'collection': appLocalizations.collection,
      'survey': appLocalizations.survey,
      'political': appLocalizations.political,
      'ecommerce': appLocalizations.ecommerce,
      'risk': appLocalizations.risk,
      'agent': appLocalizations.agent,
      'recruiter': appLocalizations.recruiter,
      'headhunter': appLocalizations.headhunter,
      'silentcallvoiceclone': appLocalizations.silentCallVoiceClone,
      'internet': appLocalizations.internet,
      'travelticketing': appLocalizations.travelTicketing,
      'applicationsoftware': appLocalizations.applicationSoftware,
      'entertainment': appLocalizations.entertainment,
      'government': appLocalizations.government,
      'localservices': appLocalizations.localServices,
      'automotiveindustry': appLocalizations.automotiveIndustry,
      'carrental': appLocalizations.carRental,
      'telecommunication': appLocalizations.telecommunication,
    };

    return translations[normalizedLabel] ?? this;
  }
}