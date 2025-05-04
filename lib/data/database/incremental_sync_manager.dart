// 增量同步管理器，用于处理本地和远程数据库之间的增量同步

import 'dart:async';
import 'dart:convert';

import '../models/remote/remote_number_model.dart';
import '../models/sync/sync_record_model.dart';
import 'database_service.dart';

// 增量同步管理器类
class IncrementalSyncManager {
  static final IncrementalSyncManager _instance = IncrementalSyncManager._internal();
  
  // 数据库服务
  late final DatabaseService _databaseService;
  
  // 同步状态
  bool _isSyncing = false;
  
  // 最后同步时间
  DateTime? _lastSyncTime;
  
  // 同步间隔（小时）
  final int _syncInterval = 24;
  
  // 私有构造函数
  IncrementalSyncManager._internal() {
    _databaseService = DatabaseService();
  }
  
  // 工厂构造函数
  factory IncrementalSyncManager() {
    return _instance;
  }
  
  // 初始化
  Future<void> initialize() async {
    // 确保数据库服务已初始化
    await _databaseService.initialize();
    
    // 获取最后同步时间
    _lastSyncTime = await _databaseService.remoteNumberDataSource.getLastSyncTime();
  }
  
  // 检查是否需要同步
  bool get needSync {
    if (_lastSyncTime == null) return true;
    
    final now = DateTime.now();
    final difference = now.difference(_lastSyncTime!);
    
    return difference.inHours >= _syncInterval;
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
        success = await _databaseService.remoteNumberDataSource.incrementalSync(_lastSyncTime!);
      } else {
        success = await _databaseService.remoteNumberDataSource.syncData();
      }
      
      // 如果同步成功，更新最后同步时间
      if (success) {
        _lastSyncTime = DateTime.now();
        
        // 记录同步状态
        await _recordSyncStatus(success);
      }
    } catch (e) {
      success = false;
      
      // 记录同步状态
      await _recordSyncStatus(false, error: e.toString());
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
        if (_lastSyncTime != null) {
          await _databaseService.remoteNumberDataSource.incrementalSync(_lastSyncTime!);
        } else {
          await _databaseService.remoteNumberDataSource.syncData();
        }
        
        _lastSyncTime = DateTime.now();
        
        // 记录同步状态
        await _recordSyncStatus(success, operation: 'atomic_update', phoneNumber: phoneNumber, increment: increment);
      }
    } catch (e) {
      success = false;
      
      // 记录同步状态
      await _recordSyncStatus(false, error: e.toString());
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
        if (_lastSyncTime != null) {
          await _databaseService.remoteNumberDataSource.incrementalSync(_lastSyncTime!);
        } else {
          await _databaseService.remoteNumberDataSource.syncData();
        }
        
        _lastSyncTime = DateTime.now();
        
        // 记录同步状态
        await _recordSyncStatus(true, operation: 'batch_atomic_update');
      }
    } catch (e) {
      results = {};
      
      // 记录同步状态
      await _recordSyncStatus(false, error: e.toString());
    } finally {
      _isSyncing = false;
    }
    
    return results;
  }
  
  // 记录同步状态
  Future<void> _recordSyncStatus(bool success, {String? error, String operation = 'incremental', String? phoneNumber, int? increment}) async {
    final Map<String, dynamic> metadata = {};
    
    // 添加额外的元数据信息
    if (phoneNumber != null) {
      metadata['phoneNumber'] = phoneNumber;
    }
    
    if (increment != null) {
      metadata['changeValue'] = increment.toString();
    }
    
    if (operation.contains('atomic')) {
      metadata['isAtomic'] = 'true';
    }
    
    // 将元数据转换为JSON字符串
    final String metadataJson = metadata.isNotEmpty ? jsonEncode(metadata) : '';
    
    final syncRecord = SyncRecordModel(
      id: '',
      syncTime: DateTime.now(),
      syncType: operation,
      status: success ? 'success' : 'failed',
      error: error,
      metadata: metadataJson,  // 假设SyncRecordModel已添加metadata字段
    );
    
    await _databaseService.remoteNumberDataSource.insertSyncRecord(syncRecord);
  }
  
  // 获取远程号码信息（只读操作）
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
        };
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }
  
  // 获取同步状态
  bool get isSyncing => _isSyncing;
  
  // 获取最后同步时间
  DateTime? get lastSyncTime => _lastSyncTime;
  
  // 获取同步记录
  Future<List<SyncRecordModel>> getSyncRecords({int limit = 10}) async {
    return await _databaseService.remoteNumberDataSource.getSyncRecords(limit: limit);
  }
  
  // 根据标签查询远程号码（只读操作）
  Future<List<RemoteNumberModel>> getRemoteNumbersByLabel(String label) async {
    return await _databaseService.remoteNumberDataSource.getByLabel(label);
  }
  
  // 根据优先级查询远程号码（只读操作）
  Future<List<RemoteNumberModel>> getRemoteNumbersByPriority(int priority) async {
    return await _databaseService.remoteNumberDataSource.getByPriority(priority);
  }
  
  // 根据动作查询远程号码（只读操作）
  Future<List<RemoteNumberModel>> getRemoteNumbersByAction(String action) async {
    return await _databaseService.remoteNumberDataSource.getByAction(action);
  }
  
  // 强制同步（仅在必要时使用）
  Future<bool> forceSyncAll() async {
    // 如果正在同步，返回false
    if (_isSyncing) {
      return false;
    }
    
    _isSyncing = true;
    bool success = false;
    
    try {
      success = await _databaseService.remoteNumberDataSource.syncData();
      
      // 如果同步成功，更新最后同步时间
      if (success) {
        _lastSyncTime = DateTime.now();
        
        // 记录同步状态
        await _recordSyncStatus(success);
      }
    } catch (e) {
      success = false;
      
      // 记录同步状态
      await _recordSyncStatus(false, error: e.toString());
    } finally {
      _isSyncing = false;
    }
    
    return success;
  }
}