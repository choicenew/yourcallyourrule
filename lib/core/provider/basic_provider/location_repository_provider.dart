import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/location/location_entry.dart';
import 'package:yourcallyourrule/core/repositories/location_repository.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';

import 'database_service_provider.dart';

/// 位置仓库提供者
final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // 返回位置仓库实现
  return LocationRepositoryImpl(databaseService);
});

/// 位置仓库实现类
class LocationRepositoryImpl implements LocationRepository {
  final DatabaseService _databaseService;

  LocationRepositoryImpl(this._databaseService);

  @override
  Future<List<LocationEntry>> getAll() async {
    final maps = await _databaseService.queryAll('locations');
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<LocationEntry?> getById(String id) async {
    final map = await _databaseService.queryById('locations', id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<LocationEntry> save(LocationEntry entity) async {
    await _databaseService.insert('locations', entity.toMap());
    return entity;
  }

  @override
  Future<LocationEntry> update(LocationEntry entity) async {
    await _databaseService.update('locations', entity.id, entity.toMap());
    return entity;
  }
  
  @override
  Future<LocationEntry?> getByPhoneNumber(String phone) async {
    final maps = await _databaseService.queryWhere('locations', 'phoneNumber', phone);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }
  
  @override
  Future<List<LocationEntry>> getLocationsByRegion(String region) async {
    final maps = await _databaseService.queryWhere('locations', 'region', region);
    return maps.map((map) => fromMap(map)).toList();
  }
  
  @override
  Future<void> saveLocation(LocationEntry entry) async {
    await save(entry);
  }

  @override
  Future<bool> delete(LocationEntry entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('locations', id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<LocationEntry> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  @override
  Future<List<LocationEntry>> saveAll(List<LocationEntry> entities) async {
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
    final locations = await getAll();
    return locations.length;
  }

  @override
  LocationEntry fromMap(Map<String, dynamic> map) {
    return LocationEntry.fromMap(map);
  }

  @override
  Future<List<LocationEntry>> getByName(String name) async {
    final maps = await _databaseService.queryWhere('locations', 'name', name);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<List<LocationEntry>> getByType(String type) async {
    final maps = await _databaseService.queryWhere('locations', 'type', type);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<List<LocationEntry>> getAllEnabled() async {
    final maps = await _databaseService.queryWhere('locations', 'isEnabled', true);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<List<LocationEntry>> getUserCreatedLocations() async {
    final maps = await _databaseService.queryWhere('locations', 'isUserCreated', true);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<List<LocationEntry>> getSystemLocations() async {
    final maps = await _databaseService.queryWhere('locations', 'isUserCreated', false);
    return maps.map((map) => fromMap(map)).toList();
  }
}