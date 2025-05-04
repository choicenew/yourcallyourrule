import 'package:sqflite/sqflite.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/data/database/database_manager.dart';
import 'package:yourcallyourrule/data/models/call/call_log_model.dart';
import '../../database/local/local_database_manager.dart';

class LocalCallLogDataSource {
  final LocalDatabaseManager _dbManager;

  LocalCallLogDataSource(this._dbManager);

  Future<Database> get _db async => _dbManager.database;

  Future<String> insert(CallLogModel log) async {
    final db = await _db;
    await db.insert(
      'calls',
      log.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return log.id;
  }

  Future<void> batchInsert(List<CallLogModel> logs) async {
    final db = await _db;
    final batch = db.batch();
    for (final log in logs) {
      batch.insert('calls', log.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<CallLog?> getById(String id) async {
    final db = await _db;
    final maps = await db.query(
      'calls',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? CallLogModel.fromMap(maps.first).toEntity() : null;
  }

  Future<List<CallLog>> getByNumber(String number) async {
    final db = await _db;
    final maps = await db.query(
      'calls',
      where: 'number = ?',
      whereArgs: [number],
    );
    return maps.map((e) => CallLogModel.fromMap(e).toEntity()).toList();
  }

  Future<int> update(CallLogModel log) async {
    final db = await _db;
    return db.update(
      'calls',
      log.toMap(),
      where: 'id = ?',
      whereArgs: [log.id],
    );
  }

  Future<int> delete(String id) async {
    final db = await _db;
    return db.delete(
      'calls',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> transactionUpdate(List<CallLogModel> logs) async {
    final db = await _db;
    await db.transaction((txn) async {
      for (final log in logs) {
        await txn.update(
          'calls',
          log.toMap(),
          where: 'id = ?',
          whereArgs: [log.id],
        );
      }
    });
  }

  Future<List<CallLog>> searchByRegex(String pattern) async {
    final db = await _db;
    final result = await db.rawQuery(
      "SELECT * FROM calls WHERE number REGEXP ?",
      [pattern],
    );
    return result.map((e) => CallLogModel.fromMap(e).toEntity()).toList();
  }
}