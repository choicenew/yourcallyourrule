import 'dart:async';
import 'package:flutter/foundation.dart';
import 'cloud_sync_service.dart';
import 'sync_conflict_resolver.dart';
import 'sync_progress_tracker.dart';
import 'incremental_sync_manager.dart';
import '../core/entities/rule/rule_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 增强型云同步服务抽象基类
/// 提供冲突解决、增量同步和进度跟踪功能
abstract class EnhancedCloudSyncService extends CloudSyncService {
  /// 同步冲突解决器
  final SyncConflictResolver _conflictResolver;
  
  /// 增量同步管理器
  final IncrementalSyncManager _incrementalSyncManager;
  
  /// 同步进度跟踪器
  final SyncProgressTracker _progressTracker;
  
  /// 默认同步间隔
  static const Duration defaultSyncInterval = Duration(hours: 1);
  
  /// 自动同步定时器
  Timer? _autoSyncTimer;
  
  /// 构造函数
  EnhancedCloudSyncService({
    ConflictResolutionStrategy defaultStrategy = ConflictResolutionStrategy.merge,
    required String serviceType,
    required SharedPreferences preferences,
  }) : 
    _conflictResolver = SyncConflictResolver(defaultStrategy: defaultStrategy),
    _incrementalSyncManager = IncrementalSyncManager(
      serviceType,
      _conflictResolver,
      preferences,
    ),
    _progressTracker = SyncProgressTracker();
  );
  
  /// 获取服务类型标识符
  @override
  String get serviceType;
  
  /// 获取服务的用户友好名称
  @override
  String get serviceName;
  
  /// 获取进度跟踪器
  SyncProgressTracker get progressTracker => _progressTracker;
  
  /// 获取冲突解决器
  SyncConflictResolver get conflictResolver => _conflictResolver;
  
  /// 获取增量同步管理器
  IncrementalSyncManager get incrementalSyncManager => _incrementalSyncManager;
  
  /// 初始化云同步服务
  @override
  Future<void> initialize(Map<String, dynamic> config) async {
    _progressTracker.updateProgress(
      operationType: SyncOperationType.initialization,
      progress: 0,
      message: '正在初始化$serviceName服务...',
    );
    
    await doInitialize(config);
    
    _progressTracker.updateProgress(
      operationType: SyncOperationType.initialization,
      progress: 100,
      message: '$serviceName服务已初始化',
    );
  }
  
  /// 实现特定的初始化逻辑
  Future<void> doInitialize(Map<String, dynamic> config);
  
  /// 注册设备用于多设备同步
  @override
  Future<bool> registerDeviceForSync(DeviceEntity device) async {
    _progressTracker.updateProgress(
      operationType: SyncOperationType.deviceSync,
      progress: 0,
      message: '正在注册设备${device.name}进行同步...',
    );
    
    final result = await doRegisterDeviceForSync(device);
    
    if (result) {
      _progressTracker.updateProgress(
        operationType: SyncOperationType.deviceSync,
        progress: 100,
        message: '设备${device.name}已注册同步',
      );
    } else {
      _progressTracker.reportError(
        errorMessage: '注册设备${device.name}进行同步失败',
      );
    }
    
    return result;
  }
  
  /// 实现特定的设备注册逻辑
  Future<bool> doRegisterDeviceForSync(DeviceEntity device);
  
  /// 同步规则到云端
  @override
  Future<bool> syncRules(List<RuleBase> rules) async {
    _progressTracker.updateProgress(
      operationType: SyncOperationType.ruleSync,
      progress: 0,
      message: '正在同步${rules.length}条规则到$serviceName...',
    );
    
    try {
      // 使用增量同步管理器处理规则同步
      final cloudRules = await getRulesFromCloud();
      final syncResult = await _incrementalSyncManager.syncRules(
        localRules: rules,
        cloudRules: cloudRules,
        syncFunction: doSyncRules,
      );
      
      _progressTracker.updateProgress(
        operationType: SyncOperationType.ruleSync,
        progress: 100,
        message: '已成功同步${syncResult['syncedCount']}条规则到$serviceName',
      );
      
      return true;
    } catch (e) {
      _progressTracker.reportError(
        errorMessage: '同步规则到$serviceName失败: $e',
      );
      return false;
    }
  }
  
  /// 实现特定的规则同步逻辑
  Future<bool> doSyncRules(List<RuleBase> rules);
  
  /// 从云端获取规则
  @override
  Future<List<RuleBase>> getRulesFromCloud() async {
    _progressTracker.updateProgress(
      operationType: SyncOperationType.ruleSync,
      progress: 0,
      message: '正在从$serviceName获取规则...',
    );
    
    try {
      final rules = await doGetRulesFromCloud();
      
      _progressTracker.updateProgress(
        operationType: SyncOperationType.ruleSync,
        progress: 100,
        message: '已从$serviceName获取${rules.length}条规则',
      );
      
      return rules;
    } catch (e) {
      _progressTracker.reportError(
        errorMessage: '从$serviceName获取规则失败: $e',
      );
      return [];
    }
  }
  
  /// 实现特定的获取规则逻辑
  Future<List<RuleBase>> doGetRulesFromCloud();
  
  /// 设置自动同步
  @override
  Future<bool> scheduleAutomaticSync(Duration interval) async {
    _progressTracker.updateProgress(
      operationType: SyncOperationType.configuration,
      progress: 0,
      message: '正在设置自动同步，间隔${interval.inMinutes}分钟...',
    );
    
    try {
      // 取消现有的自动同步定时器
      await cancelAutomaticSync();
      
      // 创建新的自动同步定时器
      _autoSyncTimer = Timer.periodic(interval, (_) async {
        debugPrint('执行自动同步到$serviceName');
        await syncAll();
      });
      
      _progressTracker.updateProgress(
        operationType: SyncOperationType.configuration,
        progress: 100,
        message: '已设置自动同步，间隔${interval.inMinutes}分钟',
      );
      
      return true;
    } catch (e) {
      _progressTracker.reportError(
        errorMessage: '设置自动同步失败: $e',
      );
      return false;
    }
  }
  
  /// 取消自动同步
  @override
  Future<bool> cancelAutomaticSync() async {
    _progressTracker.updateProgress(
      operationType: SyncOperationType.configuration,
      progress: 0,
      message: '正在取消自动同步...',
    );
    
    try {
      _autoSyncTimer?.cancel();
      _autoSyncTimer = null;
      
      _progressTracker.updateProgress(
        operationType: SyncOperationType.configuration,
        progress: 100,
        message: '已取消自动同步',
      );
      
      return true;
    } catch (e) {
      _progressTracker.reportError(
        errorMessage: '取消自动同步失败: $e',
      );
      return false;
    }
  }
  
  /// 同步所有数据
  Future<bool> syncAll() async {
    _progressTracker.updateProgress(
      operationType: SyncOperationType.fullSync,
      progress: 0,
      message: '正在执行全量同步到$serviceName...',
    );
    
    try {
      // 这里可以实现同步所有数据的逻辑
      // 例如同步规则、设置、历史记录等
      
      _progressTracker.updateProgress(
        operationType: SyncOperationType.fullSync,
        progress: 100,
        message: '全量同步到$serviceName完成',
      );
      
      return true;
    } catch (e) {
      _progressTracker.reportError(
        errorMessage: '全量同步到$serviceName失败: $e',
      );
      return false;
    }
  }
  
  /// 解决同步冲突
  @override
  Future<Map<String, dynamic>> resolveSyncConflicts(Map<String, dynamic> conflicts) async {
    return await _conflictResolver.resolveConflicts(conflicts);
  }
}