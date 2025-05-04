// 远程数据源接口，扩展通用数据源接口，添加同步相关方法

import 'dart:async';

import '../../models/sync/sync_record_model.dart';
import '../datasource_interface.dart';

// 远程数据源接口
abstract class RemoteDataSourceInterface<T> extends RemoteDataSource<T> {
  // 增量同步
  @override
  Future<bool> incrementalSync(DateTime lastSyncTime);
  
  // 获取同步记录
  Future<List<SyncRecordModel>> getSyncRecords({int limit = 10});
  
  // 插入同步记录
  Future<String> insertSyncRecord(SyncRecordModel syncRecord);
  
  // 检查是否需要同步
  Future<bool> needSync(int syncIntervalHours);
  
  // 获取最后一次同步记录
  Future<SyncRecordModel?> getLastSyncRecord();
  
  // 原子更新计数
  Future<bool> atomicUpdateCount(String phoneNumber, int increment);
  
  // 原子增加计数
  Future<int> atomicIncrementCount(String id, int incrementValue);
  
  // 批量原子更新计数
  Future<Map<String, bool>> batchAtomicUpdateCount(Map<String, int> updates);
}