import 'package:sqflite/sqflite.dart';
import 'package:yourcallyourrule/core/entities/location/location_entry.dart';
import 'package:yourcallyourrule/data/database/database_manager.dart';
import 'package:yourcallyourrule/data/models/location_model.dart';


class LocalLocationDataSource {
  final LocalDatabaseManager _dbManager;

  LocalLocationDataSource(this._dbManager);

  Future<Database> get _db async => _dbManager.database;

  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await _db;
    return await db.query('locations');
  }

  Future<Map<String, dynamic>?> queryById(String id) async {
    final db = await _db;
    final maps = await db.query(
      'locations',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return maps.first;
  }

  Future<String> insert(LocationModel location) async {
    final db = await _db;
    await db.insert(
      'locations',
      location.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return location.id;
  }

  Future<void> batchInsert(List<LocationModel> locations) async {
    final db = await _db;
    final batch = db.batch();
    for (final location in locations) {
      batch.insert('locations', location.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<LocationEntry?> getByPhoneNumber(String phoneNumber) async {
    final db = await _db;
    final maps = await db.query(
      'locations',
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
    if (maps.isEmpty) return null;
    final map = Map<String,dynamic>.from(maps.first);
    return LocationModel.fromMap(map).toEntity();
  }

  Future<List<LocationEntry>> getByRegion(String region) async {
    final db = await _db;
    final maps = await db.query(
      'locations',
      where: 'region = ?',
      whereArgs: [region],
    );
    return maps.map((e) => LocationModel.fromMap(e).toEntity()).toList();
  }

  Future<int> update(LocationModel location) async {
    final db = await _db;
    return db.update(
      'locations',
      location.toMap(),
      where: 'id = ?',
      whereArgs: [location.id],
    );
  }

  Future<int> delete(String id) async {
    final db = await _db;
    return db.delete(
      'locations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> transactionUpdate(List<LocationModel> locations) async {
    final db = await _db;
    await db.transaction((txn) async {
      for (final location in locations) {
        await txn.update(
          'locations',
          location.toMap(),
          where: 'id = ?',
          whereArgs: [location.id],
        );
      }
    });
  }

  Future<List<LocationEntry>> searchByPhoneRegex(String pattern) async {
    final db = await _db;
    final result = await db.rawQuery(
      "SELECT * FROM locations WHERE phoneNumber REGEXP ?",
      [pattern],
    );
    return result.map((e) => LocationModel.fromMap(e).toEntity()).toList();
  }

  Future<List<Map<String, dynamic>>> getByName(String name) async {
    final db = await _db;
    return await db.query('locations', where: 'name = ?', whereArgs: [name]);
  }

  Future<List<Map<String, dynamic>>> getByType(String type) async {
    final db = await _db;
    return await db.query('locations', where: 'type = ?', whereArgs: [type]);
  }

  Future<List<Map<String, dynamic>>> getAllEnabled() async {
    final db = await _db;
    return await db.query('locations', where: 'isEnabled = ?', whereArgs: [1]);
  }

  Future<List<Map<String, dynamic>>> getUserCreatedLocations() async {
    final db = await _db;
    return await db.query('locations', where: 'isUserCreated = ?', whereArgs: [1]);
  }

  Future<List<Map<String, dynamic>>> getSystemLocations() async {
    final db = await _db;
    return await db.query('locations', where: 'isUserCreated = ?', whereArgs: [0]);
  }
}