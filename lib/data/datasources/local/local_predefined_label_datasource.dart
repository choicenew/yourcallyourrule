// local_predefined_label_data_source.dart

import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart' hide Column; 
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

import '../../../data/models/predefined_label_model.dart';
import '../datasource_interface.dart';

/// 本地预定义标签数据源实现 (使用 Drift)
class LocalPredefinedLabelDataSource implements LocalDataSource<PredefinedLabelModel> {
  
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid(); // 使用 Uuid 实例
  
  LocalPredefinedLabelDataSource(this._database);
  
  // --- 辅助方法: 数据转换 ---

  /// 将 Drift 生成的 PredefinedLabelData (数据库行数据) 转换为 PredefinedLabelModel
  PredefinedLabelModel _fromData(PredefinedLabelData data) {
    return PredefinedLabelModel(
      id: data.id,
      text: data.labelText, 
      avatar: data.avatar,
      icon: data.icon,
    );
  }

  /// 将 PredefinedLabelModel (应用模型) 转换为 Drift Companion (用于写入数据库)
  /// 注意：这里不处理 ID 的生成逻辑，如果 Model.id 为空，我们直接传入空字符串。
  /// ID 的生成和注入将在 insert/insertAll 方法中通过 Companion.copyWith 完成。
  PredefinedLabelsCompanion _toCompanion(PredefinedLabelModel model) {
    return PredefinedLabelsCompanion(
      id: Value(model.id), // 如果 model.id 为空，则传入空字符串，稍后修正
      labelText: Value(model.text),
      avatar: Value(model.avatar),
      icon: Value(model.icon),
    );
  }

  // --- CRUD 操作 ---

  // 获取所有预定义标签
  @override
  Future<List<PredefinedLabelModel>> getAll() async {
    final results = await _database.select(_database.predefinedLabels).get();
    return results.map(_fromData).toList();
  }
  
  // 根据ID获取预定义标签
  @override
  Future<PredefinedLabelModel?> getById(String id) async {
    final query = _database.select(_database.predefinedLabels)
      ..where((tbl) => tbl.id.equals(id));
      
    final result = await query.getSingleOrNull();
    
    return result != null ? _fromData(result) : null;
  }
  
  // 根据文本模糊查询预定义标签
  Future<List<PredefinedLabelModel>> getByText(String text) async {
    final query = _database.select(_database.predefinedLabels)
      ..where((tbl) => tbl.labelText.like('%$text%'));
      
    final results = await query.get();
    return results.map(_fromData).toList();
  }
  
  /// 根据文本精确查找标签ID
  Future<String?> getIdByExactText(String text) async {
    final query = _database.selectOnly(_database.predefinedLabels)
      ..addColumns([_database.predefinedLabels.id])
      ..where(_database.predefinedLabels.labelText.equals(text))
      ..limit(1); 
      
    final result = await query.getSingleOrNull();
    return result?.read(_database.predefinedLabels.id);
  }


  // 插入预定义标签 (使用 Companion.copyWith 注入 ID)
  @override
  Future<String> insert(PredefinedLabelModel label) async {
    final id = label.id.isEmpty ? _uuid.v4() : label.id;
    
    // 1. 创建 Companion
    final companion = _toCompanion(label);
    
    // 2. 使用 Companion.copyWith 注入生成的 ID
    final companionWithId = companion.copyWith(id: Value(id));
    
    // 3. 插入
    await _database.into(_database.predefinedLabels).insert(
      companionWithId, 
      mode: InsertMode.insertOrReplace // 相当于 ConflictAlgorithm.replace
    );
    
    return id;
  }
  
  // 更新预定义标签
  @override
  Future<int> update(PredefinedLabelModel label) async {
    final companion = _toCompanion(label);
    
    final updatedRows = await (_database.update(_database.predefinedLabels)
      ..where((tbl) => tbl.id.equals(label.id)))
      .write(companion);
      
    return updatedRows;
  }
  
  // 删除预定义标签
  @override
  Future<int> delete(String id) async {
    return await (_database.delete(_database.predefinedLabels)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }
  
  // 批量插入预定义标签
  @override
  Future<List<String>> insertAll(List<PredefinedLabelModel> labels) async {
    final List<String> ids = [];
    
    await _database.batch((batch) {
      for (final label in labels) {
        final id = label.id.isEmpty ? _uuid.v4() : label.id;
        ids.add(id);

        final companion = _toCompanion(label);
        // 使用 Companion.copyWith 注入 ID
        final companionWithId = companion.copyWith(id: Value(id));

        batch.insert(
          _database.predefinedLabels,
          companionWithId,
          mode: InsertMode.insertOrReplace, 
        );
      }
    });
    
    return ids;
  }
  
  // 批量更新预定义标签
  @override
  Future<int> updateAll(List<PredefinedLabelModel> labels) async {
    
    await _database.batch((batch) {
      for (final label in labels) {
        batch.update(
          _database.predefinedLabels,
          _toCompanion(label),
          where: (tbl) => tbl.id.equals(label.id),
        );
      }
    });
    
    return labels.length;
  }
  
  // 批量删除预定义标签
  @override
  Future<int> deleteAll(List<String> ids) async {
    return await (_database.delete(_database.predefinedLabels)
      ..where((tbl) => tbl.id.isIn(ids)))
      .go();
  }
  
  // 清空所有预定义标签
  @override
  Future<void> clear() async {
    await _database.delete(_database.predefinedLabels).go();
  }
  
  // 导出/导入逻辑不变
  @override
  Future<String> exportData() async {
    final labels = await getAll();
    final List<Map<String, dynamic>> labelMaps = labels.map((label) => label.toMap()).toList();
    return jsonEncode(labelMaps);
  }
  
  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> labelMaps = jsonDecode(data) as List<dynamic>;
      final List<PredefinedLabelModel> labels = labelMaps.map((map) => PredefinedLabelModel.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(labels);
      return true;
    } catch (e) {
      // 错误处理，例如日志记录
      return false;
    }
  }
  
  // 批量插入预定义标签数据
  Future<bool> insertPredefinedLabels(List<Map<String, dynamic>> predefinedLabels) async {
    try {
      final labels = predefinedLabels.map((map) => PredefinedLabelModel.fromMap(map)).toList();
      await insertAll(labels);
      return true;
    } catch (e) {
      return false;
    }
  }
}