import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';
import 'package:yourcallyourrule/features/phone_location/repositories/location_repository.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'location_repository_impl.g.dart';

@Riverpod(keepAlive: true)
LocationRepository locationRepository(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return LocationRepositoryImpl(db);
}

class LocationRepositoryImpl implements LocationRepository {
  final LocalDatabase _db;
  final Uuid _uuid = const Uuid();

  LocationRepositoryImpl(this._db);

  LocationsCompanion _toCompanion(PhoneLocationEntry entity) {
    final id = entity.id.isEmpty ? _uuid.v4() : entity.id;
    return LocationsCompanion.insert(
      id: id,
      phoneNumber: entity.phoneNumber,
      region: Value(entity.region),
      countryName: Value(entity.countryName),
      carrier: Value(entity.carrier),
      numberType: int.tryParse(entity.numberType) ?? 0,
    );
  }

  PhoneLocationEntry _fromData(Location data) {
    return PhoneLocationEntry(
      id: data.id,
      phoneNumber: data.phoneNumber,
      region: data.region,
      countryName: data.countryName,
      carrier: data.carrier,
      numberType: data.numberType.toString(),
    );
  }

  @override
  Future<List<PhoneLocationEntry>> getAll() async {
    final rows = await _db.select(_db.locations).get();
    return rows.map<PhoneLocationEntry>(_fromData).toList();
  }

  @override
  Future<PhoneLocationEntry?> getById(String id) async {
    final row = await (_db.select(_db.locations)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row != null ? _fromData(row) : null;
  }

  @override
  Future<PhoneLocationEntry> save(PhoneLocationEntry entity) async {
    final companion = _toCompanion(entity);
    await _db.into(_db.locations).insertOnConflictUpdate(companion);
    return entity;
  }

  @override
  Future<PhoneLocationEntry> update(PhoneLocationEntry entity) async {
    await save(entity);
    return entity;
  }

  @override
  Future<PhoneLocationEntry?> getByPhoneNumber(String phone) async {
    final row = await (_db.select(_db.locations)..where((tbl) => tbl.phoneNumber.equals(phone))).getSingleOrNull();
    return row != null ? _fromData(row) : null;
  }

  @override
  Future<List<PhoneLocationEntry>> getLocationsByRegion(String region) async {
    final rows = await (_db.select(_db.locations)..where((tbl) => tbl.region.like('%$region%'))).get();
    return rows.map<PhoneLocationEntry>(_fromData).toList();
  }

  @override
  Future<void> saveLocation(PhoneLocationEntry entry) async {
    await save(entry);
  }

  @override
  Future<bool> delete(PhoneLocationEntry entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    final count = await (_db.delete(_db.locations)..where((tbl) => tbl.id.equals(id))).go();
    return count > 0;
  }

  @override
  Future<bool> deleteAll(List<PhoneLocationEntry> entities) async {
    final ids = entities.map((e) => e.id).toList();
    await (_db.delete(_db.locations)..where((tbl) => tbl.id.isIn(ids))).go();
    return true;
  }

  @override
  Future<List<PhoneLocationEntry>> saveAll(List<PhoneLocationEntry> entities) async {
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
}
