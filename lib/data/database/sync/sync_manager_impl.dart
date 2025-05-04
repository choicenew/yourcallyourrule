// 同步管理器实现类，用于处理本地和远程数据库之间的增量同步

import 'dart:async';
import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../../models/sync/sync_record_model.dart';
import '../database_service.dart';
import '../remote/remote_database_manager.dart';

// 同步管理器实现类
class SyncManagerImpl {
  static final SyncManagerImpl _instance = SyncManagerImpl._internal();
  
  // 数据库服务
  late final DatabaseService _databaseService;
  
  // 远程数据库管理器
  late final RemoteDatabaseManagerImpl _remoteDatabaseManager;
  
  // 同步状态
  bool _isSyncing = false;
  
  // 最后同步时间
  DateTime? _lastSyncTime;
  
  // 同步间隔（小时）
  final int _syncInterval = 24;
  
  // 同步类型
  static const String _syncTypeFull = 'full';
  static const String _syncTypeIncremental = 'incremental';
  
  // 同步状态
  static const String _syncStatusSuccess = 'success';
  static const String _syncStatusFailed = 'failed';
  
  // 私有构造函数
  SyncManagerImpl._internal() {
    _databaseService = DatabaseService();
    _remoteDatabaseManager = RemoteDatabaseManagerImpl();
  }
  
  // 工厂构造函数
  factory SyncManagerImpl() {
    return _instance;
  }
  
  // 初始化
  Future<void> initialize() async {
    // 确保数据库服务已初始化
    await _databaseService.initialize();
    
    // 获取最后同步时间
    _lastSyncTime = await _remoteDatabaseManager.getLastSyncTime();
  }
  
  // 检查是否需要同步
  bool get needSync {
    if (_lastSyncTime == null) return true;
    
    final now = DateTime.now();
    final difference = now.difference(_lastSyncTime!);
    
    return difference.inHours >= _syncInterval;
  }
  
  // 执行全量同步
  Future<bool> syncFull() async {
    // 如果正在同步，返回false
    if (_isSyncing) {
      return false;
    }
    
    _isSyncing = true;
    bool success = false;
    
    try {
      // 执行全量同步，使用CloudFlare D1的原子操作
      success = await _databaseService.remoteNumberDataSource.syncData();
      
      // 如果同步成功，更新最后同步时间
      if (success) {
        final now = DateTime.now();
        _lastSyncTime = now;
        await _remoteDatabaseManager.updateLastSyncTime(now);
        
        // 记录同步状态
        await _recordSyncStatus(_syncTypeFull, _syncStatusSuccess);
      }
    } catch (e) {
      success = false;
      
      // 记录同步状态
      await _recordSyncStatus(_syncTypeFull, _syncStatusFailed, error: e.toString());
    } finally {
      _isSyncing = false;
    }
    
    return success;
  }
  
  // 原子更新计数并同步
  Future<bool> atomicUpdateCountAndSync(String phoneNumber, int increment) async {
    // 如果正在同步，返回false
    if (_isSyncing) {
      return false;
    }
    
    _isSyncing = true;
    bool success = false;
    
    try {
      // 执行原子更新
      success = await _databaseService.remoteNumberDataSource.atomicUpdateCount(phoneNumber, increment);
      
      // 如果更新成功，执行同步
      if (success) {
        // 使用CloudFlare D1的原子操作进行同步
        await _databaseService.remoteNumberDataSource.syncData();
        
        final now = DateTime.now();
        _lastSyncTime = now;
        await _remoteDatabaseManager.updateLastSyncTime(now);
        
        // 记录同步状态
        await _recordSyncStatus('atomic_update', _syncStatusSuccess, metadata: {
          'phoneNumber': phoneNumber,
          'increment': increment.toString(),
          'isAtomic': 'true'
        });
      }
    } catch (e) {
      success = false;
      
      // 记录同步状态
      await _recordSyncStatus('atomic_update', _syncStatusFailed, error: e.toString());
    } finally {
      _isSyncing = false;
    }
    
    return success;
  }
  
