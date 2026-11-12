import 'dart:async';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_location_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalLocationDataSource localLocationDataSource(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return LocalLocationDataSource(db);
}

class LocalLocationDataSource {
  final LocalDatabase _db;

  LocalLocationDataSource(this._db);

  PhoneLocationEntry _fromData(dynamic data) {
    return PhoneLocationEntry(
      id: data.id as String,
      phoneNumber: data.phoneNumber as String,
      countryName: data.countryName as String?,
      region: data.region as String?,
      carrier: data.carrier as String?,
      numberType: (data.numberType as int).toString(),
    );
  }

  LocationsCompanion _toCompanion(PhoneLocationEntry entry) {
    return LocationsCompanion.insert(
      id: entry.id,
      phoneNumber: entry.phoneNumber,
      countryName: Value(entry.countryName),
      region: Value(entry.region),
      carrier: Value(entry.carrier),
      numberType: int.tryParse(entry.numberType) ?? 0,
    );
  }

  Future<List<PhoneLocationEntry>> getAll() async {
    final results = await _db.select(_db.locations).get();
    return results.map<PhoneLocationEntry>(_fromData).toList();
  }

  Future<PhoneLocationEntry?> getById(String id) async {
    final result = await (_db.select(_db.locations)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return result != null ? _fromData(result) : null;
  }

  Future<void> insert(PhoneLocationEntry entry) async {
    await _db.into(_db.locations).insertOnConflictUpdate(_toCompanion(entry));
  }

  Future<void> insertAll(List<PhoneLocationEntry> entries) async {
    for (final entry in entries) {
      await insert(entry);
    }
  }

  Future<void> update(PhoneLocationEntry entry) async {
    await insert(entry);
  }

  Future<bool> delete(String id) async {
    try {
      final rows = await (_db.delete(_db.locations)..where((tbl) => tbl.id.equals(id))).go();
      return rows > 0;
    } catch (e) {
      return false;
    }
  }

  Future<PhoneLocationEntry?> getByPhoneNumber(String phoneNumber) async {
    final data = await (_db.select(_db.locations)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber))
      ..limit(1))
      .getSingleOrNull();
    return data != null ? _fromData(data) : null;
  }

  Future<List<PhoneLocationEntry>> getByRegion(String region) async {
    final data = await (_db.select(_db.locations)..where((tbl) => tbl.region.equals(region))).get();
    return data.map<PhoneLocationEntry>(_fromData).toList();
  }

  Future<List<PhoneLocationEntry>> getByName(String name) async {
    final data = await (_db.select(_db.locations)
      ..where((tbl) => tbl.countryName.equals(name)))
      .get();
    return data.map<PhoneLocationEntry>(_fromData).toList();
  }
}
