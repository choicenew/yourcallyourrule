// 同步管理器，用于处理本地和远程数据库之间的增量同步

import 'dart:async';

import '../models/remote/remote_number_model.dart';
import 'database_service.dart';

// 同步管理器类
class SyncManager {
  static final SyncManager _instance = SyncManager._internal();
  
  // 数据库服务
  late final DatabaseService _databaseService;
  
  // 同步状态
  bool _isSyncing = false;
  
  // 最后同步时间
  DateTime? _lastSyncTime;
  
  // 私有构造函数
  SyncManager._internal() {
    _databaseService = DatabaseService();
  }
  
  // 工厂构造函数
  factory SyncManager() {
    return _instance;
  }
  
  // 初始化
  Future<void> initialize() async {
    // 确保数据库服务已初始化
    await _databaseService.initialize();
    
    // 获取最后同步时间
    _lastSyncTime = await _databaseService.remoteNumberDataSource.getLastSyncTime();
  }
  
  // 执行同步
  Future<bool> sync() async {
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
      }
    } catch (e) {
      success = false;
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
      }
    } catch (e) {
      success = false;
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
      }
    } catch (e) {
      results = {};
    } finally {
      _isSyncing = false;
    }
    
    return results;
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
  
  // 获取同步状态
  bool get isSyncing => _isSyncing;
  
  // 获取最后同步时间
  DateTime? get lastSyncTime => _lastSyncTime;
  
  // 添加远程号码（仅供管理员使用）
  Future<bool> addRemoteNumber(RemoteNumberModel remoteNumber) async {
    try {
      await _databaseService.remoteNumberDataSource.insert(remoteNumber);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // 批量添加远程号码（仅供管理员使用）
  Future<bool> addRemoteNumbers(List<RemoteNumberModel> remoteNumbers) async {
    try {
      await _databaseService.remoteNumberDataSource.insertAll(remoteNumbers);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // 根据标签查询远程号码
  Future<List<RemoteNumberModel>> getRemoteNumbersByLabel(String label) async {
    return await _databaseService.remoteNumberDataSource.getByLabel(label);
  }
  
  // 根据优先级查询远程号码
  Future<List<RemoteNumberModel>> getRemoteNumbersByPriority(int priority) async {
    return await _databaseService.remoteNumberDataSource.getByPriority(priority);
  }
  
  // 根据动作查询远程号码
  Future<List<RemoteNumberModel>> getRemoteNumbersByAction(String action) async {
    return await _databaseService.remoteNumberDataSource.getByAction(action);
  }
}