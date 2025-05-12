import 'dart:async';

import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/label/predefined_label_entry.dart';
import 'package:yourcallyourrule/core/repositories/predefined_label_repository.dart';

/// 预定义标签服务类
/// 负责创建和管理标签的基本属性（文本、图标、头像等）
class PredefinedLabelService {
  final PredefinedLabelRepository _repository;
  final Uuid _uuid = Uuid();

  /// 构造函数
  PredefinedLabelService(this._repository);

  /// 创建新标签（使用有意义的ID）
  Future<PredefinedLabel> createLabel(String text, {String? avatar, String? icon}) async {
    // 使用PredefinedLabel.create工厂方法创建标签，它会生成有意义的ID
    final label = PredefinedLabel.create(text, avatar: avatar, icon: icon);
    
    await _repository.save(label);
    return label;
  }
  
  /// 从英文名创建标签
  Future<PredefinedLabel> createLabelFromEnglishName(
    String englishName, {
    String? displayText,
    String? avatar,
    String? icon,
  }) async {
    // 使用PredefinedLabel.fromEnglishName工厂方法创建标签
    final label = PredefinedLabel.fromEnglishName(
      englishName,
      displayText: displayText,
      avatar: avatar,
      icon: icon,
    );
    
    await _repository.save(label);
    return label;
  }

  /// 获取所有标签
  Future<List<PredefinedLabel>> getAllLabels() async {
    return await _repository.getAll();
  }

  /// 根据ID获取标签
  Future<PredefinedLabel?> getLabelById(String id) async {
    return await _repository.getById(id);
  }
  
  /// 根据文本获取标签
  Future<List<PredefinedLabel>> getLabelsByText(String text) async {
    return await _repository.getByText(text);
  }

  /// 更新标签
  Future<void> updateLabel(PredefinedLabel label) async {
    await _repository.update(label);
  }

  /// 删除标签
  Future<void> deleteLabel(String id) async {
    await _repository.delete(id);
  }
  
  /// 批量插入预定义标签（使用有意义的ID）
  Future<List<PredefinedLabel>> insertPredefinedLabels(List<Map<String, dynamic>> predefinedLabels) async {
    final existingLabels = await getAllLabels();
    final existingTexts = existingLabels.map((e) => e.text).toSet();
    final existingIds = existingLabels.map((e) => e.id).toSet();
    final result = <PredefinedLabel>[];
    final labelsToSave = <PredefinedLabel>[];
    
    for (final labelMap in predefinedLabels) {
      final labelText = labelMap['label'] as String;
      if (!existingTexts.contains(labelText)) {
        // 使用PredefinedLabel.create工厂方法创建标签，它会生成有意义的ID
        final label = PredefinedLabel.create(
          labelText,
          icon: labelMap['icon'] as String?,
          avatar: labelMap['avatar'] as String?,
        );
        
        // 检查ID是否已存在，如果存在则添加后缀
        String finalId = label.id;
        int suffix = 1;
        while (existingIds.contains(finalId)) {
          finalId = '${label.id}_$suffix';
          suffix++;
        }
        
        // 如果ID发生了变化，创建一个新的标签对象
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
        existingIds.add(finalId); // 添加到已存在ID集合中，防止后续重复
      }
    }
    
    if (labelsToSave.isNotEmpty) {
      await _repository.saveAll(labelsToSave);
    }
    
    return result;
  }
  
  /// 获取所有标签文本
  Future<List<String>> getAllLabelTexts() async {
    final labels = await getAllLabels();
    return labels.map((e) => e.text).toList();
  }
}