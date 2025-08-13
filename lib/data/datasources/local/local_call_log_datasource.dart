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
      'call_history',
      log.toMap()..['labelIds'] = log.labelIds?.join(','),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return log.id;
  }

  Future<void> batchInsert(List<CallLogModel> logs) async {
    final db = await _db;
    final batch = db.batch();
    for (final log in logs) {
      batch.insert('call_history', log.toMap()..['labelIds'] = log.labelIds?.join(','));
    }
    await batch.commit(noResult: true);
  }

  Future<CallLog?> getById(String id) async {
    final db = await _db;
    final maps = await db.query(
      'call_history',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? CallLogModel.fromMap(maps.first).toEntity() : null;
  }

  Future<List<CallLog>> getByNumber(String number) async {
    final db = await _db;
    final maps = await db.query(
      'call_history',
      where: 'number = ?',
      whereArgs: [number],
    );
    return maps.map((e) => CallLogModel.fromMap(e).toEntity()).toList();
  }

  Future<int> update(CallLogModel log) async {
    final db = await _db;
    return db.update(
      'call_history',
      log.toMap()..['labelIds'] = log.labelIds?.join(','),
      where: 'id = ?',
      whereArgs: [log.id],
    );
  }

  Future<int> delete(String id) async {
    final db = await _db;
    return db.delete(
      'call_history',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> transactionUpdate(List<CallLogModel> logs) async {
    final db = await _db;
    await db.transaction((txn) async {
      for (final log in logs) {
        await txn.update(
          'call_history',
          log.toMap()..['labelIds'] = log.labelIds?.join(','),
          where: 'id = ?',
          whereArgs: [log.id],
        );
      }
    });
  }

  Future<List<CallLog>> searchByRegex(String pattern) async {
    final db = await _db;
    final result = await db.rawQuery(
      "SELECT * FROM call_history WHERE number REGEXP ?",
      [pattern],
    );
    return result.map((e) => CallLogModel.fromMap(e).toEntity()).toList();
  }

  Future<List<CallLog>> getByLabelId(String labelId) async {
    final db = await _db;
    final maps = await db.query(
      'call_history',
      where: 'labelIds LIKE ?',
      whereArgs: ['%$labelId%'],
    );
    return maps.map((e) => CallLogModel.fromMap(e).toEntity()).toList();
  }

  Future<List<CallLog>> getWithAnyLabels(List<String> labelIds) async {
    final db = await _db;
    final conditions = labelIds.map((_) => 'labelIds LIKE ?').join(' OR ');
    final args = labelIds.map((id) => '%$id%').toList();
    
    final maps = await db.query(
      'call_history',
      where: conditions,
      whereArgs: args,
    );
    return maps.map((e) => CallLogModel.fromMap(e).toEntity()).toList();
  }
}