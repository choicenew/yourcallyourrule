import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/repositories/label_phone_repository.dart';

import 'package:yourcallyourrule/data/database/database_service.dart';

import 'database_service_provider.dart';

/// 电话标签仓库提供者
final labelPhoneRepositoryProvider = Provider<LabelPhoneRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // 返回电话标签仓库实现
  return LabelPhoneRepositoryImpl(databaseService);
});

/// 电话标签仓库实现类
class LabelPhoneRepositoryImpl implements LabelPhoneRepository {
  final DatabaseService _databaseService;

  LabelPhoneRepositoryImpl(this._databaseService);

  @override
  Future<List<LabelPhoneEntry>> getAll() async {
    final maps = await _databaseService.queryAll('labels');
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<LabelPhoneEntry?> getById(String id) async {
    final map = await _databaseService.queryById('labels', id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<LabelPhoneEntry> save(LabelPhoneEntry entity) async {
    await _databaseService.insert('labels', entity.toMap());
    return entity;
  }

  @override
  Future<LabelPhoneEntry> update(LabelPhoneEntry entity) async {
    await _databaseService.update('labels', entity.id, entity.toMap());
    return entity;
  }

  @override
  Future<bool> delete(LabelPhoneEntry entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('labels', id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<LabelPhoneEntry> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  @override
  Future<List<LabelPhoneEntry>> saveAll(List<LabelPhoneEntry> entities) async {
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
  LabelPhoneEntry fromMap(Map<String, dynamic> map) {
    return LabelPhoneEntry.fromMap(map);
  }

  @override
  Future<LabelPhoneEntry?> getByName(String name) async {
    final maps = await _databaseService.queryWhere('labels', 'name', name);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }

  @override
  Future<List<LabelPhoneEntry>> getByType(String type) async {
    final maps = await _databaseService.queryWhere('labels', 'type', type);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<bool> nameExists(String name) async {
    final label = await getByName(name);
    return label != null;
  }

  @override
  Future<List<LabelPhoneEntry>> getAllEnabled() async {
    final maps = await _databaseService.queryWhere('labels', 'isEnabled', true);
    return maps.map((map) => fromMap(map)).toList();
  }
  
  @override
  Future<LabelPhoneEntry?> getByPhoneNumber(String phoneNumber) async {
    final maps = await _databaseService.queryWhere('labels', 'phoneNumber', phoneNumber);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }
  
  @override
  Future<List<LabelPhoneEntry>> getByLabelId(String labelId) async {
    final maps = await _databaseService.queryWhere('labels', 'labelId', labelId);
    return maps.map((map) => fromMap(map)).toList();
  }
}