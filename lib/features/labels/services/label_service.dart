import 'dart:async';

import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/entities/label/predefined_label_entry.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/services/import_export_service.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/labels/services/mark_phone_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

/// 标签服务类，继承自ListService，提供标签的管理功能
/// 包括添加、删除、查询标签等操作
/// 
/// 最好使用通用的导入导出服务 [RuleImportExportService] 来实现导入和导出功能，不要创建多余的服务导入导出
/// 使用 [LabelPhoneService] 和 [PredefinedLabelService] 来管理标签
/// 
/// 此服务整合了 [LabelPhoneService] 和 [PredefinedLabelService] 的功能，
/// 作为标签系统的统一入口
class LabelService extends ListService {
  final RuleRepository _ruleRepository;
  final RuleImportExportService _importExportService;
  
  // 内部使用的新服务实例
  late final LabelPhoneService _labelPhoneService;
  late final PredefinedLabelService _predefinedLabelService;
  
  LabelService(this._ruleRepository, this._predefinedLabelService) : 
    _importExportService = RuleImportExportService(_ruleRepository),
    super(_ruleRepository) {
    // 初始化电话标签服务
    _labelPhoneService = LabelPhoneService(_ruleRepository, _predefinedLabelService);
  }

  // 添加标签条目
  Future<void> addLabel(LabelPhoneEntry entry) async {
    await _ruleRepository.save(entry);
  }

  // 批量添加标签条目
  Future<void> addLabels(List<LabelPhoneEntry> entries) async {
    for (final entry in entries) {
      await _ruleRepository.save(entry);
    }
  }

  // 更新标签条目
  Future<void> updateLabel(LabelPhoneEntry entry) async {
    await _ruleRepository.update(entry);
  }

  // 删除标签条目
  Future<void> removeLabel(String labelId) async {
    // Fetch the entry first using the ID
    final entryToDelete = await _ruleRepository.getById(labelId);
    if (entryToDelete != null) {
      // Pass the actual RuleBase object to delete
      await _ruleRepository.delete(entryToDelete);
    }
    // Optionally handle the case where the entry with labelId doesn't exist
  }

  // 获取所有标签条目
  Future<List<LabelPhoneEntry>> getAllLabels() async {
    final rules = await _ruleRepository.getAll();
    return rules.whereType<LabelPhoneEntry>().toList();
  }

  // 根据电话号码获取标签
  Future<LabelPhoneEntry?> getLabelByPhoneNumber(PhoneNumber phoneNumber) async {
    // 委托给新的电话标签服务
    return await _labelPhoneService.getLabelByPhoneNumber(phoneNumber);
  }
  
  /// 根据电话号码字符串获取标签
  Future<LabelPhoneEntry?> getLabelByPhoneNumberString(String phoneNumberStr) async {
    if (phoneNumberStr.isEmpty) return null;
    final phoneNumber = PhoneNumber.fromString(phoneNumberStr);
    return await getLabelByPhoneNumber(phoneNumber);
  }

  // 根据标签ID获取标签条目
  Future<List<LabelPhoneEntry>> getLabelsByLabelId(String labelId) async {
    // 委托给新的电话标签服务
    return await _labelPhoneService.getMarksByLabelId(labelId);
  }

  // 获取所有标签ID
  Future<List<String>> getAllLabelIds() async {
    final labels = await getAllLabels();
    final labelIds = <String>{};
    
    for (final label in labels) {
      labelIds.add(label.labelId);
    }
    
    return labelIds.toList();
  }

  // 检查电话号码是否有标签
  Future<bool> hasLabel(PhoneNumber phoneNumber) async {
    // 委托给新的电话标签服务
    return await _labelPhoneService.isPhoneMarked(phoneNumber);
  }

  // 导入标签从URL
  Future<List<LabelPhoneEntry>> importLabelsFromUrl(String url) async {
    final rules = await _importExportService.importFromUrl(url);
    return rules.whereType<LabelPhoneEntry>().toList();
  }

  // 从文件导入标签
  Future<List<LabelPhoneEntry>> importLabelsFromFile(String filePath, {bool overwrite = false}) async {
    final rules = await _importExportService.importFromFile(
      filePath, 
      mode: overwrite ? ImportMode.overwrite : ImportMode.merge
    );
    return rules.whereType<LabelPhoneEntry>().toList();
  }

  // 导出标签到文件
  Future<bool> exportLabelsToFile(String filePath) async {
    final labels = await getAllLabels();
    return await _importExportService.exportToFile(filePath, entities: labels);
  }

  // 插入预定义标签
  Future<void> insertPredefinedLabels(List<Map<String, dynamic>> predefinedLabels) async {
    // 委托给预定义标签服务
    await _predefinedLabelService.insertPredefinedLabels(predefinedLabels);
  }
  
  // 导出标签为CSV格式
  Future<String> exportLabelsAsCsv() async {
    final labels = await getAllLabels();
    final data = await _importExportService.prepareCsvForExport(labels);
    return data;
  }
  
  // 导出标签为JSON格式
  Future<String> exportLabelsAsJson() async {
    final labels = await getAllLabels();
    final data = await _importExportService.prepareJsonForExport(labels);
    return data;
  }
  
  /// 获取所有预定义标签
  Future<List<PredefinedLabel>> getAllPredefinedLabels() async {
    return await _predefinedLabelService.getAllLabels();
  }
  
  /// 获取启用的标签
  Future<List<LabelPhoneEntry>> getEnabledLabels() async {
    final labels = await getAllLabels();
    return labels.where((label) => label.isEnabled).toList();
  }
  
  /// 删除标签（别名方法，与removeLabel功能相同）
  Future<void> deleteLabel(String labelId) async {
    await removeLabel(labelId);
  }
}