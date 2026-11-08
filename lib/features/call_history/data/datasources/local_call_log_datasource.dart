import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/features/call_history/data/models/call_log_model.dart';
import 'package:yourcallyourrule/features/call_history/entities/call_log.dart';

part 'local_call_log_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalCallLogDataSource localCallLogDataSource(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return LocalCallLogDataSource(db);
}

class LocalCallLogDataSource {
  final LocalDatabase _db;

  LocalCallLogDataSource(this._db);

  CallLogModel _fromData(CallLog data) {
    return CallLogModel.fromEntity(data);
  }

  CallHistoryCompanion _toCompanion(CallLogModel log) {
    return CallHistoryCompanion(
      id: Value(log.id),
      phoneNumber: Value(log.phoneNumber),
      name: Value(log.name),
      timestamp: Value(log.timestamp.toIso8601String()),
      endTime: Value(log.endTime?.toIso8601String()),
      duration: Value(log.duration),
      simDisplayName: Value(log.simDisplayName),
      callType: Value(log.callType),
      simSlotIndex: Value(log.simSlotIndex),
      carrierName: Value(log.carrierName),
      countryIso: Value(log.countryIso),
      subscriptionId: Value(log.subscriptionId),
      labelIds: Value(log.labelIds != null && log.labelIds!.isNotEmpty ? jsonEncode(log.labelIds) : null),
    );
  }

  Future<String> insert(CallLogModel log) async {
    final id = log.id.isEmpty ? const Uuid().v4() : log.id;
    final companion = _toCompanion(log).copyWith(id: Value(id));
    await _db.into(_db.callHistory).insert(companion);
    return id;
  }

  Future<List<String>> insertAll(List<CallLogModel> logs) async {
    final ids = <String>[];
    await _db.batch((batch) {
      for (final log in logs) {
        final id = log.id.isEmpty ? const Uuid().v4() : log.id;
        ids.add(id);
        final companion = _toCompanion(log).copyWith(id: Value(id));
        batch.insert(_db.callHistory, companion);
      }
    });
    return ids;
  }

  Future<CallLogModel?> getById(String id) async {
    final data = await (_db.select(_db.callHistory)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return data != null ? _fromData(data) : null;
  }

  Future<List<CallLogModel>> getByNumber(String number) async {
    final data = await (_db.select(_db.callHistory)..where((tbl) => tbl.phoneNumber.equals(number))).get();
    return data.map(_fromData).toList();
  }

  Future<int> update(CallLogModel log) async {
    return await (_db.update(_db.callHistory)..where((tbl) => tbl.id.equals(log.id))).write(_toCompanion(log));
  }

  Future<int> delete(String id) async {
    return await (_db.delete(_db.callHistory)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<CallLogModel>> getAll() async {
    final data = await _db.select(_db.callHistory).get();
    return data.map(_fromData).toList();
  }

  Future<void> transactionUpdate(List<CallLogModel> logs) async {
    await _db.transaction(() async {
      for (final log in logs) {
        await update(log);
      }
    });
  }

  Future<List<CallLogModel>> searchByRegex(String pattern) async {
    final result = await (_db.select(_db.callHistory)..where((tbl) => tbl.phoneNumber.like('%$pattern%'))).get();
    return result.map(_fromData).toList();
  }

  Future<List<CallLogModel>> getByLabelId(String labelId) async {
    final data = await (_db.select(_db.callHistory)..where((tbl) => tbl.labelIds.like('%$labelId%'))).get();
    return data.map(_fromData).toList();
  }

  Future<List<CallLogModel>> getWithAnyLabels(List<String> labelIds) async {
    if (labelIds.isEmpty) return [];
    final allLogs = await getAll();
    return allLogs.where((log) => log.labelIds != null && log.labelIds!.any((id) => labelIds.contains(id))).toList();
  }

  Stream<List<CallLogModel>> watchAll() {
    return _db.select(_db.callHistory).watch().map((data) => data.map(_fromData).toList());
  }

  Future<int> updateAll(List<CallLogModel> items) async {
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
      final List<dynamic> maps = jsonDecode(data);
      final items = maps.map((map) => CallLogModel.fromMap(map)).toList();
      await insertAll(items);
      return true;
    } catch (e) {
      return false;
    }
  }
}