import 'dart:async';


import 'package:yourcallyourrule/core/entities/label/label_entry.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/services/import_export_service.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';

/// 标签服务类，继承自ListService，提供标签的管理功能
/// 包括添加、删除、查询标签等操作
class LabelService extends ListService {
  final RuleRepository _ruleRepository;
  final RuleImportExportService _importExportService;
  
  LabelService(this._ruleRepository) : 
    _importExportService = RuleImportExportService(_ruleRepository),
    super(_ruleRepository);

  // 添加标签条目
  Future<void> addLabel(LabelEntry entry) async {
    await _ruleRepository.save(entry);
  }

  // 批量添加标签条目
  Future<void> addLabels(List<LabelEntry> entries) async {
    for (final entry in entries) {
      await _ruleRepository.save(entry);
    }
  }

  // 更新标签条目
  Future<void> updateLabel(LabelEntry entry) async {
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
  Future<List<LabelEntry>> getAllLabels() async {
    final rules = await _ruleRepository.getAll();
    return rules.whereType<LabelEntry>().toList();
  }

  // 根据电话号码获取标签
  Future<LabelEntry?> getLabelByPhoneNumber(PhoneNumber phoneNumber) async {
    final rules = await getAllLabels();
    try {
      return rules.firstWhere(
        (label) => label.phoneNumber == phoneNumber,
      );
    } catch (e) {
      // firstWhere throws if no element is found, return null in that case
      return null;
    }
  }

  // 根据标签文本获取标签条目
  Future<List<LabelEntry>> getLabelsByText(String labelText) async {
    final rules = await getAllLabels();
    return rules.where((label) => label.label == labelText).toList();
  }

  // 获取所有标签文本
  Future<List<String>> getAllLabelTexts() async {
    final labels = await getAllLabels();
    final labelTexts = <String>{};
    
    for (final label in labels) {
      labelTexts.add(label.label);
    }
    
    return labelTexts.toList();
  }

  // 检查电话号码是否有标签
  Future<bool> hasLabel(PhoneNumber phoneNumber) async {
    final label = await getLabelByPhoneNumber(phoneNumber);
    return label != null;
  }

  // 导入标签从URL
  Future<List<LabelEntry>> importLabelsFromUrl(String url) async {
    final rules = await _importExportService.importFromUrl(url);
    return rules.whereType<LabelEntry>().toList();
  }

  // 从文件导入标签
  Future<List<LabelEntry>> importLabelsFromFile(String filePath, {bool overwrite = false}) async {
    final rules = await _importExportService.importFromFile(
      filePath, 
      mode: overwrite ? ImportMode.overwrite : ImportMode.merge
    );
    return rules.whereType<LabelEntry>().toList();
  }

  // 导出标签到文件
  Future<bool> exportLabelsToFile(String filePath) async {
    final labels = await getAllLabels();
    return await _importExportService.exportToFile(filePath, entities: labels);
  }

  // 插入预定义标签
  Future<void> insertPredefinedLabels(List<Map<String, dynamic>> predefinedLabels) async {
    final existingLabels = await getAllLabelTexts();
    final batch = <LabelEntry>[];

    for (final labelMap in predefinedLabels) {
      final labelText = labelMap['label'] as String;
      if (!existingLabels.contains(labelText)) {
        // 生成一个唯一的 ID，或者让仓库在保存时生成
        final uniqueId = DateTime.now().millisecondsSinceEpoch.toString() + labelText.hashCode.toString();
        final phoneNumber = PhoneNumber.fromString('PLACEHOLDER_${labelText.hashCode}');
        final label = LabelEntry(
          // id: '', // 最好提供一个唯一的 ID 或让仓库处理
          id: uniqueId, // 示例：使用时间戳+哈希码生成唯一ID
          phoneNumber: phoneNumber,
          label: labelText,
          // color: labelMap['color'] as String?, // 移除 color
          icon: labelMap['icon'] as String?,
        );
        batch.add(label);
      }
    }

    if (batch.isNotEmpty) {
      // 使用 repository 的 saveAll 或类似方法批量插入效率更高
      // await addLabels(batch); // 这个方法是逐条保存，效率较低
      await _ruleRepository.saveAll(batch); // 假设仓库有 saveAll 方法
    }
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
}