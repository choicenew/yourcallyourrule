import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:yourcallyourrule/features/call_history/repositories/call_log_repository.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'call_log_repository_impl.g.dart';

/// 通话日志仓库提供者 (直连 Drift LocalDatabase)
@Riverpod(keepAlive: true)
CallLogRepository callLogRepository(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return CallLogRepositoryImpl(db);
}

/// 通话日志仓库实现类 (彻底去除中间 DataSource 层)
class CallLogRepositoryImpl implements CallLogRepository {
  final LocalDatabase _db;
  final Uuid _uuid = const Uuid();

  CallLogRepositoryImpl(this._db);

  CallHistoryCompanion _toCompanion(CallLogEntry log) {
    final id = log.id.isEmpty ? _uuid.v4() : log.id;
    final dt = log.timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(log.timestamp!)
        : DateTime.now();
    return CallHistoryCompanion.insert(
      id: id,
      phoneNumber: log.phoneNumber,
      callType: log.callType,
      name: Value(log.name),
      timestamp: Value(dt.millisecondsSinceEpoch),
      duration: Value(log.durationSeconds != null ? log.durationSeconds! * 1000 : null),
      countryIso: Value(log.location),
    );
  }

  @override
  Future<List<CallLogEntry>> getAll() async {
    final rows = await _db.select(_db.callHistory).get();
    return rows.map((row) => CallLogEntry.fromMap(row.toJson())).toList();
  }

  @override
  Future<CallLogEntry?> getById(String id) async {
    final row = await (_db.select(_db.callHistory)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row != null ? CallLogEntry.fromMap(row.toJson()) : null;
  }

  @override
  Future<CallLogEntry> save(CallLogEntry entity) async {
    final companion = _toCompanion(entity);
    await _db.into(_db.callHistory).insertOnConflictUpdate(companion);
    return entity;
  }

  @override
  Future<CallLogEntry> update(CallLogEntry entity) async {
    await save(entity);
    return entity;
  }

  @override
  Future<void> updateAll(List<CallLogEntry> entities) async {
    for (final entity in entities) {
      await save(entity);
    }
  }

  @override
  Future<bool> delete(CallLogEntry entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    final count = await (_db.delete(_db.callHistory)..where((tbl) => tbl.id.equals(id))).go();
    return count > 0;
  }

  @override
  Future<bool> deleteAll(List<CallLogEntry> entities) async {
    final ids = entities.map((e) => e.id).toList();
    await (_db.delete(_db.callHistory)..where((tbl) => tbl.id.isIn(ids))).go();
    return true;
  }

  @override
  Future<int> count() async {
    final logs = await getAll();
    return logs.length;
  }

  @override
  Future<List<CallLogEntry>> getRecentLogs() async {
    final logs = await getAll();
    logs.sort((a, b) => (b.timestamp ?? 0).compareTo(a.timestamp ?? 0));
    return logs.take(20).toList();
  }

  @override
  Future<List<CallLogEntry>> getLogsByPhoneNumber(String phoneNumber) async {
    final rows = await (_db.select(_db.callHistory)..where((tbl) => tbl.phoneNumber.equals(phoneNumber))).get();
    return rows.map((row) => CallLogEntry.fromMap(row.toJson())).toList();
  }

  @override
  Future<List<CallLogEntry>> getLogsByLabelId(String labelId) async {
    final logs = await getAll();
    return logs.where((log) => log.location?.contains(labelId) ?? false).toList();
  }

  @override
  Future<List<CallLogEntry>> getLogsWithAnyLabels(List<String> labelIds) async {
    final logs = await getAll();
    return logs.where((log) =>
      log.location != null &&
      labelIds.any((id) => log.location!.contains(id))
    ).toList();
  }

  @override
  Future<List<CallLogEntry>> getLogsWithAllLabels(List<String> labelIds) async {
    final logs = await getAll();
    return logs.where((log) =>
      log.location != null &&
      labelIds.every((id) => log.location!.contains(id))
    ).toList();
  }

  @override
  Future<int> deleteLogsByDateRange(DateTime startDate, DateTime endDate) async {
    final logs = await getLogsByDateRange(startDate, endDate);
    final ids = logs.map((l) => l.id).toList();
    if (ids.isEmpty) return 0;
    return await (_db.delete(_db.callHistory)..where((tbl) => tbl.id.isIn(ids))).go();
  }

  @override
  Future<List<CallLogEntry>> getLogsByDateRange(DateTime startDate, DateTime endDate) async {
    final logs = await getAll();
    final startMs = startDate.millisecondsSinceEpoch;
    final endMs = endDate.millisecondsSinceEpoch;
    return logs.where((log) {
      final ts = log.timestamp ?? 0;
      return ts >= startMs && ts <= endMs;
    }).toList();
  }

  @override
  Future<void> addLog(CallLogEntry log) async {
    await save(log);
  }

  @override
  Future<List<CallLogEntry>> getUnreadLogs() async {
    final logs = await getRecentLogs();
    return logs.take(10).toList();
  }

  @override
  Future<void> markAsRead(String logId) async {}

  @override
  Future<void> markAllAsRead() async {}

  @override
  Future<void> refreshLogs() async {}

  @override
  Stream<List<CallLogEntry>> watchLogs() {
    return _db.select(_db.callHistory).watch().map(
      (rows) => rows.map((row) => CallLogEntry.fromMap(row.toJson())).toList(),
    );
  }
}
