import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/repositories/call_log_repository.dart';
import 'package:yourcallyourrule/data/datasources/local/local_call_log_datasource.dart';

import '../datasource/local_call_log_datasource_provider.dart';

import 'package:yourcallyourrule/data/models/call/call_log_model.dart';

/// 通话日志仓库提供者
final callLogRepositoryProvider = Provider<CallLogRepository>((ref) {
  final localCallLogDataSource = ref.watch(localCallLogDataSourceProvider);
  // 返回通话日志仓库实现
  return CallLogRepositoryImpl(localCallLogDataSource);
});

/// 通话日志仓库实现类
class CallLogRepositoryImpl implements CallLogRepository {
  final LocalCallLogDataSource _dataSource;

  CallLogRepositoryImpl(this._dataSource);

  @override
  Future<List<CallLog>> getAll() async {
    final maps = await _dataSource.queryAll();
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<CallLog?> getById(String id) async {
    final map = await _dataSource.queryById(id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<CallLog> save(CallLog entity) async {
    await _dataSource.insert(CallLogModel.fromEntity(entity));
    return entity;
  }

  @override
  Future<CallLog> update(CallLog entity) async {
    await _dataSource.update(CallLogModel.fromEntity(entity));
    return entity;
  }

  @override
  Future<void> updateAll(List<CallLog> entities) async {
    final models = entities.map((e) => CallLogModel.fromEntity(e)).toList();
    await _dataSource.transactionUpdate(models);
  }

  @override
  Future<bool> delete(CallLog entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _dataSource.delete(id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<CallLog> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  @override
  Future<List<CallLog>> saveAll(List<CallLog> entities) async {
    for (var entity in entities) {
      await save(entity);
    }
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final logs = await getAll();
    return logs.length;
  }

  @override
  CallLog fromMap(Map<String, dynamic> map) {
    return CallLog.fromMap(map);
  }

  @override
  Future<List<CallLog>> getRecentLogs() async {
    // 获取最近通话日志的实现
    final logs = await getAll();
    logs.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return logs.take(20).toList(); // 返回最近的20条记录
  }

  @override
  Future<List<CallLog>> getLogsByPhoneNumber(String phoneNumber) async {
    // 按电话号码筛选通话日志的实现
    final logs = await getAll();
    return logs.where((log) => log.phoneNumber == phoneNumber).toList();
  }
  
  @override
  Future<List<CallLog>> getLogsByLabelId(String labelId) async {
    // 根据标签ID获取通话记录
    final logs = await getAll();
    return logs.where((log) => log.labelIds?.contains(labelId) ?? false).toList();
  }
  
  @override
  Future<List<CallLog>> getLogsWithAnyLabels(List<String> labelIds) async {
    // 获取包含任意指定标签的通话记录
    final logs = await getAll();
    return logs.where((log) => 
      log.labelIds != null && 
      log.labelIds!.any((id) => labelIds.contains(id))
    ).toList();
  }
  
  @override
  Future<List<CallLog>> getLogsWithAllLabels(List<String> labelIds) async {
    // 获取包含全部指定标签的通话记录
    final logs = await getAll();
    return logs.where((log) => 
      log.labelIds != null && 
      labelIds.every((id) => log.labelIds!.contains(id))
    ).toList();
  }



  @override
  Future<int> deleteLogsByDateRange(
      DateTime startDate, DateTime endDate) async {
    // 实现删除指定日期范围内的通话记录的逻辑
    final logs = await getLogsByDateRange(startDate, endDate);
    for (var log in logs) {
      await delete(log);
    }
    return logs.length;
  }

  @override
  Future<List<CallLog>> getLogsByDateRange(
      DateTime startDate, DateTime endDate) async {
    // 实现获取指定日期范围内的通话记录的逻辑
    final logs = await getAll();
    return logs
        .where((log) =>
            log.timestamp.isAfter(startDate) && log.timestamp.isBefore(endDate))
        .toList();
  }



  @override
  Future<void> addLog(CallLog log) async {
    await save(log);
  }

  @override
  Future<List<CallLog>> getUnreadLogs() async {
    // 获取最近的未读通话记录
    // 由于CallLog没有isRead字段，我们使用最近的通话记录作为未读记录
    final logs = await getRecentLogs();
    // 这里可以根据实际业务需求进一步筛选
    return logs.take(10).toList();
  }

  @override
  Future<void> markAsRead(String logId) async {
    // 实现标记通话记录为已读的逻辑
    final log = await getById(logId);
    if (log != null) {
      // CallLog entity may not have isRead, so we handle it as a map
      // to stay consistent with the original logic.
      final callLogModel = await _dataSource.getById(logId);
      if (callLogModel != null) {
        final map = callLogModel.toMap();
        map['isRead'] = true;
        await _dataSource.update(CallLogModel.fromMap(map));
      }
    }
  }

  @override
  Future<void> markAllAsRead() async {
    // 实现批量标记通话记录为已读的逻辑
    final logs = await getUnreadLogs();
    for (var log in logs) {
      await markAsRead(log.id);
    }
  }

  @override
  Future<void> refreshLogs() async {
    // 刷新通话记录
    // 从系统获取最新通话记录
    // 这里需要实现与系统通话记录同步的逻辑
    // 暂时返回空实现
    return;
  }

  @override
  Stream<List<CallLog>> watchLogs() {
    return _dataSource.watchAll().map((maps) => maps.map((map) => fromMap(map)).toList());
  }
}