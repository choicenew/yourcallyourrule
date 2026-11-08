import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_location_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalLocationDataSource localLocationDataSource(Ref ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localLocationDataSource;
}

abstract class LocationModelMapper {
  static PhoneLocationEntry fromData(LocationData data) {
    return PhoneLocationEntry(
      id: data.id,
      phoneNumber: data.phoneNumber,
      region: data.region,
      countryName: data.countryName,
      carrier: data.carrier,
    );
  }

  static LocationsCompanion toCompanion(PhoneLocationEntry entry) {
    return LocationsCompanion(
      id: Value(entry.id),
      phoneNumber: Value(entry.phoneNumber),
      region: Value(entry.region),
      countryName: Value(entry.countryName),
      carrier: Value(entry.carrier),
      numberType: const Value(0),
    );
  }
}

class LocalLocationDataSource {
  final LocalDatabase _db;
  final Uuid _uuid = const Uuid();

  LocalLocationDataSource(this._db);

  Future<List<PhoneLocationEntry>> getAll() async {
    final data = await _db.select(_db.locations).get();
    return data.map(LocationModelMapper.fromData).toList();
  }

  Future<PhoneLocationEntry?> getById(String id) async {
    final data = await (_db.select(_db.locations)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1))
      .getSingleOrNull();
    return data != null ? LocationModelMapper.fromData(data) : null;
  }

  Future<String> insert(PhoneLocationEntry location) async {
    final id = location.id.isEmpty ? _uuid.v4() : location.id;
    final companion = LocationModelMapper.toCompanion(location).copyWith(id: Value(id));
    await _db.into(_db.locations).insert(companion, mode: InsertMode.replace);
    return id;
  }

  Future<int> update(PhoneLocationEntry location) async {
    return (_db.update(_db.locations)
      ..where((tbl) => tbl.phoneNumber.equals(location.phoneNumber)))
      .write(LocationModelMapper.toCompanion(location));
  }

  Future<int> delete(String id) async {
    return (_db.delete(_db.locations)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }

  Future<List<String>> insertAll(List<PhoneLocationEntry> locations) async {
    final ids = <String>[];
    final companions = locations.map((location) {
      final id = location.id.isEmpty ? _uuid.v4() : location.id;
      ids.add(id);
      final companion = LocationModelMapper.toCompanion(location);
      return companion.copyWith(id: Value(id)); 
    }).toList();

    await _db.batch((batch) {
      batch.insertAll(_db.locations, companions, mode: InsertMode.replace);
    });
    return ids;
  }

  Future<int> updateAll(List<PhoneLocationEntry> locations) async {
    await _db.batch((batch) {
      for (final location in locations) {
        batch.update(
          _db.locations,
          LocationModelMapper.toCompanion(location),
          where: (tbl) => tbl.phoneNumber.equals(location.phoneNumber),
        );
      }
    });
    return locations.length;
  }

  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return (_db.delete(_db.locations)..where((tbl) => tbl.id.isIn(ids))).go();
  }

  Future<void> clear() async {
    await _db.delete(_db.locations).go();
  }

  Future<String> exportData() async {
    final locations = await getAll();
    return jsonEncode(locations.map((location) => location.toMap()).toList());
  }

  Future<bool> importData(String data) async {
    try {
      final List<dynamic> locationMaps = jsonDecode(data) as List<dynamic>;
      final locations = locationMaps.map((map) => PhoneLocationEntry.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(locations);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<PhoneLocationEntry?> getByPhoneNumber(String phoneNumber) async {
    final data = await (_db.select(_db.locations)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber))
      ..limit(1))
      .getSingleOrNull();
    return data != null ? LocationModelMapper.fromData(data) : null;
  }

  Future<List<PhoneLocationEntry>> getByRegion(String region) async {
    final data = await (_db.select(_db.locations)..where((tbl) => tbl.region.equals(region))).get();
    return data.map(LocationModelMapper.fromData).toList();
  }

  Future<List<PhoneLocationEntry>> getByName(String name) async {
    final data = await (_db.select(_db.locations)
      ..where((tbl) => tbl.countryName.equals(name)))
      .get();
    return data.map(LocationModelMapper.fromData).toList();
  }
}