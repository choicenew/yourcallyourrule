import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/location/location_entry.dart';
import 'package:yourcallyourrule/core/repositories/location_repository.dart';
import 'package:yourcallyourrule/data/datasources/local/local_location_datasource.dart';
import 'package:yourcallyourrule/data/models/location_model.dart';

import '../datasource/local_location_datasource_provider.dart';

/// 位置仓库提供者
final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  final localLocationDataSource = ref.watch(localLocationDataSourceProvider);
  // 返回位置仓库实现
  return LocationRepositoryImpl(localLocationDataSource);
});

/// 位置仓库实现类
class LocationRepositoryImpl implements LocationRepository {
  final LocalLocationDataSource _dataSource;

  LocationRepositoryImpl(this._dataSource);

  @override
  Future<List<LocationEntry>> getAll() async {
    final maps = await _dataSource.queryAll();
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<LocationEntry?> getById(String id) async {
    final map = await _dataSource.queryById(id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<LocationEntry> save(LocationEntry entity) async {
    await _dataSource.insert(LocationModel.fromEntity(entity));
    return entity;
  }

  @override
  Future<LocationEntry> update(LocationEntry entity) async {
    await _dataSource.update(LocationModel.fromEntity(entity));
    return entity;
  }
  
  @override
  Future<LocationEntry?> getByPhoneNumber(String phone) async {
    return await _dataSource.getByPhoneNumber(phone);
  }
  
  @override
  Future<List<LocationEntry>> getLocationsByRegion(String region) async {
    return await _dataSource.getByRegion(region);
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
    await _dataSource.delete(id);
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

  Future<List<LocationEntry>> getByName(String name) async {
    final maps = await _dataSource.getByName(name);
    return maps.map((map) => fromMap(map)).toList();
  }

  Future<List<LocationEntry>> getByType(String type) async {
    final maps = await _dataSource.getByType(type);
    return maps.map((map) => fromMap(map)).toList();
  }

  Future<List<LocationEntry>> getAllEnabled() async {
    final maps = await _dataSource.getAllEnabled();
    return maps.map((map) => fromMap(map)).toList();
  }

  Future<List<LocationEntry>> getUserCreatedLocations() async {
    final maps = await _dataSource.getUserCreatedLocations();
    return maps.map((map) => fromMap(map)).toList();
  }

  Future<List<LocationEntry>> getSystemLocations() async {
    final maps = await _dataSource.getSystemLocations();
    return maps.map((map) => fromMap(map)).toList();
  }
}