import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';
import 'package:yourcallyourrule/features/location/repositories/location_repository.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'location_repository_impl.g.dart';

/// 位置仓库提供者 (直连 Drift LocalDatabase)
@Riverpod(keepAlive: true)
LocationRepository locationRepository(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return LocationRepositoryImpl(db);
}

/// 位置仓库实现类
class LocationRepositoryImpl implements LocationRepository {
  final LocalDatabase _db;
  final Uuid _uuid = const Uuid();

  LocationRepositoryImpl(this._db);

  LocationsCompanion _toCompanion(LocationEntry entity) {
    final id = entity.id.isEmpty ? _uuid.v4() : entity.id;
    return LocationsCompanion.insert(
      id: id,
      phoneNumber: entity.phoneNumber,
      province: Value(entity.province),
      city: Value(entity.city),
      carrier: Value(entity.carrier),
    );
  }

  LocationEntry _fromData(LocationData data) {
    return LocationEntry(
      id: data.id,
      phoneNumber: data.phoneNumber,
      province: data.province,
      city: data.city,
      carrier: data.carrier,
    );
  }

  @override
  Future<List<LocationEntry>> getAll() async {
    final rows = await _db.select(_db.locations).get();
    return rows.map(_fromData).toList();
  }

  @override
  Future<LocationEntry?> getById(String id) async {
    final row = await (_db.select(_db.locations)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row != null ? _fromData(row) : null;
  }

  @override
  Future<LocationEntry> save(LocationEntry entity) async {
    final companion = _toCompanion(entity);
    await _db.into(_db.locations).insertOnConflictUpdate(companion);
    return entity;
  }

  @override
  Future<LocationEntry> update(LocationEntry entity) async {
    await save(entity);
    return entity;
  }

  @override
  Future<LocationEntry?> getByPhoneNumber(String phone) async {
    final row = await (_db.select(_db.locations)..where((tbl) => tbl.phoneNumber.equals(phone))).getSingleOrNull();
    return row != null ? _fromData(row) : null;
  }

  @override
  Future<List<LocationEntry>> getLocationsByRegion(String region) async {
    final rows = await (_db.select(_db.locations)..where((tbl) => tbl.province.contains(region) | tbl.city.contains(region))).get();
    return rows.map(_fromData).toList();
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
    final count = await (_db.delete(_db.locations)..where((tbl) => tbl.id.equals(id))).go();
    return count > 0;
  }

  @override
  Future<bool> deleteAll(List<LocationEntry> entities) async {
    final ids = entities.map((e) => e.id).toList();
    await (_db.delete(_db.locations)..where((tbl) => tbl.id.isIn(ids))).go();
    return true;
  }

  @override
  Future<List<LocationEntry>> saveAll(List<LocationEntry> entities) async {
    for (final entity in entities) {
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
}
