import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_call_log_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalCallLogDataSource localCallLogDataSource(Ref ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localCallLogDataSource;
}

class LocalCallLogDataSource {
  final LocalDatabase _db;

  LocalCallLogDataSource(this._db);

  CallHistoryCompanion _toCompanion(CallLogEntry log) {
    final id = log.id.isEmpty ? const Uuid().v4() : log.id;
    final dt = log.timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(log.timestamp!)
        : DateTime.now();
    return CallHistoryCompanion.insert(
      id: id,
      phoneNumber: log.phoneNumber,
      callType: log.callType,
      name: Value(log.name),
      timestamp: dt.toIso8601String(),
      duration: Value(log.durationSeconds != null ? log.durationSeconds! * 1000 : null),
      countryIso: Value(log.location),
    );
  }

  Future<String> insert(CallLogEntry log) async {
    final companion = _toCompanion(log);
    await _db.into(_db.callHistory).insert(companion);
    return companion.id.value;
  }

  Future<List<String>> insertAll(List<CallLogEntry> logs) async {
    final ids = <String>[];
    await _db.batch((batch) {
      for (final log in logs) {
        final companion = _toCompanion(log);
        ids.add(companion.id.value);
        batch.insert(_db.callHistory, companion);
      }
    });
    return ids;
  }

  Future<CallLogEntry?> getById(String id) async {
    return await (_db.select(_db.callHistory)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<List<CallLogEntry>> getByNumber(String number) async {
    return await (_db.select(_db.callHistory)..where((tbl) => tbl.phoneNumber.equals(number))).get();
  }

  Future<int> update(CallLogEntry log) async {
    final companion = _toCompanion(log);
    return await (_db.update(_db.callHistory)..where((tbl) => tbl.id.equals(log.id))).write(companion);
  }

  Future<int> delete(String id) async {
    return await (_db.delete(_db.callHistory)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<CallLogEntry>> getAll() async {
    return await _db.select(_db.callHistory).get();
  }

  Future<void> transactionUpdate(List<CallLogEntry> logs) async {
    await _db.transaction(() async {
      for (final log in logs) {
        await update(log);
      }
    });
  }

  Future<List<CallLogEntry>> searchByRegex(String pattern) async {
    return await (_db.select(_db.callHistory)..where((tbl) => tbl.phoneNumber.like('%$pattern%'))).get();
  }

  Stream<List<CallLogEntry>> watchAll() {
    return _db.select(_db.callHistory).watch();
  }

  Future<int> updateAll(List<CallLogEntry> items) async {
    await _db.batch((batch) {
      for (final item in items) {
        batch.update(
          _db.callHistory,
          _toCompanion(item),
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
      final List<dynamic> maps = jsonEncode(data) as List<dynamic>;
      final items = maps.map((map) => CallLogEntry.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(items);
      return true;
    } catch (e) {
      return false;
    }
  }
}
