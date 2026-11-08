import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/features/call_history/data/models/call_log_model.dart';

part 'local_call_log_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalCallLogDataSource localCallLogDataSource(Ref ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localCallLogDataSource;
}

class LocalCallLogDataSource {
  final LocalDatabase _db;

  LocalCallLogDataSource(this._db);

  Future<String> insert(CallLogEntry log) async {
    final id = log.id.isEmpty ? const Uuid().v4() : log.id;
    final companion = CallLogModelMapper.toCompanion(log).copyWith(id: Value(id));
    await _db.into(_db.callHistory).insert(companion);
    return id;
  }

  Future<List<String>> insertAll(List<CallLogEntry> logs) async {
    final ids = <String>[];
    await _db.batch((batch) {
      for (final log in logs) {
        final id = log.id.isEmpty ? const Uuid().v4() : log.id;
        ids.add(id);
        final companion = CallLogModelMapper.toCompanion(log).copyWith(id: Value(id));
        batch.insert(_db.callHistory, companion);
      }
    });
    return ids;
  }

  Future<CallLogEntry?> getById(String id) async {
    final data = await (_db.select(_db.callHistory)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return data != null ? CallLogModelMapper.fromData(data) : null;
  }

  Future<List<CallLogEntry>> getByNumber(String number) async {
    final data = await (_db.select(_db.callHistory)..where((tbl) => tbl.phoneNumber.equals(number))).get();
    return data.map(CallLogModelMapper.fromData).toList();
  }

  Future<int> update(CallLogEntry log) async {
    return await (_db.update(_db.callHistory)..where((tbl) => tbl.id.equals(log.id))).write(CallLogModelMapper.toCompanion(log));
  }

  Future<int> delete(String id) async {
    return await (_db.delete(_db.callHistory)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<CallLogEntry>> getAll() async {
    final data = await _db.select(_db.callHistory).get();
    return data.map(CallLogModelMapper.fromData).toList();
  }

  Future<void> transactionUpdate(List<CallLogEntry> logs) async {
    await _db.transaction(() async {
      for (final log in logs) {
        await update(log);
      }
    });
  }

  Future<List<CallLogEntry>> searchByRegex(String pattern) async {
    final result = await (_db.select(_db.callHistory)..where((tbl) => tbl.phoneNumber.like('%$pattern%'))).get();
    return result.map(CallLogModelMapper.fromData).toList();
  }

  Stream<List<CallLogEntry>> watchAll() {
    return _db.select(_db.callHistory).watch().map((data) => data.map(CallLogModelMapper.fromData).toList());
  }

  Future<int> updateAll(List<CallLogEntry> items) async {
    await _db.batch((batch) {
      for (final item in items) {
        batch.update(
          _db.callHistory,
          CallLogModelMapper.toCompanion(item),
          where: (tbl) => tbl.id.equals(item.id),
        );
      }
    });
    return items.length;
  }

  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return await (_db.delete(_db.callHistory)..where((tbl) => tbl.id.isIn(ids))).go();
  }

  Future<void> clear() async {
    await _db.delete(_db.callHistory).go();
  }

  Future<String> exportData() async {
    final items = await getAll();
    final maps = items.map((item) => item.toMap()).toList();
    return jsonEncode(maps);
  }

  Future<bool> importData(String data) async {
    try {
      final List<dynamic> maps = jsonDecode(data);
      final items = maps.map((map) => CallLogEntry.fromMap(map)).toList();
      await insertAll(items);
      return true;
    } catch (e) {
      return false;
    }
  }
}