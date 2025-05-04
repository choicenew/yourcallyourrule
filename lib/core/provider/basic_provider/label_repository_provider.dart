import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/label/label_entry.dart';
import 'package:yourcallyourrule/core/provider/labels_provider.dart';

import 'package:yourcallyourrule/data/database/database_service.dart';

import 'database_service_provider.dart';

/// 标签仓库提供者
final labelRepositoryProvider = Provider<LabelRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // 返回标签仓库实现
  return LabelRepositoryImpl(databaseService);
});

/// 标签仓库实现类
class LabelRepositoryImpl implements LabelRepository {
  final DatabaseService _databaseService;

  LabelRepositoryImpl(this._databaseService);

  @override
  Future<List<LabelEntry>> getAll() async {
    final maps = await _databaseService.queryAll('labels');
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<LabelEntry?> getById(String id) async {
    final map = await _databaseService.queryById('labels', id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<LabelEntry> save(LabelEntry entity) async {
    await _databaseService.insert('labels', entity.toMap());
    return entity;
  }

  @override
  Future<LabelEntry> update(LabelEntry entity) async {
    await _databaseService.update('labels', entity.id, entity.toMap());
    return entity;
  }

  @override
  Future<bool> delete(LabelEntry entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('labels', id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<LabelEntry> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  @override
  Future<List<LabelEntry>> saveAll(List<LabelEntry> entities) async {
    for (var entity in entities) {
      await save(entity);
    }
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final labels = await getAll();
    return labels.length;
  }

  @override
  LabelEntry fromMap(Map<String, dynamic> map) {
    return LabelEntry.fromMap(map);
  }

  @override
  Future<LabelEntry?> getByName(String name) async {
    final maps = await _databaseService.queryWhere('labels', 'name', name);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }

  @override
  Future<List<LabelEntry>> getByType(String type) async {
    final maps = await _databaseService.queryWhere('labels', 'type', type);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<bool> nameExists(String name) async {
    final label = await getByName(name);
    return label != null;
  }

  @override
  Future<List<LabelEntry>> getAllEnabled() async {
    final maps = await _databaseService.queryWhere('labels', 'isEnabled', true);
    return maps.map((map) => fromMap(map)).toList();
  }
}