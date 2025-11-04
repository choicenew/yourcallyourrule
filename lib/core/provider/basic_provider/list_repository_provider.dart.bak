import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/provider/lists_provider.dart';

import 'package:yourcallyourrule/data/database/database_service.dart';

import 'database_service_provider.dart';

/// 列表仓库提供者
final listRepositoryProvider = Provider<ListRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // 返回列表仓库实现
  return ListRepositoryImpl(databaseService);
});

/// 列表仓库实现类
class ListRepositoryImpl implements ListRepository {
  final DatabaseService _databaseService;

  ListRepositoryImpl(this._databaseService);

  @override
  Future<List<ListEntry>> getAll() async {
    final maps = await _databaseService.queryAll('lists');
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<ListEntry?> getById(String id) async {
    final map = await _databaseService.queryById('lists', id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<ListEntry> save(ListEntry entity) async {
    await _databaseService.insert('lists', entity.toMap());
    return entity;
  }

  @override
  Future<ListEntry> update(ListEntry entity) async {
    // ListEntry没有id属性，使用phoneNumber作为唯一标识
    await _databaseService.update(
        'lists', entity.phoneNumber.value, entity.toMap());
    return entity;
  }

  @override
  Future<bool> delete(ListEntry entity) async {
    // ListEntry没有id属性，使用phoneNumber作为唯一标识
    return await deleteById(entity.phoneNumber.value);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('lists', id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<ListEntry> entities) async {
    for (var entity in entities) {
      // ListEntry没有id属性，使用phoneNumber作为唯一标识
      await deleteById(entity.phoneNumber.value);
    }
    return true;
  }

  @override
  Future<List<ListEntry>> saveAll(List<ListEntry> entities) async {
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
    final lists = await getAll();
    return lists.length;
  }

  @override
  ListEntry fromMap(Map<String, dynamic> map) {
    return ListEntry.fromMap(map);
  }

  @override
  Future<ListEntry?> getByName(String name) async {
    final maps = await _databaseService.queryWhere('lists', 'name', name);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }

  @override
  Future<List<ListEntry>> getByType(String type) async {
    final maps = await _databaseService.queryWhere('lists', 'type', type);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<bool> nameExists(String name) async {
    final list = await getByName(name);
    return list != null;
  }

  @override
  Future<List<ListEntry>> getAllEnabled() async {
    final maps = await _databaseService.queryWhere('lists', 'isEnabled', true);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<List<ListEntry>> getUserCreatedLists() async {
    final maps =
        await _databaseService.queryWhere('lists', 'isUserCreated', true);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<List<ListEntry>> getSystemLists() async {
    final maps =
        await _databaseService.queryWhere('lists', 'isUserCreated', false);
    return maps.map((map) => fromMap(map)).toList();
  }
}