import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:yourcallyourrule/features/call_history/repositories/call_log_repository.dart';
import 'package:yourcallyourrule/features/call_history/data/datasources/local_call_log_datasource.dart';

part 'call_log_repository_impl.g.dart';

/// 通话日志仓库提供者
@Riverpod(keepAlive: true)
CallLogRepository callLogRepository(Ref ref) {
  final localCallLogDataSource = ref.watch(localCallLogDataSourceProvider);
  return CallLogRepositoryImpl(localCallLogDataSource);
}

/// 通话日志仓库实现类
class CallLogRepositoryImpl implements CallLogRepository {
  final LocalCallLogDataSource _dataSource;

  CallLogRepositoryImpl(this._dataSource);

  @override
  Future<List<CallLogEntry>> getAll() async {
    return await _dataSource.getAll();
  }

  @override
  Future<CallLogEntry?> getById(String id) async {
    return await _dataSource.getById(id);
  }

  @override
  Future<CallLogEntry> save(CallLogEntry entity) async {
    await _dataSource.insert(entity);
    return entity;
  }

  @override
  Future<CallLogEntry> update(CallLogEntry entity) async {
    await _dataSource.update(entity);
    return entity;
  }

  @override
  Future<void> updateAll(List<CallLogEntry> entities) async {
    await _dataSource.updateAll(entities);
  }

  @override
  Future<bool> delete(CallLogEntry entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _dataSource.delete(id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<CallLogEntry> entities) async {
    final ids = entities.map((e) => e.id).toList();
    await _dataSource.deleteAll(ids);
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
    return await _dataSource.getByNumber(phoneNumber);
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
    return await _dataSource.deleteAll(ids);
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
  Future<void> markAsRead(String logId) async {
    // CallLogEntry read state handling if needed
  }

  @override
  Future<void> markAllAsRead() async {
    // CallLogEntry read state handling if needed
  }

  @override
  Future<void> refreshLogs() async {
    return;
  }

  @override
  Stream<List<CallLogEntry>> watchLogs() {
    return _dataSource.watchAll();
  }
}
