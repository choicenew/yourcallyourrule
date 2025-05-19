import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yourcallyourrule/core/entities/label/predefined_label_entry.dart';
import 'package:yourcallyourrule/core/repositories/predefined_label_repository.dart';
import 'package:yourcallyourrule/data/database/database_manager.dart';
import 'package:yourcallyourrule/data/models/predefined_label_model.dart';

import 'database_service_provider.dart';

/// 预定义标签仓库提供者
final predefinedLabelRepositoryProvider = Provider<PredefinedLabelRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return PredefinedLabelRepositoryImpl(databaseService.localDatabaseManager);
});

/// 预定义标签仓库实现类
class PredefinedLabelRepositoryImpl implements PredefinedLabelRepository {
  final DatabaseManager _databaseManager;
  final String _tableName = 'predefined_labels';
  
  /// 构造函数
  PredefinedLabelRepositoryImpl(this._databaseManager);
  
  @override
  Future<void> save(PredefinedLabel label) async {
    final db = await _databaseManager.database;
    final model = PredefinedLabelModel.fromEntity(label);
    await db.insert(_tableName, model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  
  @override
  Future<void> saveAll(List<PredefinedLabel> labels) async {
    final db = await _databaseManager.database;
    final batch = db.batch();
    
    for (final label in labels) {
      final model = PredefinedLabelModel.fromEntity(label);
      batch.insert(_tableName, model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    
    await batch.commit();
  }
  
  @override
  Future<void> update(PredefinedLabel label) async {
    final db = await _databaseManager.database;
    final model = PredefinedLabelModel.fromEntity(label);
    await db.update(
      _tableName,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [label.id],
    );
  }
  
  @override
  Future<void> delete(String id) async {
    final db = await _databaseManager.database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  @override
  Future<List<PredefinedLabel>> getAll() async {
    final db = await _databaseManager.database;
    final maps = await db.query(_tableName);
    return maps.map((map) => PredefinedLabelModel.fromMap(map).toEntity()).toList();
  }
  
  @override
  Future<PredefinedLabel?> getById(String id) async {
    final db = await _databaseManager.database;
    final maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    
    if (maps.isEmpty) return null;
    return PredefinedLabelModel.fromMap(maps.first).toEntity();
  }
  
  @override
  Future<List<PredefinedLabel>> getByText(String text) async {
    final db = await _databaseManager.database;
    final maps = await db.query(
      _tableName,
      where: 'text = ?',
      whereArgs: [text],
    );
    
    return maps.map((map) => PredefinedLabelModel.fromMap(map).toEntity()).toList();
  }
  
  @override
  Future<String?> getLabelTextAsync(String id) async {
    final db = await _databaseManager.database;
    final maps = await db.query(
      _tableName,
      columns: ['text'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    
    return maps.isNotEmpty ? maps.first['text'] as String? : id;
  }
}