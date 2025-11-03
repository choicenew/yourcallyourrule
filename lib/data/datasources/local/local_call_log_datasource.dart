import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/data/models/call/call_log_model.dart';

import '../datasource_interface.dart';

class LocalCallLogDataSource implements LocalDataSource<CallLogModel> {
  final LocalDatabase _db;

  LocalCallLogDataSource(this._db);

  CallLogModel _fromData(CallHistoryData data) {
    final labelIds = data.labelIds;
    return CallLogModel(
      id: data.id,
      phoneNumber: data.phoneNumber,
      name: data.name,
      timestamp: DateTime.parse(data.timestamp),
      endTime: data.endTime == null ? null : DateTime.parse(data.endTime!),
      duration: data.duration,
      simDisplayName: data.simDisplayName ?? '',
      callType: data.callType ?? '',
      simSlotIndex: data.simSlotIndex ?? 0,
      carrierName: data.carrierName ?? '',
      countryIso: data.countryIso ?? '',
      subscriptionId: data.subscriptionId ?? 0,
      labelIds: labelIds != null && labelIds.isNotEmpty ? (jsonDecode(labelIds) as List<dynamic>).cast<String>() : null,
    );
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

  @override
  Future<String> insert(CallLogModel log) async {
    final id = log.id.isEmpty ? const Uuid().v4() : log.id;
    final companion = _toCompanion(log).copyWith(id: Value(id));
    await _db.into(_db.callHistory).insert(companion);
    return id;
  }

  @override
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

  @override
  Future<CallLogModel?> getById(String id) async {
    final data = await (_db.select(_db.callHistory)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return data != null ? _fromData(data) : null;
  }

  Future<List<CallLogModel>> getByNumber(String number) async {
    final data = await (_db.select(_db.callHistory)..where((tbl) => tbl.phoneNumber.equals(number))).get();
    return data.map(_fromData).toList();
  }

  @override
  Future<int> update(CallLogModel log) async {
    return await (_db.update(_db.callHistory)..where((tbl) => tbl.id.equals(log.id))).write(_toCompanion(log));
  }

  @override
  Future<int> delete(String id) async {
    return await (_db.delete(_db.callHistory)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
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
    final conditions = labelIds.map((id) => _db.callHistory.labelIds.like('%$id%')).reduce((a, b) => a | b);
    final data = await (_db.select(_db.callHistory)..where((_) => conditions)).get();
    return data.map(_fromData).toList();
  }

  Stream<List<CallLogModel>> watchAll() {
    return _db.select(_db.callHistory).watch().map((data) => data.map(_fromData).toList());
  }

  @override
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

  @override
  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return await (_db.delete(_db.callHistory)..where((tbl) => tbl.id.isIn(ids))).go();
  }

  @override
  Future<void> clear() async {
    await _db.delete(_db.callHistory).go();
  }

  @override
  Future<String> exportData() async {
    final items = await getAll();
    final maps = items.map((item) => item.toMap()).toList();
    return jsonEncode(maps);
  }

  @override
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