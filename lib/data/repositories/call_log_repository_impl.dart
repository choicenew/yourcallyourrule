import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/repositories/call_log_repository.dart';
import '../models/call/call_log_model.dart';
import 'base_repository_impl.dart';

class CallLogRepositoryImpl extends BaseRepositoryImpl<CallLog, CallLogModel, String> 
    implements CallLogRepository {
  CallLogRepositoryImpl(super.dataSource);

  @override
  CallLogModel toModel(CallLog entity) => CallLogModel.fromEntity(entity);

  @override
  CallLog toEntity(CallLogModel model) => model.toEntity();

  @override
  Future<int> count() async {
    return dataSource.count();
  }

  @override
  CallLog fromMap(Map<String, dynamic> map) {
    return CallLogModel.fromMap(map).toEntity();
  }

  @override
  Future<CallLog> update(CallLog entity) async {
    final model = toModel(entity);
    final updatedModel = await dataSource.update(model);
    return toEntity(updatedModel);
  }

  @override
  Future<List<CallLog>> getRecentLogs() async {
    final models = await dataSource.getAll();
    return models.map((model) => toEntity(model as CallLogModel)).toList();
  }

  @override
  Future<List<CallLog>> getLogsByPhoneNumber(String phoneNumber) async {
    final models = await dataSource.getAll();
    return models
        .map((model) => toEntity(model as CallLogModel))
        .where((log) => log.number == phoneNumber)
        .toList();
  }

  @override
  Stream<List<CallLog>> watchLogs() async* {
    final models = await dataSource.getAll();
    yield models.map((model) => toEntity(model as CallLogModel)).toList();
  }

  @override
  Future<void> refreshLogs() async {
    await dataSource.refresh();
  }

  @override
  Future<void> addLog(CallLog log) async {
    final model = toModel(log);
    await dataSource.save(model);
  }
  
  @override
  Future<int> deleteLogsByDateRange(DateTime startDate, DateTime endDate) async {
    final models = await dataSource.getAll();
    final logsToDelete = models
        .map((model) => toEntity(model as CallLogModel))
        .where((log) => log.timestamp.isAfter(startDate) && log.timestamp.isBefore(endDate))
        .toList();
    
    int count = 0;
    for (var log in logsToDelete) {
      final success = await deleteById(log.id);
      if (success) count++;
    }
    
    return count;
  }
  
  @override
  Future<List<CallLog>> getLogsByDateRange(DateTime startDate, DateTime endDate) async {
    final models = await dataSource.getAll();
    return models
        .map((model) => toEntity(model as CallLogModel))
        .where((log) => log.timestamp.isAfter(startDate) && log.timestamp.isBefore(endDate))
        .toList();
  }
  
  @override
  Future<List<CallLog>> getUnreadLogs() async {
    // 假设通话记录有一个isRead字段，如果没有，需要在CallLog实体中添加
    final models = await dataSource.getAll();
    return models
        .map((model) => toEntity(model as CallLogModel))
        .where((log) => !(log as dynamic).isRead)
        .toList();
  }
  
  @override
  Future<void> markAsRead(String logId) async {
    final log = await getById(logId);
    if (log != null) {
      final updatedLog = (log as dynamic).copyWith(isRead: true);
      await update(updatedLog);
    }
  }
  
  @override
  Future<void> markAllAsRead() async {
    final unreadLogs = await getUnreadLogs();
    for (var log in unreadLogs) {
      await markAsRead(log.id);
    }
  }
  
  @override
  Future<List<CallLog>> getLogsByLabelId(String labelId) async {
    final models = await dataSource.getAll();
    return models
        .map((model) => toEntity(model as CallLogModel))
        .where((log) {
          // 获取通话记录的标签ID列表
          final labelIds = (log as dynamic).labelIds ?? [];
          // 检查是否包含指定的标签ID
          return labelIds.contains(labelId);
        })
        .toList();
  }
  
  @override
  Future<List<CallLog>> getLogsWithAnyLabels(List<String> labelIds) async {
    final models = await dataSource.getAll();
    return models
        .map((model) => toEntity(model as CallLogModel))
        .where((log) {
          // 获取通话记录的标签ID列表
          final logLabelIds = (log as dynamic).labelIds ?? [];
          // 检查是否包含任意一个指定的标签ID
          return labelIds.any((labelId) => logLabelIds.contains(labelId));
        })
        .toList();
  }
  
  @override
  Future<List<CallLog>> getLogsWithAllLabels(List<String> labelIds) async {
    final models = await dataSource.getAll();
    return models
        .map((model) => toEntity(model as CallLogModel))
        .where((log) {
          // 获取通话记录的标签ID列表
          final logLabelIds = (log as dynamic).labelIds ?? [];
          // 检查是否包含所有指定的标签ID
          return labelIds.every((labelId) => logLabelIds.contains(labelId));
        })
        .toList();
  }

    }
  
 
 
 
 
 
 
 
 