  // 批量原子更新计数并同步
  Future<Map<String, bool>> batchAtomicUpdateCountAndSync(Map<String, int> updates) async {
    // 如果正在同步，返回空结果
    if (_isSyncing) {
      return {};
    }
    
    _isSyncing = true;
    Map<String, bool> results = {};
    
    try {
      // 执行批量原子更新
      results = await _databaseService.remoteNumberDataSource.batchAtomicUpdateCount(updates);
      
      // 如果有更新成功的项，执行同步
      if (results.values.contains(true)) {
        // 使用CloudFlare D1的原子操作进行同步
        await _databaseService.remoteNumberDataSource.syncData();
        
        final now = DateTime.now();
        _lastSyncTime = now;
        await _remoteDatabaseManager.updateLastSyncTime(now);
        
        // 记录同步状态
        await _recordSyncStatus('batch_atomic_update', _syncStatusSuccess, metadata: {
          'updatesCount': updates.length.toString(),
          'successCount': results.values.where((v) => v).length.toString(),
          'isAtomic': 'true'
        });
      }
    } catch (e) {
      results = {};
      
      // 记录同步状态
      await _recordSyncStatus('batch_atomic_update', _syncStatusFailed, error: e.toString());
    } finally {
      _isSyncing = false;
    }
    
    return results;
  }
  
  // 执行增量同步
  Future<bool> syncIncremental() async {
    // 如果正在同步，返回false
    if (_isSyncing) {
      return false;
    }
    
    _isSyncing = true;
    bool success = false;
    
    try {
      // 如果有最后同步时间，执行增量同步，否则执行全量同步
      if (_lastSyncTime != null) {
        // 使用CloudFlare D1的原子操作进行增量同步
        success = await _databaseService.remoteNumberDataSource.incrementalSync(_lastSyncTime!);
        
        // 如果同步成功，更新最后同步时间
        if (success) {
          final now = DateTime.now();
          _lastSyncTime = now;
          await _remoteDatabaseManager.updateLastSyncTime(now);
          
          // 记录同步状态
          await _recordSyncStatus(_syncTypeIncremental, _syncStatusSuccess);
        }
      } else {
        // 如果没有最后同步时间，执行全量同步
        return await syncFull();
      }
    } catch (e) {
      success = false;
      
      // 记录同步状态
      await _recordSyncStatus(_syncTypeIncremental, _syncStatusFailed, error: e.toString());
    } finally {
      _isSyncing = false;
    }
    
    return success;
  }
  
  // 记录同步状态
  Future<void> _recordSyncStatus(String syncType, String status, {String? error, Map<String, String>? metadata}) async {
    // 将元数据转换为JSON字符串
    final String? metadataJson = metadata != null ? jsonEncode(metadata) : null;
    
    // 创建同步记录
    final syncRecord = SyncRecordModel(
      id: const Uuid().v4(),
      syncTime: DateTime.now(),
      syncType: syncType,
      status: status,
      error: error,
      metadata: metadataJson,
    );
    
    // 插入同步记录
    await _databaseService.remoteNumberDataSource.insertSyncRecord(syncRecord);
  }
  
  // 获取远程号码信息
  Future<Map<String, dynamic>?> getRemoteNumberInfo(String phoneNumber) async {
    try {
      // 查询远程号码
      final remoteNumber = await _databaseService.remoteNumberDataSource.getByPhoneNumber(phoneNumber);
      
      // 如果找到远程号码，返回相关信息
      if (remoteNumber != null) {
        return {
          'name': remoteNumber.name,
          'label': remoteNumber.label,
          'priority': remoteNumber.priority,
          'action': remoteNumber.action,
          'count': remoteNumber.count,  // 新增count字段
        };
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }
  
  // 获取同步记录
  Future<List<SyncRecordModel>> getSyncRecords({int limit = 10}) async {
    final records = await _remoteDatabaseManager.getSyncRecords(limit: limit);
    
    return records.map((record) => SyncRecordModel(
      id: record['id'],
      syncTime: DateTime.parse(record['syncTime']),
      syncType: record['syncType'],
      status: record['status'],
      error: record['error'],
    )).toList();
  }
  
  // 获取同步状态
  bool get isSyncing => _isSyncing;
  
  // 获取最后同步时间
  DateTime? get lastSyncTime => _lastSyncTime;
  
  // 获取同步间隔
  int get syncInterval => _syncInterval;
  
  // 导出远程数据（禁止使用）
  Future<Map<String, dynamic>> exportRemoteData() async {
    throw UnsupportedError('远程数据不支持导出操作');
  }
}