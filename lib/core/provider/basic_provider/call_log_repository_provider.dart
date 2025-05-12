import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/repositories/call_log_repository.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';

import 'database_service_provider.dart';

/// 通话日志仓库提供者
final callLogRepositoryProvider = Provider<CallLogRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // 返回通话日志仓库实现
  return CallLogRepositoryImpl(databaseService);
});

/// 通话日志仓库实现类
class CallLogRepositoryImpl implements CallLogRepository {
  final DatabaseService _databaseService;

  CallLogRepositoryImpl(this._databaseService);

  @override
  Future<List<CallLog>> getAll() async {
    final maps = await _databaseService.queryAll('call_logs');
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<CallLog?> getById(String id) async {
    final map = await _databaseService.queryById('call_logs', id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<CallLog> save(CallLog entity) async {
    await _databaseService.insert('call_logs', entity.toMap());
    return entity;
  }

  @override
  Future<CallLog> update(CallLog entity) async {
    await _databaseService.update('call_logs', entity.id, entity.toMap());
    return entity;
  }

  @override
  Future<bool> delete(CallLog entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('call_logs', id);
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
    return logs.where((log) => log.number == phoneNumber).toList();
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
  Stream<List<CallLog>> watchLogs() {
    // 监视通话日志变化
    // 使用数据库变更监控机制
    return _databaseService
        .watchTable('call_logs')
        .map((maps) => maps.map((map) => fromMap(map)).toList());
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
      final map = log.toMap();
      map['isRead'] = true;
      await _databaseService.update('call_logs', logId, map);
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
  Future<void> addLog(CallLog log) async {
    await save(log);
  }
}